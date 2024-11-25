import 'dart:async';

import 'package:country_search_app/data/models/country_search_state.dart';
import 'package:country_search_app/domain/country_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final countryServiceProvider = Provider((ref) => CountryRepository());

final countrySearchProvider =
    StateNotifierProvider<CountrySearchNotifier, CountrySearchState>((ref) {
  final service = ref.watch(countryServiceProvider);
  return CountrySearchNotifier(service);
});

class CountrySearchNotifier extends StateNotifier<CountrySearchState> {
  final CountryRepository _service;
  Timer? _debounceTimer;

  CountrySearchNotifier(this._service) : super(CountrySearchState());

  void searchCountries(String query) {
    // cancel timer
    _debounceTimer?.cancel();

    // convert to lowercase
    query = query.trim().toLowerCase();

    // Clear state when query is empty
    if (query.isEmpty) {
      state = CountrySearchState(
          allCountries: [],
          filteredCountries: [],
          isLoading: false,
          error: null);
      return;
    }

    _debounceTimer = Timer(const Duration(milliseconds: 500), () async {
      state = state.copyWith(isLoading: true);

      try {
        // get all countries
        final countries = await _service.searchCountries(query);

        // user side filtering
        final filteredCountries = countries.where((country) {
          // match against country name
          return country.name.toLowerCase().contains(query);
        }).toList();

        // model set to state
        state = CountrySearchState(
          allCountries: countries,
          filteredCountries: filteredCountries,
          isLoading: false,
        );
      } catch (e) {
        state = state.copyWith(
          error: 'Unable to fetch data',
          isLoading: false,
        );
      }
    });
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    super.dispose();
  }
}
