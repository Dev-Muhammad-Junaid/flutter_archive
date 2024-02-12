// const functions = require('firebase-functions');
// const axios = require('axios');

// exports.helloWorld = functions.https.onRequest((request, response) => {
//     response.send("Welcome to Cloud Functions");
// });

// //HTTP Request
// exports.api = functions.https.onRequest(async (request, response) => {
//     switch (request.method) {
//         case 'GET':
//             const res = await axios.get('https://jsonplaceholder.typicode.com/users/1');
//             response.send(res.data);
//             break;
//         case 'POST':
//             const body = request.body;
//             response.send(body);
//             break;
//         case 'DELETE':
//             response.send("DELETE REQUEST");
//             break;
//         default:
//             response.send("Default Request");
//     }
// });


// //User Deleted
// exports.userAdded = functions.auth.user().onCreate(user => {
//     console.log(`${user.email} is created`);
//     return Promise.resolve();
// });

// // User Deleted
// exports.userDeleted = functions.auth.user().onDelete(user => {
//     console.log(`${user.email} is deleted`);
//     return Promise.resolve();
// });

// // Cloud Firestore Triggers (Create, Update, Delete)
// exports.fruitAdded = functions.firestore.document(`/fruits/{documentId}`).onCreate((snapshot, context) => {
//     console.log(snapshot.data(),"is created");
//     const myname = snapshot.data();
//     console.log("My Name is : ",myname.name);
//     return Promise.resolve();
// });


// exports.fruitUpdated = functions.firestore.document(`/fruits/{documentId}`).onUpdate((snapshot, context) => {
//     console.log("Before : ",snapshot.before.data());
//     console.log("After : ",snapshot.after.data());
//     return Promise.resolve();
// });


// exports.fruitDeleted = functions.firestore.document(`/fruits/{documentId}`).onDelete((snapshot, context) => {
//     console.log(snapshot.data(), "is deleted");
//     return Promise.resolve();
// });

// //Scheduled Functions [Every x minutes]

// exports.scheduledFunctions = functions.pubsub.schedule('* * * * *').onRun(context => {
//     console.log('I am running every minute');
//     return null;
// })

// //Calling HTTP Cloud function from Another function

// exports.sendNotification = functions.firestore.document(`/fruits/{documentId}`)
// .onWrite((snapshot,context) => {
//     console.log("Something happend");
//     //http call
//     fetch('http://127.0.0.1:5001/spiphy-app-x4ah3a/us-central1/helloWorld')
//     .then(response => response.text())
//     .then(data => {
//       console.log(data); // Output: "Welcome to Cloud Functions"
//     })
//     .catch(error => {
//       console.error('Error:', error);
//     });
//     return Promise.resolve();
// });


const functions = require("firebase-functions");
const admin = require("firebase-admin");
admin.initializeApp();

const kFcmTokensCollection = "fcm_tokens";
const kPushNotificationsCollection = "notifications";
const kSchedulerIntervalMinutes = 60;
const firestore = admin.firestore();

const kPushNotificationRuntimeOpts = {
  timeoutSeconds: 540,
  memory: "2GB"
};

exports.addFcmToken = functions.https.onCall(async (data, context) => {
  if (!context.auth) {
    return "Failed: Unauthenticated calls are not allowed.";
  }
  const userDocPath = data.userDocPath;
  const fcmToken = data.fcmToken;
  const deviceType = data.deviceType;
  if (
    typeof userDocPath === "undefined" ||
    typeof fcmToken === "undefined" ||
    typeof deviceType === "undefined" ||
    userDocPath.split("/").length <= 1 ||
    fcmToken.length === 0 ||
    deviceType.length === 0
  ) {
    return "Invalid arguments encoutered when adding FCM token.";
  }
  if (context.auth.uid != userDocPath.split("/")[1]) {
    return "Failed: Authenticated user doesn't match user provided.";
  }
  const existingTokens = await firestore
    .collectionGroup(kFcmTokensCollection)
    .where("fcm_token", "==", fcmToken)
    .get();
  var userAlreadyHasToken = false;
  for (var doc of existingTokens.docs) {
    const user = doc.ref.parent.parent;
    if (user.path != userDocPath) {
      // Should never have the same FCM token associated with multiple users.
      await doc.ref.delete();
    } else {
      userAlreadyHasToken = true;
    }
  }
  if (userAlreadyHasToken) {
    return "FCM token already exists for this user. Ignoring...";
  }
  await getUserFcmTokensCollection(userDocPath).doc().set({
    fcm_token: fcmToken,
    device_type: deviceType,
    created_at: admin.firestore.FieldValue.serverTimestamp(),
  });
  return "Successfully added FCM token!";
});

