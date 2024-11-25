import 'package:country_search_app/data/models/country_model.dart';

class CountrySearchState {
  final List<Country> allCountries;
  final List<Country> filteredCountries;
  final bool isLoading;
  final String? error;

  CountrySearchState({
    this.allCountries = const [],
    this.filteredCountries = const [],
    this.isLoading = false,
    this.error,
  });

  CountrySearchState copyWith({
    List<Country>? allCountries,
    List<Country>? filteredCountries,
    bool? isLoading,
    String? error,
  }) {
    return CountrySearchState(
      allCountries: allCountries ?? this.allCountries,
      filteredCountries: filteredCountries ?? this.filteredCountries,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}
