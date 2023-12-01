import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:great_places/providers/great_places.dart';
import 'package:great_places/widgets/image_input.dart';
import 'package:great_places/widgets/location_input.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class PlaceFormScreen extends StatefulWidget {
  const PlaceFormScreen({super.key});

  @override
  State<PlaceFormScreen> createState() => _PlaceFormScreenState();
}

class _PlaceFormScreenState extends State<PlaceFormScreen> {
  final _titleController = TextEditingController();
  XFile? _pickedImage;
  LatLng? _pickedPosition;

  void _selectImage(XFile pickedImage) {
    setState(() {
      _pickedImage = pickedImage;
    });
  }

  void _selectPosition(LatLng position) {
    setState(() {
      _pickedPosition = position;
    });
  }

  bool _isValidForm() =>
      _titleController.text.isNotEmpty &&
      _pickedImage != null &&
      _pickedPosition != null;

  void _submitForm() {
    if (!_isValidForm()) return;

    Provider.of<GreatPlaces>(context, listen: false)
        .addPlace(_titleController.text, _pickedImage!, _pickedPosition!);

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        title: const Text("Novo lugar"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: <Widget>[
                    TextField(
                      controller: _titleController,
                      decoration: const InputDecoration(
                        labelText: 'Título',
                      ),
                      onChanged: (text) {
                        setState(() {});
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ImageInput(_selectImage),
                    const SizedBox(
                      height: 10,
                    ),
                    LocationInput(_selectPosition),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(Platform.isIOS ? 15 : 0),
            child: ElevatedButton.icon(
              label: const Text('Adicionar'),
              icon: const Icon(Icons.add),
              style: ElevatedButton.styleFrom(
                //disabledBackgroundColor: Colors.grey.shade400,
                elevation: 0,
                tapTargetSize:
                    Platform.isIOS ? null : MaterialTapTargetSize.shrinkWrap,
              ),
              onPressed: _isValidForm() ? _submitForm : null,
            ),
          )
        ],
      ),
    );
  }
}