/* To be confirmed if this function will even be called or not. Since I am only creating a notification document.
 the rest has to be managed by pub/sub that will trigger every 60 min and check for notifications to be sent */
exports.sendPushNotificationsTrigger = functions
  .runWith(kPushNotificationRuntimeOpts)
  .firestore.document(`${kPushNotificationsCollection}/{id}`)
  .onWrite(async (snapshotx, _) => {
    try {

      console.log("Notification Written");
      // Send push notifications that we've scheduled.
      const scheduledNotifications = await firestore
        .collection(kPushNotificationsCollection)
        .where("c_status", "=", "active")
        .get();

      for (var snapshot of scheduledNotifications.docs) {
        try {
          // Check reminder type
          const notificationData = snapshot.data();
          const docRef = snapshot.ref;
          await checkReminderType(notificationData.reminder_type, notificationData.last_sent, notificationData.scheduled_time, docRef, snapshot);
        } catch (e) {
          console.log(`Error: ${e}`);
        }
      }
      //----------------------------
    } catch (e) {
      console.log(`Error: ${e}`);
    }
  });


exports.sendScheduledPushNotifications = functions.pubsub
  .schedule(`every ${kSchedulerIntervalMinutes} minutes synchronized`)
  .onRun(async (_) => {

    try {
      
      // Fetch push notifications that are active .
      const scheduledNotifications = await firestore
        .collection(kPushNotificationsCollection)
        .where("c_status", "=", "active")
        .get();

      if (scheduledNotifications.docs.length === 0) {
        functions.logger.info('No active push notifications to send.');
        return; // Exit the function if no active notifications
      }
      //Check each notification to be sent if now is the time
      for (var snapshot of scheduledNotifications.docs) {
        try {
          // Check reminder type
          const notificationData = snapshot.data();
          functions.logger.info("Date Fetched : ", notificationData);
          const docRef = snapshot.ref;
          await checkReminderType(notificationData.reminder_type, notificationData.last_sent, notificationData.scheduled_time, docRef, snapshot);
        } catch (e) {
          functions.logger.info(`Error: ${e}`);
        }
      }
    } catch (e) {
      functions.logger.info(`Error: ${e}`);
    }
  });

async function sendPushNotifications(snapshot) {
  const notificationData = snapshot.data();
  const title = notificationData.notification_title || "";
  const body = notificationData.notification_text || "";
  const imageUrl = notificationData.notification_image_url || "";
  const sound = notificationData.notification_sound || "";
  const parameterData = notificationData.parameter_data || "";
  const targetAudience = notificationData.target_audience || "";
  const initialPageName = notificationData.initial_page_name || "";
  const userRefsStr = notificationData.user_refs || "";
  const batchIndex = notificationData.batch_index || 0;
  const numBatches = notificationData.num_batches || 0;
  const status = notificationData.status || "";



  // if (title === "" || body === "") {
  //   await snapshot.ref.update({ status: "failed" });
  //   return;
  // }

  const userRefs = userRefsStr === "" ? [] : userRefsStr.trim().split(",");
  var tokens = new Set();
  if (userRefsStr) {
    for (var userRef of userRefs) {
      const userTokens = await firestore
        .doc(userRef)
        .collection(kFcmTokensCollection)
        .get();
      userTokens.docs.forEach((token) => {
        if (typeof token.data().fcm_token !== undefined) {
          tokens.add(token.data().fcm_token);
        }
      });
    }
  } else {
    var userTokensQuery = firestore.collectionGroup(kFcmTokensCollection);
    // Handle batched push notifications by splitting tokens up by document
    // id.
    if (numBatches > 0) {
      userTokensQuery = userTokensQuery
        .orderBy(admin.firestore.FieldPath.documentId())
        .startAt(getDocIdBound(batchIndex, numBatches))
        .endBefore(getDocIdBound(batchIndex + 1, numBatches));
    }
    const userTokens = await userTokensQuery.get();
    userTokens.docs.forEach((token) => {
      const data = token.data();
      const audienceMatches =
        targetAudience === "All" || data.device_type === targetAudience;
      if (audienceMatches || typeof data.fcm_token !== undefined) {
        tokens.add(data.fcm_token);
      }
    });
  }

  const tokensArr = Array.from(tokens);
  var messageBatches = [];
  for (let i = 0; i < tokensArr.length; i += 500) {
    const tokensBatch = tokensArr.slice(i, Math.min(i + 500, tokensArr.length));
    const messages = {
      notification: {
        title,
        body,
        ...(imageUrl && { imageUrl: imageUrl }),
      },
      data: {
        initialPageName,
        parameterData
      },
      android: {
        notification: {
          ...(sound && { sound: sound }),
        },
      },
      apns: {
        payload: {
          aps: {
            ...(sound && { sound: sound }),
          },
        },
      },
      tokens: tokensBatch,
    };
    messageBatches.push(messages);
  }

  var numSent = 0;
  await Promise.all(
    messageBatches.map(async (messages) => {
      const response = await admin.messaging().sendMulticast(messages);
      numSent += response.successCount;
    })
  );

  await snapshot.ref.update({ status: "succeeded", num_sent: numSent, last_sent: new Date() });
}

