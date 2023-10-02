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
    apiKey: 'AIzaSyCU-mxeOaHQW4m01rUBmcDs3Ib975r1-H0',
    appId: '1:771529767292:web:6336abf2a8a138e5e88cf9',
    messagingSenderId: '771529767292',
    projectId: 'gadget-express-99121',
    authDomain: 'gadget-express-99121.firebaseapp.com',
    storageBucket: 'gadget-express-99121.appspot.com',
    measurementId: 'G-PKQ3KB0S47',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBQj3VdzZdqTSOEOjPTi5ahLkSnQDxONCw',
    appId: '1:771529767292:android:9a690649d886969ee88cf9',
    messagingSenderId: '771529767292',
    projectId: 'gadget-express-99121',
    storageBucket: 'gadget-express-99121.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAyWIqImBumWE9KQYqvB89p8JXgHl8v-8I',
    appId: '1:771529767292:ios:c7bfb9275a1db307e88cf9',
    messagingSenderId: '771529767292',
    projectId: 'gadget-express-99121',
    storageBucket: 'gadget-express-99121.appspot.com',
    iosClientId: '771529767292-0ubse6othbdkmt7jmi2u2ro6btht6i2b.apps.googleusercontent.com',
    iosBundleId: 'com.example.gadgetExpress',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAyWIqImBumWE9KQYqvB89p8JXgHl8v-8I',
    appId: '1:771529767292:ios:27c2e624c78fb333e88cf9',
    messagingSenderId: '771529767292',
    projectId: 'gadget-express-99121',
    storageBucket: 'gadget-express-99121.appspot.com',
    iosClientId: '771529767292-vi20k8s86dr4jmdlogbueq6f9rj9nu7s.apps.googleusercontent.com',
    iosBundleId: 'com.example.gadgetExpress.RunnerTests',
  );
}
