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
    apiKey: 'AIzaSyDiR1My0Zt7W6PXxmipks6efHWgSUnof9U',
    appId: '1:127953671912:web:70674c8bd57448958d1b5d',
    messagingSenderId: '127953671912',
    projectId: 'tugas-akhir-d36dd',
    authDomain: 'tugas-akhir-d36dd.firebaseapp.com',
    storageBucket: 'tugas-akhir-d36dd.appspot.com',
    measurementId: 'G-TZREM6019R',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDe3A1GO5xlTxM553OcYMtCUmL00WCRyt0',
    appId: '1:127953671912:android:708376beb87cc2b28d1b5d',
    messagingSenderId: '127953671912',
    projectId: 'tugas-akhir-d36dd',
    storageBucket: 'tugas-akhir-d36dd.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA8CvO0ivJSFCoubmEM69aUvnGhhy62M3w',
    appId: '1:127953671912:ios:2f8064dcd15b58d58d1b5d',
    messagingSenderId: '127953671912',
    projectId: 'tugas-akhir-d36dd',
    storageBucket: 'tugas-akhir-d36dd.appspot.com',
    iosBundleId: 'com.example.pengawalanVirtual',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyA8CvO0ivJSFCoubmEM69aUvnGhhy62M3w',
    appId: '1:127953671912:ios:fa3a0cd17f2310598d1b5d',
    messagingSenderId: '127953671912',
    projectId: 'tugas-akhir-d36dd',
    storageBucket: 'tugas-akhir-d36dd.appspot.com',
    iosBundleId: 'com.example.pengawalanVirtual.RunnerTests',
  );
}