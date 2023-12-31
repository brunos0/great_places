import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';

class PlaceLocation {
  final double latitude;
  final double longitude;
  final String? address;
  const PlaceLocation(
      {required this.latitude, required this.longitude, this.address});
  LatLng toLatLng() {
    return LatLng(latitude, longitude);
  }
}

class Place {
  final String id;
  final String title;
  final PlaceLocation? location;
  final XFile image;

  Place(
      {required this.id,
      required this.title,
      required this.location,
      required this.image});
}
