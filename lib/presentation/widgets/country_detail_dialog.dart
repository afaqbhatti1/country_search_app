import 'package:cached_network_image/cached_network_image.dart';
import 'package:country_search_app/data/models/country_model.dart';
import 'package:flutter/material.dart';

class CountryDetailDialog extends StatelessWidget {
  final Country country;

  const CountryDetailDialog({super.key, required this.country});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(country.name),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CachedNetworkImage(
            imageUrl: country.flagUrl,
            height: 100,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 10),
          Text('Region: ${country.region}'),
          Text('Population: ${country.population}'),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Close'),
        ),
      ],
    );
  }
}
