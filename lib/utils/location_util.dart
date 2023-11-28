import 'dart:io' show Platform;

String googleApiKey = const String.fromEnvironment('API_KEY_MAPS');
String googleApiKeyIOS = const String.fromEnvironment('API_KEY_MAPS_IOS');

class LocationUtil {
  static String generateLocationPreviewImage(
      {double latitude = 0, double longitude = 0}) {
    String apiKey = Platform.isAndroid ? googleApiKey : googleApiKeyIOS;
    return "https://maps.googleapis.com/maps/api/staticmap?center={$latitude,$longitude}&zoom=13&size=600x300&maptype=roadmap&markers=color:red%7Clabel:A%7C$latitude,$longitude&key=$apiKey";
  }
}
