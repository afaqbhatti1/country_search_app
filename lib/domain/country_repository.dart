import 'package:country_search_app/core/constants/api_constants.dart';
import 'package:country_search_app/data/models/country_model.dart';
import 'package:dio/dio.dart';

class CountryRepository {
  final Dio dio = Dio(BaseOptions(
    baseUrl: ApiConstants.baseUrl,
  ));

  // search countries by name API
  Future<List<Country>> searchCountries(String query) async {
    try {
      print('query: $query');
      final response = await dio.get('name/$query');
      // API data assign to model of country list
      final List<dynamic> data = response.data;
      print('data: $data');
      return data.map((json) => Country.fromJson(json)).toList();
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        return [];
      }
      rethrow;
    }
  }
}
