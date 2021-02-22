import 'package:flutter/foundation.dart';

import '../api/country_stats_loader.dart';

import '../models/country.dart';
import '../models/country_stats.dart';

class CountryStatsProvider with ChangeNotifier {
  final Country country;

  CountryStatsProvider(this.country);

  Future<CountryStats> getStats() async {
    print('getting: ${country.slug}');
    return CountryStatsLoader.getStatsFor(country.slug);
  }
}
