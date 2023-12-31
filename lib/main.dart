import 'package:flutter/material.dart';
import 'package:great_places/providers/great_places.dart';
import 'package:great_places/screens/place_detail_screen.dart';
import 'package:great_places/screens/place_form_screen.dart';
import 'package:great_places/screens/places_list_screen.dart';
import 'package:great_places/utils/app_routes.dart';
import 'package:great_places/utils/life_cycle_manager.dart';
import 'package:provider/provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => GreatPlaces(),
      child: LifeCycleManager(
        child: MaterialApp(
          title: 'Great Places',
          theme: ThemeData().copyWith(
            visualDensity: VisualDensity.adaptivePlatformDensity,
            colorScheme:
                ThemeData(disabledColor: Colors.red).colorScheme.copyWith(
                      primary: Colors.indigo,
                      secondary: Colors.amber,
                    ),
            progressIndicatorTheme:
                const ProgressIndicatorThemeData(color: Colors.amber),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.resolveWith<Color>(
                    (states) => Colors.black),
                backgroundColor: MaterialStateProperty.resolveWith<Color>(
                  (Set<MaterialState> states) {
                    if (states.contains(MaterialState.disabled)) {
                      return Colors.grey.shade400;
                    }
                    return Colors.amber;
                  },
                ),
              ),
            ),
          ),
          home: const PlacesListScreen(),
          routes: {
            AppRoutes.placeForm: (ctx) => const PlaceFormScreen(),
            AppRoutes.placeDetail: (ctx) => const PlaceDetailScreen(),
          },
        ),
      ),
    );
  }
}
