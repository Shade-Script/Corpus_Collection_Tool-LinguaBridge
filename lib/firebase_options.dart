// File generated manually based on google-services.json for Android
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCD7dHapOCxhXeMPmBdaOb8Xj_kbJZDLQw',
    appId: '1:1073119278381:android:89b404936c00053c9ecfa4',
    messagingSenderId: '1073119278381',
    projectId: 'epics0-lingua-bridge',
    storageBucket: 'epics0-lingua-bridge.firebasestorage.app',
  );

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDCepWPQIGj1BGjDRjyKcPnYJo1lamlQM0',
    appId: '1:1073119278381:web:0725865800a3b5479ecfa4',
    messagingSenderId: '1073119278381',
    projectId: 'epics0-lingua-bridge',
    authDomain: 'epics0-lingua-bridge.firebaseapp.com',
    storageBucket: 'epics0-lingua-bridge.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyANL2zJ8ST9UPV6TM_LIEJ3QFq0sAtLvZM',
    appId: '1:1073119278381:ios:6dfc23e08aeb27fa9ecfa4',
    messagingSenderId: '1073119278381',
    projectId: 'epics0-lingua-bridge',
    storageBucket: 'epics0-lingua-bridge.firebasestorage.app',
    iosBundleId: 'com.linguabridge.linguabridge',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDCepWPQIGj1BGjDRjyKcPnYJo1lamlQM0',
    appId: '1:1073119278381:web:cf58df7fc6c708bd9ecfa4',
    messagingSenderId: '1073119278381',
    projectId: 'epics0-lingua-bridge',
    authDomain: 'epics0-lingua-bridge.firebaseapp.com',
    storageBucket: 'epics0-lingua-bridge.firebasestorage.app',
  );

}