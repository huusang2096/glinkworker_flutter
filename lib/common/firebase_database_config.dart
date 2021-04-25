// import 'dart:io';

// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter_map_booking/common/config.dart';

// class FirebaseDatabaseConfig {
//   static Future<FirebaseDatabaseConfig> init() async {
//     final notificationService = FirebaseDatabaseConfig();
//     await notificationService.setupFirebaseDatabase();
//     return notificationService;
//   }

//   FirebaseApp firebaseDatabase;

//   setupFirebaseDatabase() async {
//     if (firebaseDatabase == null) {
//       firebaseDatabase = await Firebase.initializeApp(
//           name: FIREBASE_DATABASE_NAME,
//           options: FirebaseOptions(
//               appId: Platform.isIOS ? FIREBASE_IOS_ID : FIREBASE_ANDROID_ID,
//               apiKey: FIREBASE_KEY,
//               messagingSenderId: FIREBASE_SENDER_ID,
//               projectId: FIREBASE_PROJECT_ID,
//               databaseURL: FIREBASE_URL));
//     }
//   }
// }
