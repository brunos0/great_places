import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:great_places/screens/map_screen.dart';
import 'package:great_places/utils/location_util.dart';
import 'package:geolocator/geolocator.dart';

class LocationInput extends StatefulWidget {
  final Function onSelectPosition;

  const LocationInput(this.onSelectPosition, {super.key});

  @override
  State<LocationInput> createState() => _LocationInpuState();
}

class _LocationInpuState extends State<LocationInput> {
  String? _previewImageUrl;
  bool gpsAvaliable = false;

  @override
  void initState() {
    super.initState();
    _getGpsPermission();
  }

  Future<void> _getGpsPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission != LocationPermission.denied) {
      setState(() {
        gpsAvaliable = true;
      });
    }
  }

  Future<void> _getuCurrentUserLocation() async {
    final Position locData = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    widget.onSelectPosition(
      LatLng(
        locData.latitude,
        locData.longitude,
      ),
    );
    showPreview(locData.latitude, locData.longitude);
  }

  Future<void> _selectOnMap() async {
    final LatLng selectedPosition = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => const MapScreen(),
      ),
    );

    //print(selectedPosition.latitude);
    widget.onSelectPosition(selectedPosition);

    showPreview(selectedPosition.latitude, selectedPosition.longitude);
  }

  void showPreview(double latitude, double longitude) {
    final staticMapInputUrl = LocationUtil.generateLocationPreviewImage(
        latitude: latitude, longitude: longitude);
    setState(() {
      _previewImageUrl = staticMapInputUrl;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 170,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Colors.grey,
            ),
          ),
          child: _previewImageUrl == null
              ? const Text("Localização não informada!")
              : Image.network(
                  _previewImageUrl!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextButton.icon(
              onPressed: gpsAvaliable ? _getuCurrentUserLocation : null,
              icon: const Icon(Icons.location_on),
              label: Text(
                "Localização Atual",
                style: TextStyle(color: Theme.of(context).primaryColor),
              ),
            ),
            TextButton.icon(
              onPressed: gpsAvaliable ? _selectOnMap : null,
              icon: const Icon(Icons.map),
              label: Text(
                "Selecione um mapa",
                style: TextStyle(color: Theme.of(context).primaryColor),
              ),
            ),
          ],
        )
      ],
    );
  }
}
