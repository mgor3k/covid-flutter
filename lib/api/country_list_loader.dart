import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/country.dart';

class CountryListLoader {
  static Future<List<Country>> getCountries() async {
    // TODO: This url doesnt work anymore?
    // final url = 'https://api.covid19api.com/countries';

    final url =
        'https://flutter-eede2-default-rtdb.firebaseio.com/countries.json';

    try {
      final response = await http.get(url);

      if (response.statusCode >= 300) {
        throw Exception(
            'Network request failed with status code ${response.statusCode}');
      }

      final data = json.decode(response.body) as List<dynamic>;
      final List<Country> countries = [];

      data.forEach((item) {
        countries.add(
          Country(
            item['Country'],
            item['Slug'],
          ),
        );
      });

      countries.sort((a, b) {
        return a.country.toLowerCase().compareTo(b.country.toLowerCase());
      });

      return countries;
    } catch (error) {
      print(error);
      throw error;
    }
  }
}
