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
    apiKey: 'AIzaSyDiVmg02Eokl9nZLAZxNZ2Mh0-nkFkziHo',
    appId: '1:528323350529:web:f78cc008e0127423a13000',
    messagingSenderId: '528323350529',
    projectId: 'masjidkorea-2f6fd',
    authDomain: 'masjidkorea-2f6fd.firebaseapp.com',
    databaseURL: 'https://masjidkorea-2f6fd-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'masjidkorea-2f6fd.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCJonnxCz0Vf8vqXDNEVlLZioMkVwI2BWI',
    appId: '1:528323350529:android:017a25d58812d65da13000',
    messagingSenderId: '528323350529',
    projectId: 'masjidkorea-2f6fd',
    databaseURL: 'https://masjidkorea-2f6fd-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'masjidkorea-2f6fd.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBtAQpEqjVx4oWN4suPoxdu8OmtyOPCawU',
    appId: '1:528323350529:ios:de76e40723e5c4e9a13000',
    messagingSenderId: '528323350529',
    projectId: 'masjidkorea-2f6fd',
    databaseURL: 'https://masjidkorea-2f6fd-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'masjidkorea-2f6fd.appspot.com',
    iosBundleId: 'com.example.masjidKorea',
  );
}
