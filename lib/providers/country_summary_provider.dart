import 'package:flutter/foundation.dart';

import '../api/country_summary_loader.dart';

import '../models/country_summary.dart';

class CountrySummaryProvider with ChangeNotifier {
  Future<List<CountrySummary>> getStats() async {
    return CountrySummaryLoader.getSummary();
  }
}
