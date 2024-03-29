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
    apiKey: 'AIzaSyDwtUWEpRnFQ6f5ISCwOG93J34Atl0JNx8',
    appId: '1:177284961273:web:a1e5ec3d91eafc64982328',
    messagingSenderId: '177284961273',
    projectId: 'women-safety-sos-aac37',
    authDomain: 'women-safety-sos-aac37.firebaseapp.com',
    storageBucket: 'women-safety-sos-aac37.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCw7ae4EYx5gkdFJV4Fc2dnCiBTvssTYeI',
    appId: '1:177284961273:android:4e03152dcaae5382982328',
    messagingSenderId: '177284961273',
    projectId: 'women-safety-sos-aac37',
    storageBucket: 'women-safety-sos-aac37.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC4tMenu5O4HcQH4obE4DK3DtQazR4ejyc',
    appId: '1:177284961273:ios:6765b4e76790a9ed982328',
    messagingSenderId: '177284961273',
    projectId: 'women-safety-sos-aac37',
    storageBucket: 'women-safety-sos-aac37.appspot.com',
    iosBundleId: 'com.example.flutterApplication1',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyC4tMenu5O4HcQH4obE4DK3DtQazR4ejyc',
    appId: '1:177284961273:ios:e99c01fcc244c48f982328',
    messagingSenderId: '177284961273',
    projectId: 'women-safety-sos-aac37',
    storageBucket: 'women-safety-sos-aac37.appspot.com',
    iosBundleId: 'com.example.flutterApplication1.RunnerTests',
  );
}
