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
    apiKey: 'AIzaSyCWRIG-6EPnvQV2EMOXmoDgmG1PurdSQhA',
    appId: '1:711281828191:web:909b56643f743b66b796ea',
    messagingSenderId: '711281828191',
    projectId: 'e-racing-app',
    authDomain: 'e-racing-app.firebaseapp.com',
    storageBucket: 'e-racing-app.appspot.com',
    measurementId: 'G-1BL6BFT6XE',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCcZKvF5FEnIatTGHrp-0opV1G8mqUmdG8',
    appId: '1:711281828191:android:a9112ce39bae33aab796ea',
    messagingSenderId: '711281828191',
    projectId: 'e-racing-app',
    storageBucket: 'e-racing-app.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDibUFm2EnUcRlge9o818d2mMHNbHdRrFo',
    appId: '1:711281828191:ios:87627fbd1c8f8694b796ea',
    messagingSenderId: '711281828191',
    projectId: 'e-racing-app',
    storageBucket: 'e-racing-app.appspot.com',
    iosClientId: '711281828191-q0pn93amk93dl2r4mttqsm420ee1entu.apps.googleusercontent.com',
    iosBundleId: 'com.br.e.eRacingApp',
  );
}
