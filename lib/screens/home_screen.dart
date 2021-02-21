import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../providers/country_picker_provider.dart';

import '../widgets/home_header.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final pickedCountry =
        Provider.of<CountryPickerProvider>(context).pickedCountry;
    return AnnotatedRegion(
      value: SystemUiOverlayStyle(
        statusBarBrightness: Brightness.dark,
      ),
      child: CupertinoPageScaffold(
        child: Column(
          children: [
            HomeHeader(),
            // Text(pickedCountry.country),
          ],
        ),
      ),
    );
    ;
  }
}
