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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyCx5EwQOctKRr69-v2wXyXbcQHr6k81Y9w',
    appId: '1:469060364270:web:e2a4d61ca88c2c2afad0ff',
    messagingSenderId: '469060364270',
    projectId: 'eureka-9db34',
    authDomain: 'eureka-9db34.firebaseapp.com',
    databaseURL: 'https://eureka-9db34-default-rtdb.firebaseio.com',
    storageBucket: 'eureka-9db34.appspot.com',
    measurementId: 'G-8TYGCPE2JN',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB7XkkOF2xi7MfHvNvtEXxQVq_as5T8hUU',
    appId: '1:469060364270:android:2d5845baf1720748fad0ff',
    messagingSenderId: '469060364270',
    projectId: 'eureka-9db34',
    databaseURL: 'https://eureka-9db34-default-rtdb.firebaseio.com',
    storageBucket: 'eureka-9db34.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDootw0XddYveEubUz8zWcSFxyQGDpiCa8',
    appId: '1:469060364270:ios:e34a891d8caecf0ffad0ff',
    messagingSenderId: '469060364270',
    projectId: 'eureka-9db34',
    databaseURL: 'https://eureka-9db34-default-rtdb.firebaseio.com',
    storageBucket: 'eureka-9db34.appspot.com',
    iosClientId: '469060364270-7tqh35lg43u17hulbkg3b3qq9khh5oni.apps.googleusercontent.com',
    iosBundleId: 'com.example.schoolManagement',
  );
}
