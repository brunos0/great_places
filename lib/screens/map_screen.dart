import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
//import 'package:great_places/models/place.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({this.initialLocation, this.isReadonly = false, super.key});

  final LatLng? initialLocation;
  final bool isReadonly;
  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng? _pickedPosition;
  late LatLng initialLocation;
  late Future<void> currentPositionFuture;

  void _selectPosition(LatLng position) {
    setState(() {
      _pickedPosition = position;
    });
  }

  Future<void> getCurrentPosition() async {
    LatLng? initLoc = widget.initialLocation;
    if (initLoc == null) {
      Position location = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      initLoc = LatLng(location.latitude, location.longitude);
    }
    setState(() {
      if (widget.isReadonly) {
        _pickedPosition = initLoc;
      }
      initialLocation = initLoc!;
    });
  }

  @override
  void initState() {
    super.initState();
    currentPositionFuture = getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        title: widget.isReadonly
            ? const Text('Localização escolhida')
            : const Text('Selecione...'),
        actions: [
          if (!widget.isReadonly)
            IconButton(
              onPressed: () {
                if (_pickedPosition != null) {
                  Navigator.of(context).pop(_pickedPosition);
                }
              },
              icon: const Icon(Icons.check),
            ),
        ],
      ),
      body: FutureBuilder(
        future: currentPositionFuture,
        builder: (ctx, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? const Center(child: CircularProgressIndicator())
                : GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: initialLocation,
                      zoom: 13,
                    ),
                    onTap: widget.isReadonly ? null : _selectPosition,
                    markers: (_pickedPosition == null && !widget.isReadonly)
                        ? {}
                        : {
                            Marker(
                              markerId: const MarkerId('p1'),
                              position: _pickedPosition!,
                            )
                          },
                  ),
      ),
    );
  }
}
