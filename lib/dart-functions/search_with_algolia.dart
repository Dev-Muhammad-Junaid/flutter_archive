// import 'package:flutter/material.dart';
//
//
// ///
// /// Initiate static Algolia once in your project.
// ///
// class Application {
//   static final Algolia algolia = Algolia.init(
//     applicationId: 'YOUR_APPLICATION_ID',
//     apiKey: 'YOUR_API_KEY',
//   );
// }
//
// void main() async {
//   ///
//   /// Initiate Algolia in your project
//   ///
//   Algolia algolia = Application.algolia;
//
//   ///
//   /// Perform Query
//   ///
//   AlgoliaQuery query = algolia.instance.index('contacts').query('john');
//
//   // Perform multiple facetFilters
//   query = query.facetFilter('status:published');
//   query = query.facetFilter('isDelete:false');
//
//   // Get Result/Objects
//   AlgoliaQuerySnapshot snap = await query.getObjects();
//
//   // Checking if has [AlgoliaQuerySnapshot]
//   print('Hits count: ${snap.nbHits}');
//
//   ///
//   /// Perform Index Settings
//   ///
//   AlgoliaIndexSettings settingsRef = algolia.instance.index('contact').settings;
//
//   // Get Settings
//   Map<String, dynamic> currentSettings = await settingsRef.getSettings();
//
//   // Checking if has [Map]
//   print('\n\n');
//   print(currentSettings);
//
//   // Set Settings
//   AlgoliaSettings settingsData = settingsRef;
//   settingsData = settingsData.setReplicas(const ['index_copy_1', 'index_copy_2']);
//   AlgoliaTask setSettings = await settingsData.setSettings();
//
//   // Checking if has [AlgoliaTask]
//   print('\n\n');
//   print(setSettings.data);
//
//   // Pushing Event
//   AlgoliaEvent event = AlgoliaEvent(
//     eventType: AlgoliaEventType.view,
//     eventName: 'View contact',
//     index: 'contacts',
//     userToken: 'user123',
//   );
//   await algolia.instance.pushEvents([event]);
// }