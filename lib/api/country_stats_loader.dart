import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/country_stats.dart';

class CountryStatsLoader {
  static Future<CountryStats> getStatsFor(String country) async {
    final url = 'https://api.covid19api.com/total/country/$country';

    try {
      final response = await http.get(url);

      if (response.statusCode >= 300) {
        throw Exception(
            'Network request failed with status code ${response.statusCode}');
      }

      final data = (json.decode(response.body) as List<dynamic>).last;

      return CountryStats(
        active: data['Active'],
        confirmed: data['Confirmed'],
        deaths: data['Deaths'],
        recovered: data['Recovered'],
      );
    } catch (error) {
      print(error);
      throw error;
    }
  }
}
