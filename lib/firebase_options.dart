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
        return macos;
      case TargetPlatform.windows:
        return windows;
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
    apiKey: 'AIzaSyCUWRQT-j2uO9ZsqeYEB3rhcxiZ-2_x80M',
    appId: '1:946281147701:web:a7caad1c08537013b8707c',
    messagingSenderId: '946281147701',
    projectId: 'todoapp-b1a79',
    authDomain: 'todoapp-b1a79.firebaseapp.com',
    storageBucket: 'todoapp-b1a79.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCCk5M_W1jLl_MxxLfIh--Wi0WitHZ-gko',
    appId: '1:946281147701:android:a8c9125b3f890df4b8707c',
    messagingSenderId: '946281147701',
    projectId: 'todoapp-b1a79',
    storageBucket: 'todoapp-b1a79.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDsAT36GjmmNssoJBtrhMRtgWUh7YhFvCQ',
    appId: '1:946281147701:ios:9016789ab3b97fe4b8707c',
    messagingSenderId: '946281147701',
    projectId: 'todoapp-b1a79',
    storageBucket: 'todoapp-b1a79.appspot.com',
    iosBundleId: 'com.example.todoapp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDsAT36GjmmNssoJBtrhMRtgWUh7YhFvCQ',
    appId: '1:946281147701:ios:9016789ab3b97fe4b8707c',
    messagingSenderId: '946281147701',
    projectId: 'todoapp-b1a79',
    storageBucket: 'todoapp-b1a79.appspot.com',
    iosBundleId: 'com.example.todoapp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCUWRQT-j2uO9ZsqeYEB3rhcxiZ-2_x80M',
    appId: '1:946281147701:web:e7e729021fdbfb97b8707c',
    messagingSenderId: '946281147701',
    projectId: 'todoapp-b1a79',
    authDomain: 'todoapp-b1a79.firebaseapp.com',
    storageBucket: 'todoapp-b1a79.appspot.com',
  );
}
