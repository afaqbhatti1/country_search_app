import 'package:cached_network_image/cached_network_image.dart';
import 'package:country_search_app/data/models/country_model.dart';
import 'package:country_search_app/utils/widgets/country_detail_dialog.dart';
import 'package:flutter/material.dart';

class CountryListItem extends StatelessWidget {
  final Country country;

  const CountryListItem({super.key, required this.country});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CachedNetworkImage(
        imageUrl: country.flagUrl,
        width: 50,
        height: 30,
        fit: BoxFit.cover,
        placeholder: (context, url) => const CircularProgressIndicator(),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      ),
      title: Text(country.name),
      subtitle: Text(country.region),
      onTap: () {
        // show dialog with country details
        showDialog(
          context: context,
          builder: (context) => CountryDetailDialog(country: country),
        );
      },
    );
  }
}
