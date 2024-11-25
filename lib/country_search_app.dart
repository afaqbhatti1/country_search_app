import 'package:country_search_app/presentation/screens/country_search_screen.dart';
import 'package:flutter/material.dart';

class CountrySearchApp extends StatelessWidget {
  const CountrySearchApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Country Search',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const CountrySearchScreen(),
    );
  }
}
