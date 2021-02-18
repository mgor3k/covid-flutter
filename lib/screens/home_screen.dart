import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../providers/country_picker_provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final pickedCountry =
        Provider.of<CountryPickerProvider>(context).pickedCountry;

    return CupertinoPageScaffold(
      child: Center(
        child: Text(pickedCountry.country),
      ),
    );
    ;
  }
}
