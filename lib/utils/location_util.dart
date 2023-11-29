import 'dart:convert';
import 'dart:io' show Platform;
import 'package:http/http.dart' as http;

import 'package:google_maps_flutter/google_maps_flutter.dart';

String googleApiKey = const String.fromEnvironment('API_KEY_MAPS');
String googleApiKeyIOS = const String.fromEnvironment('API_KEY_MAPS_IOS');
String apiKey = Platform.isAndroid ? googleApiKey : googleApiKeyIOS;

class LocationUtil {
  static String generateLocationPreviewImage(
      {double latitude = 0, double longitude = 0}) {
    return 'https://maps.googleapis.com/maps/api/staticmap?center={$latitude,$longitude}&zoom=13&size=600x300&maptype=roadmap&markers=color:red%7Clabel:A%7C$latitude,$longitude&key=$apiKey';
  }

  static Future<String> getAddressFrom(LatLng position) async {
    final Uri url = Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=apiKey');
    final response = await http.get(url);
    return json.decode(response.body)['results'][0]['formatted_address'];
  }
}
