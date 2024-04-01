// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyAZe1z8z_xtvgdFxCLNlLLkVJKEC5weHQc',
    appId: '1:859490170130:web:36fc6d2e45a27bca98afcb',
    messagingSenderId: '859490170130',
    projectId: 'park-humans',
    authDomain: 'park-humans.firebaseapp.com',
    databaseURL: 'https://park-humans-default-rtdb.firebaseio.com',
    storageBucket: 'park-humans.appspot.com',
    measurementId: 'G-EQBB1F310D',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBfVnYmHqSKaCA8eBAaOxOlpCi6U0RIGB8',
    appId: '1:859490170130:android:dd57cefdfead3d1b98afcb',
    messagingSenderId: '859490170130',
    projectId: 'park-humans',
    databaseURL: 'https://park-humans-default-rtdb.firebaseio.com',
    storageBucket: 'park-humans.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC242L3_uF4nsP1hQ6tXF-zw8QbUYicwwQ',
    appId: '1:859490170130:ios:4c2a7154e67200c598afcb',
    messagingSenderId: '859490170130',
    projectId: 'park-humans',
    databaseURL: 'https://park-humans-default-rtdb.firebaseio.com',
    storageBucket: 'park-humans.appspot.com',
    iosBundleId: 'com.example.phproject',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyC242L3_uF4nsP1hQ6tXF-zw8QbUYicwwQ',
    appId: '1:859490170130:ios:783228340836794d98afcb',
    messagingSenderId: '859490170130',
    projectId: 'park-humans',
    databaseURL: 'https://park-humans-default-rtdb.firebaseio.com',
    storageBucket: 'park-humans.appspot.com',
    iosBundleId: 'com.example.phproject.RunnerTests',
  );
}
