// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart' show defaultTargetPlatform, kIsWeb, TargetPlatform;

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
    apiKey: 'AIzaSyBZg-O8WyWvycv46M80PwY1KKpcUa5d-q8',
    appId: '1:467739299542:web:aafac020c6e902c9b64377',
    messagingSenderId: '467739299542',
    projectId: 'prompter-32d5d',
    authDomain: 'prompter-32d5d.firebaseapp.com',
    storageBucket: 'prompter-32d5d.appspot.com',
    measurementId: 'G-6BQJHRRERJ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAIjjy2va_nbpkSYdXGZPqL96r7st9I1Rs',
    appId: '1:467739299542:android:b285bc477797bddcb64377',
    messagingSenderId: '467739299542',
    projectId: 'prompter-32d5d',
    storageBucket: 'prompter-32d5d.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCM61stAykytLpmAFBdTx1IzKlkWi668Ok',
    appId: '1:467739299542:ios:fa3b89a8ddb94d26b64377',
    messagingSenderId: '467739299542',
    projectId: 'prompter-32d5d',
    storageBucket: 'prompter-32d5d.appspot.com',
    iosClientId: '467739299542-lcfe3eedcpobkd4uc8lefjjm7hca47j3.apps.googleusercontent.com',
    iosBundleId: 'com.stormx.prompter',
  );

}