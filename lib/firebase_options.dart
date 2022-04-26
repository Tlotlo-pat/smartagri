// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars
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
    // ignore: missing_enum_constant_in_switch
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
    }

    throw UnsupportedError(
      'DefaultFirebaseOptions are not supported for this platform.',
    );
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAskUkKBdm3brHfoZXwjVviPnCL0jHtewc',
    appId: '1:363527299475:web:939aa08de40b65f0568866',
    messagingSenderId: '363527299475',
    projectId: 'safe-space-dn',
    authDomain: 'safe-space-dn.firebaseapp.com',
    storageBucket: 'safe-space-dn.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBWnoPC0XqStdSLsQzK-VvHTY8DspJnYlM',
    appId: '1:363527299475:android:27e5b3a31469e1d9568866',
    messagingSenderId: '552401036888',
    projectId: 'smartagri-68b62',
    storageBucket: 'smartagri-68b62.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAHKGO_pSMzHs6Uy9GaZhQJ2bUEJID28Xc',
    appId: '1:363527299475:ios:7439e240565e8b9b568866',
    messagingSenderId: '363527299475',
    projectId: 'safe-space-dn',
    storageBucket: 'safe-space-dn.appspot.com',
    iosClientId:
        '363527299475-sj9ruag26kvbr64387g956j2eam218h1.apps.googleusercontent.com',
    iosBundleId: 'com.diginav.spaceSpace',
  );
}
