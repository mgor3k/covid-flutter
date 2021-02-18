import 'package:flutter/foundation.dart';

import '../api/country_list_network_service.dart';

import '../models/country.dart';

class CountryPickerProvider with ChangeNotifier {
  Country _pickedCountry;

  Country get pickedCountry {
    return _pickedCountry;
  }

  Future<List<Country>> fetchCountries() async {
    return CountryListNetworkService.getCountries();
  }

  void pickCountry(Country country) {
    _pickedCountry = country;
    notifyListeners();
  }
}
