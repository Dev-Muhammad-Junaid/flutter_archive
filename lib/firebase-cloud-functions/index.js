 const functions = require('firebase-functions');
 const axios = require('axios');

 exports.helloWorld = functions.https.onRequest((request, response) => {
     response.send("Welcome to Cloud Functions");
 });

 //HTTP Request
 exports.api = functions.https.onRequest(async (request, response) => {
     switch (request.method) {
         case 'GET':
             const res = await axios.get('https://jsonplaceholder.typicode.com/users/1');
             response.send(res.data);
             break;
         case 'POST':
             const body = request.body;
             response.send(body);
             break;
         case 'DELETE':
             response.send("DELETE REQUEST");
             break;
         default:
             response.send("Default Request");
     }
 });


 //User Deleted
 exports.userAdded = functions.auth.user().onCreate(user => {
     console.log(`${user.email} is created`);
     return Promise.resolve();
 });

 // User Deleted
 exports.userDeleted = functions.auth.user().onDelete(user => {
     console.log(`${user.email} is deleted`);
     return Promise.resolve();
 });

 // Cloud Firestore Triggers (Create, Update, Delete)
 exports.fruitAdded = functions.firestore.document(`/fruits/{documentId}`).onCreate((snapshot, context) => {
     console.log(snapshot.data(),"is created");
     const myname = snapshot.data();
     console.log("My Name is : ",myname.name);
     return Promise.resolve();
 });


 exports.fruitUpdated = functions.firestore.document(`/fruits/{documentId}`).onUpdate((snapshot, context) => {
     console.log("Before : ",snapshot.before.data());
     console.log("After : ",snapshot.after.data());
     return Promise.resolve();
 });


 exports.fruitDeleted = functions.firestore.document(`/fruits/{documentId}`).onDelete((snapshot, context) => {
     console.log(snapshot.data(), "is deleted");
     return Promise.resolve();
 });

 //Scheduled Functions [Every x minutes]

 exports.scheduledFunctions = functions.pubsub.schedule('* * * * *').onRun(context => {
     console.log('I am running every minute');
     return null;
 })

 //Calling HTTP Cloud function from Another function

 exports.sendNotification = functions.firestore.document(`/fruits/{documentId}`)
 .onWrite((snapshot,context) => {
     console.log("Something happend");
     //http call
     fetch('{baseURL}/{project-id}/{project-location}/{functionName}')
     .then(response => response.text())
     .then(data => {
       console.log(data); // Output: "Welcome to Cloud Functions"
     })
     .catch(error => {
       console.error('Error:', error);
     });
     return Promise.resolve();
 });