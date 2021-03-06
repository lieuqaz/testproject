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
    apiKey: 'AIzaSyBel9LhD4ktymA9TrvvzU7GGpAWV1_3Atk',
    appId: '1:606962850319:web:b359e7493a31dc1b43e17a',
    messagingSenderId: '606962850319',
    projectId: 'projecttest-d7049',
    authDomain: 'projecttest-d7049.firebaseapp.com',
    storageBucket: 'projecttest-d7049.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC4lfBJ6V0YOmgu4legTKoV7i3RnvN3eG0',
    appId: '1:606962850319:android:87a670e8c31d563c43e17a',
    messagingSenderId: '606962850319',
    projectId: 'projecttest-d7049',
    storageBucket: 'projecttest-d7049.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAxJU3KEzHZo0ijA-ZMbMjFOjhyDHp7rs8',
    appId: '1:606962850319:ios:90e62ae014b77fe443e17a',
    messagingSenderId: '606962850319',
    projectId: 'projecttest-d7049',
    storageBucket: 'projecttest-d7049.appspot.com',
    iosClientId: '606962850319-aid9n2s5tvjc3ka9koegqnpvvgamsp7l.apps.googleusercontent.com',
    iosBundleId: 'com.example.testproject',
  );
}
