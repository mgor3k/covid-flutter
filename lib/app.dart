import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import './screens/country_picker_screen.dart';
import './screens/home_screen.dart';

import './providers/country_picker_provider.dart';
import './providers/country_stats_provider.dart';

class CovidApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(
            value: CountryPickerProvider(),
          ),
          ChangeNotifierProxyProvider<CountryPickerProvider,
              CountryStatsProvider>(
            update: (ctx, pickerProvider, prev) =>
                CountryStatsProvider(pickerProvider.pickedCountry),
            create: (ctx) => CountryStatsProvider(null),
          ),
        ],
        child: Consumer<CountryPickerProvider>(
          builder: (ctx, provider, child) => CupertinoApp(
            theme: const CupertinoThemeData(brightness: Brightness.light),
            home: provider.pickedCountry == null
                ? CountryPickerScreen()
                : HomeScreen(),
          ),
        ));
  }
}
