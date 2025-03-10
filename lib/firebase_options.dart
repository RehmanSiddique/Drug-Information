// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAtYCoHl9zjeyYgqogIUpIWv95lLxuJV5s',
    appId: '1:674349379080:web:7a3c5831f656e08461abbd',
    messagingSenderId: '674349379080',
    projectId: 'drug-information-e6d08',
    authDomain: 'drug-information-e6d08.firebaseapp.com',
    storageBucket: 'drug-information-e6d08.firebasestorage.app',
    measurementId: 'G-J29TZCEPS4',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDZ9Z2qSSa7xIR4dUS1OC9kSF1tM2B9GYo',
    appId: '1:674349379080:android:0856952ed2ab9d1761abbd',
    messagingSenderId: '674349379080',
    projectId: 'drug-information-e6d08',
    storageBucket: 'drug-information-e6d08.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAHG6br8FF3TE0EHhelLIuNHmxWZ5Qn2-w',
    appId: '1:674349379080:ios:b04ff35acb38988a61abbd',
    messagingSenderId: '674349379080',
    projectId: 'drug-information-e6d08',
    storageBucket: 'drug-information-e6d08.firebasestorage.app',
    iosBundleId: 'com.example.drugApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAHG6br8FF3TE0EHhelLIuNHmxWZ5Qn2-w',
    appId: '1:674349379080:ios:b04ff35acb38988a61abbd',
    messagingSenderId: '674349379080',
    projectId: 'drug-information-e6d08',
    storageBucket: 'drug-information-e6d08.firebasestorage.app',
    iosBundleId: 'com.example.drugApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAtYCoHl9zjeyYgqogIUpIWv95lLxuJV5s',
    appId: '1:674349379080:web:9aefabaa3d4e013261abbd',
    messagingSenderId: '674349379080',
    projectId: 'drug-information-e6d08',
    authDomain: 'drug-information-e6d08.firebaseapp.com',
    storageBucket: 'drug-information-e6d08.firebasestorage.app',
    measurementId: 'G-4V1RC9DGN7',
  );
}
