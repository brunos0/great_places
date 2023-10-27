import 'dart:io';

import 'package:flutter/material.dart';
import 'package:great_places/providers/greate_places.dart';
import 'package:great_places/utils/app_routes.dart';
import 'package:provider/provider.dart';

class PlacesListScreen extends StatelessWidget {
  const PlacesListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Meus Lugares"), actions: <Widget>[
        IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(AppRoutes.placeForm);
            },
            icon: const Icon(Icons.add))
      ]),
      body: Consumer<GreatPlaces>(
        child: const Center(
          child: Text("Nenhum local cadastrado!"),
        ),
        builder: (ctx, greatPlaces, child) => greatPlaces.itemsCount == 0
            ? child!
            : ListView.builder(
                itemCount: greatPlaces.itemsCount,
                itemBuilder: (ctx, item) => ListTile(
                    leading: CircleAvatar(
                      backgroundImage: FileImage(
                          File(greatPlaces.itemByIndex(item).image.path)),
                    ),
                    title: Text(greatPlaces.itemByIndex(item).title),
                    onTap: () {}),
              ),
      ),
    );
  }
}
