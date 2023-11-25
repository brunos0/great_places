import 'package:flutter/services.dart';
import 'dart:developer' as dev;

import 'package:flutter_dotenv/flutter_dotenv.dart';

class IosBridge {
  static const platform = MethodChannel('com.example.great_places/iosbridge');

  static Future<String?> get myVariable async {
    String? value;
    try {
      value = await platform.invokeMethod(
          'getApiKey', dotenv.env['API_KEY_MAPS_IOS']);
    } on PlatformException catch (e) {
      dev.log("Failed to get environment variable: '${e.message}'.");
    }
    return value;
  }
}
