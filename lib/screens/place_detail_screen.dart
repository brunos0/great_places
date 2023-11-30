import 'package:flutter/material.dart';
import 'package:great_places/models/place.dart';

class PlaceDetailScreen extends StatelessWidget {
  const PlaceDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Place place = ModalRoute.of(context)!.settings.arguments as Place;
    return Scaffold(
        appBar: AppBar(
      title: Text(place.title),
    ));
  }
}
