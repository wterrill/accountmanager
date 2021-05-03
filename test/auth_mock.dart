import 'package:firebase_core_platform_interface/firebase_core_platform_interface.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

// typedef void Callback(MethodCall call);

typedef Callback = void Function(MethodCall call);

void setupFirebaseAuthMocks([Callback? customHandlers]) {
  TestWidgetsFlutterBinding.ensureInitialized();

  MethodChannelFirebase.channel.setMockMethodCallHandler((call) async {
    if (call.method == 'Firebase#initializeCore') {
      return [
        {
          'name': defaultFirebaseAppName,
          'options': {
            'apiKey': 'AIzaSyCeHOCdG2CjCzxChmeDV1WdonR-KqD6BDY',
            'authDomain': 'mxotechaccountmanager.firebaseapp.com',
            'projectId': 'mxotechaccountmanager',
            'storageBucket': 'mxotechaccountmanager.appspot.com',
            'messagingSenderId': '430578183229',
            'appId': '1:430578183229:web:f810293696b95c42544e54',
            'measurementId': 'G-GQD0ZLD62J'
          },
          'pluginConstants': <String, dynamic>{},
        }
      ];
    }

    if (call.method == 'Firebase#initializeApp') {
      return <String, dynamic>{
        'name': call.arguments['appName'],
        'options': call.arguments['options'],
        'pluginConstants': <String, dynamic>{},
      };
    }

    if (customHandlers != null) {
      customHandlers(call);
    }

    return null;
  });
}
