import 'package:flutter/foundation.dart';

import '../api/country_list_loader.dart';

import '../models/country.dart';

class CountryPickerProvider with ChangeNotifier {
  Country _pickedCountry;
  DateTime _lastUpdate;

  Country get pickedCountry {
    return _pickedCountry;
  }

  DateTime get lastUpdate {
    return _lastUpdate;
  }

  Future<List<Country>> fetchCountries() async {
    return CountryListLoader.getCountries();
  }

  void pickCountry(Country country) {
    _pickedCountry = country;
    _lastUpdate = DateTime.now();
    notifyListeners();
  }

  void refresh() {
    pickCountry(pickedCountry);
  }
}
