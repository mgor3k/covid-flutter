import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:timer_builder/timer_builder.dart';

import '../images.dart';

import '../providers/country_picker_provider.dart';
import '../screens/country_picker_screen.dart';

class HomeHeader extends StatefulWidget {
  @override
  _HomeHeaderState createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader> {
  DateTime lastUpdated;

  String get dateString {
    if (lastUpdated == null) {
      return '';
    }
    return timeago.format(lastUpdated);
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CountryPickerProvider>(context);
    lastUpdated = provider.lastUpdate;
    return Stack(children: [
      Images.banner,
      SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 32, left: 24, right: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text('Covid-19 Tracker',
                      style: TextStyle(color: Colors.white)),
                  Spacer(),
                  CupertinoButton(
                    child: Icon(
                      CupertinoIcons.refresh_circled_solid,
                      color: Colors.white,
                      size: 32,
                    ),
                    onPressed: provider.refresh,
                  ),
                ],
              ),
              SizedBox(height: 24),
              Row(
                children: [
                  CupertinoButton(
                    padding: EdgeInsets.zero,
                    child: Row(
                      children: [
                        Text(
                          provider.pickedCountry.country,
                          style: TextStyle(color: Colors.white, fontSize: 32),
                        ),
                        Icon(
                          CupertinoIcons.chevron_down,
                          color: Colors.white,
                        ),
                      ],
                    ),
                    onPressed: () {
                      Navigator.of(context).push(CupertinoPageRoute(
                        fullscreenDialog: true,
                        builder: (ctx) => CountryPickerScreen(),
                      ));
                    },
                  ),
                  Spacer(),
                ],
              ),
              TimerBuilder.periodic(
                Duration(seconds: 1),
                builder: (ctx) => Text(
                  'Last updated: $dateString',
                  style: TextStyle(color: Colors.grey),
                ),
              )
            ],
          ),
        ),
      ),
    ]);
  }
}
