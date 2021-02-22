import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/country_summary.dart';

class CountrySummaryLoader {
  static Future<List<CountrySummary>> getSummary() async {
    final url = 'https://api.covid19api.com/summary';

    try {
      final response = await http.get(url);

      if (response.statusCode >= 300) {
        throw Exception(
            'Network request failed with status code ${response.statusCode}');
      }

      final data = json.decode(response.body)['Countries'] as List<dynamic>;
      final List<CountrySummary> countries = [];

      data.forEach((item) {
        countries.add(
          CountrySummary(
            item['Country'],
            item['TotalConfirmed'],
            item['TotalDeaths'],
          ),
        );
      });

      countries.sort((a, b) {
        return b.totalDeath.compareTo(a.totalDeath);
      });

      return countries.take(10).toList();
    } catch (error) {
      print(error);
      throw error;
    }
  }
}
