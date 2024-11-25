class Country {
  final String name;
  final String flagUrl;
  final String region;
  final int population;

  Country({
    required this.name,
    required this.flagUrl,
    required this.region,
    required this.population,
  });

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      name: json['name']['common'],
      flagUrl: json['flags']['png'],
      region: json['region'],
      population: json['population'],
    );
  }

  @override
  String toString() {
    return 'Country(name: $name, flagUrl: $flagUrl, region: $region, population: $population)';
  }
}
