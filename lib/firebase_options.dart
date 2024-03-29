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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAPWH8R7T2yJxhW720-9q7LHS1aTunCAok',
    appId: '1:1039697642740:android:cb60e93616abbc1ee40aa1',
    messagingSenderId: '1039697642740',
    projectId: 'daniknews',
    databaseURL: 'https://daniknews-default-rtdb.firebaseio.com',
    storageBucket: 'daniknews.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDVKYX4BBPw1nZ7U1D9nkgTvgIWLQZ5qMs',
    appId: '1:1039697642740:ios:6a6745648f3c68a4e40aa1',
    messagingSenderId: '1039697642740',
    projectId: 'daniknews',
    databaseURL: 'https://daniknews-default-rtdb.firebaseio.com',
    storageBucket: 'daniknews.appspot.com',
    androidClientId: '1039697642740-7q8qir99o7i7dgd2jhc0q1ief03cbd9f.apps.googleusercontent.com',
    iosClientId: '1039697642740-30gr3v5n0v03bdh2pfaajm539ji0ao8u.apps.googleusercontent.com',
    iosBundleId: 'com.daniknews.daniknews',
  );
}