function getUserFcmTokensCollection(userDocPath) {
  return firestore.doc(userDocPath).collection(kFcmTokensCollection);
}

function getDocIdBound(index, numBatches) {
  if (index <= 0) {
    return "users/(";
  }
  if (index >= numBatches) {
    return "users/}";
  }
  const numUidChars = 62;
  const twoCharOptions = Math.pow(numUidChars, 2);

  var twoCharIdx = (index * twoCharOptions) / numBatches;
  var firstCharIdx = Math.floor(twoCharIdx / numUidChars);
  var secondCharIdx = Math.floor(twoCharIdx % numUidChars);
  const firstChar = getCharForIndex(firstCharIdx);
  const secondChar = getCharForIndex(secondCharIdx);
  return "users/" + firstChar + secondChar;
}

function getCharForIndex(charIdx) {
  if (charIdx < 10) {
    return String.fromCharCode(charIdx + "0".charCodeAt(0));
  } else if (charIdx < 36) {
    return String.fromCharCode("A".charCodeAt(0) + charIdx - 10);
  } else {
    return String.fromCharCode("a".charCodeAt(0) + charIdx - 36);
  }
}


async function checkReminderType(reminder_type, last_sent, scheduled_time, docRef, snapshot) {
  console.log("-------------------");

  console.log("Received");
  //If last date is empty then check difference from current date;
  const lastSentDate = last_sent ? new Date(last_sent.seconds * 1000) : new Date();
  const scheduledDate = new Date(scheduled_time.seconds * 1000);

  const n_LastSentDate = new Date(lastSentDate.getFullYear(), lastSentDate.getMonth(), lastSentDate.getDate());
  const n_ScheduledDate = new Date(scheduledDate.getFullYear(), scheduledDate.getMonth(), scheduledDate.getDate());
  console.log("Last Sent : ", n_LastSentDate);
  console.log("Scheduled : ", n_ScheduledDate);


  const today = new Date(new Date().setHours(0, 0, 0, 0));

  if (today < n_ScheduledDate) {
    functions.logger.info("Current date is before the scheduled start date.");
    console.log("-------------------");
    return; // Exit the function as it's not yet time to start sending notifications
  }

  if (n_LastSentDate.getTime() === today.getTime()) {
    functions.logger.info("Notification Already Sent Today");
    console.log("-------------------");
    return;
  }
  if (reminder_type === 'Daily') {
    const differenceInDays = Math.ceil(Math.abs(n_ScheduledDate - n_LastSentDate) / (1000 * 3600 * 24));

    if (differenceInDays >= 1) {
      functions.logger.info("Days Difference  : ", differenceInDays);
      await sendPushNotifications(snapshot); //also pass the reminder type used
      functions.logger.info("Daily reminder sent and last_sent updated.");
    }
    else functions.logger.info("Avoid Daily : ", differenceInDays);

  }
  else if (reminder_type === 'Weekly') {

    const differenceInDays = Math.ceil(Math.abs((n_ScheduledDate - n_LastSentDate) / (1000 * 3600 * 24)));

    if (differenceInDays >= 7) {
      functions.logger.info("Days Difference : ", differenceInDays);
      await sendPushNotifications(snapshot); //also pass the reminder type used
      functions.logger.info("Weekly reminder sent and last_sent updated.");

    }
    else functions.logger.info("Avoid Weekly:  ", differenceInDays);
  }
  else if (reminder_type === 'Monthly') {
    // Check if at least a month has passed
    let nextMonthDate = new Date(n_LastSentDate.getFullYear(), n_LastSentDate.getMonth() + 1, n_LastSentDate.getDate());

    if (today >= nextMonthDate) {
      functions.logger.info("Time to Send Monthly Reminder : ", nextMonthDate);
      await sendPushNotifications(snapshot);
      functions.logger.info("Monthly reminder sent and last_sent updated.");
    } else {
      functions.logger.info("Avoid Monthly reminder.", nextMonthDate);
    }
  }
  else if (reminder_type === 'Quarterly') {
    console.log("Comming Soon");

  }
  else if (reminder_type === 'Annually') {

    console.log("Comming Soon");
  }
  else {
    console.log("Reminder Type doesn't exists");
  }
}
