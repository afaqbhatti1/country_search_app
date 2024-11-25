import 'package:country_search_app/presentation/providers/country_provider.dart';
import 'package:country_search_app/presentation/widgets/country_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CountrySearchScreen extends ConsumerStatefulWidget {
  const CountrySearchScreen({super.key});

  @override
  _CountrySearchScreenState createState() => _CountrySearchScreenState();
}

class _CountrySearchScreenState extends ConsumerState<CountrySearchScreen> {
  final TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final searchState = ref.watch(countrySearchProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Country Search')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              decoration: const InputDecoration(
                hintText: 'Search for a country...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                ref.read(countrySearchProvider.notifier).searchCountries(value);
              },
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // loading while searching
                if (searchState.isLoading)
                  const Center(child: CircularProgressIndicator())
                // error message on searching
                else if (searchState.error != null)
                  Text(searchState.error!,
                      style: const TextStyle(color: Colors.red))
                // no countries found if list is empty
                else if (searchState.filteredCountries.isEmpty &&
                    searchController.text.isNotEmpty)
                  const Center(
                    child: Text('No countries found.',
                        textAlign: TextAlign.start,
                        style: TextStyle(color: Colors.grey)),
                  )
                // list of countries found by search
                else
                  Expanded(
                    child: ListView.builder(
                      itemCount: searchState.filteredCountries.length,
                      itemBuilder: (context, index) {
                        final country = searchState.filteredCountries[index];
                        return CountryListItem(country: country);
                      },
                    ),
                  ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
