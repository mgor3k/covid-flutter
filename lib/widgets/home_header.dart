import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../images.dart';

import '../providers/country_picker_provider.dart';

class HomeHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final selectedCountry =
        Provider.of<CountryPickerProvider>(context).pickedCountry;
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
                    onPressed: () {},
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
                          selectedCountry.country,
                          style: TextStyle(color: Colors.white, fontSize: 32),
                        ),
                        Icon(
                          CupertinoIcons.chevron_down,
                          color: Colors.white,
                        ),
                      ],
                    ),
                    onPressed: () {},
                  ),
                  Spacer(),
                ],
              ),
              Text(
                'Last updated: 5 days ago',
                style: TextStyle(color: Colors.grey),
              )
            ],
          ),
        ),
      ),
    ]);
  }
}
