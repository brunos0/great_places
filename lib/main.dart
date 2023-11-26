import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:great_places/providers/great_places.dart';
import 'package:great_places/screens/place_form_screen.dart';
import 'package:great_places/screens/places_list_screen.dart';
import 'package:great_places/utils/app_routes.dart';
import 'package:great_places/utils/ios_bridge.dart';
import 'package:provider/provider.dart';
import 'dart:io' show Platform;

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
  if (Platform.isIOS) {
    IosBridge.myVariable;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => GreatPlaces(),
      child: MaterialApp(
        title: 'Great Places',
        theme: ThemeData().copyWith(
            visualDensity: VisualDensity.adaptivePlatformDensity,
            colorScheme: ThemeData()
                .colorScheme
                .copyWith(primary: Colors.indigo, secondary: Colors.amber),
            progressIndicatorTheme:
                const ProgressIndicatorThemeData(color: Colors.amber),
            elevatedButtonTheme: ElevatedButtonThemeData(
                style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.resolveWith<Color>(
                        (states) => Colors.black),
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        (states) => Colors.amber))
                //colorScheme:ThemeData().colorScheme.copyWith(background: Colors.amber)

                //(background: Colors.amber,

                //);
                )),
        home: const PlacesListScreen(),
        routes: {AppRoutes.placeForm: (ctx) => const PlaceFormScreen()},
      ),
    );
  }
}
