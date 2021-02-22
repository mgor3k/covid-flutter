import 'package:flutter/foundation.dart';

import '../api/country_list_loader.dart';

import '../models/country.dart';

class CountryPickerProvider with ChangeNotifier {
  Country _pickedCountry;

  Country get pickedCountry {
    return _pickedCountry;
  }

  Future<List<Country>> fetchCountries() async {
    return CountryListLoader.getCountries();
  }

  void pickCountry(Country country) {
    _pickedCountry = country;
    notifyListeners();
  }

  void refresh() {
    pickCountry(pickedCountry);
  }
}
