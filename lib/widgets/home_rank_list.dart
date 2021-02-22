import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

import '../models/country_summary.dart';

class HomeRankList extends StatelessWidget {
  final List<CountrySummary> countries = [
    CountrySummary('Poland', 100, 200),
    CountrySummary('Poland', 100003210, 200),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(
            'Top 10 countries (by cases)',
            style: TextStyle(
              fontSize: 14,
            ),
          ),
          Expanded(
              child: ListView.builder(
            itemCount: countries.length,
            itemBuilder: (ctx, index) => HomeRankItem(countries[index]),
          )),
        ],
      ),
    );
  }
}

class HomeRankItem extends StatelessWidget {
  static final formatter = NumberFormat("#,###,###");
  final CountrySummary country;

  HomeRankItem(this.country);

  String get _totalConfirmed {
    return formatter.format(country.totalConfirmed);
  }

  String get _totalDeaths {
    return formatter.format(country.totalDeath);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      child: Row(
        children: [
          Text(country.country),
          Spacer(),
          Text(_totalConfirmed),
          SizedBox(width: 8),
          Text('☠️'),
          SizedBox(width: 8),
          Text(_totalDeaths),
        ],
      ),
    );
  }
}
