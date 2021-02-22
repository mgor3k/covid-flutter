import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../models/country_summary.dart';
import '../providers/country_summary_provider.dart';

class HomeRankList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CountrySummaryProvider>(context);
    return FutureBuilder(
      future: provider.getStats(),
      builder: (ctx, snapshot) =>
          snapshot.connectionState == ConnectionState.waiting
              ? Center(child: CircularProgressIndicator())
              : snapshot.data == null
                  ? Center(
                      child: Text('Error'),
                    )
                  : _List(snapshot.data),
    );
  }
}

class _List extends StatelessWidget {
  final List<CountrySummary> countries;

  _List(this.countries);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(
            'Top 10 countries (by cases)',
            style: TextStyle(
              fontSize: 12,
            ),
          ),
          Expanded(
              child: Column(
            children: countries.map((item) => HomeRankItem(item)).toList(),
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
          FittedBox(
            child: Text(
              country.country,
              style: TextStyle(fontSize: 16),
            ),
          ),
          SizedBox(width: 16),
          Spacer(),
          Text(
            _totalConfirmed,
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(width: 8),
          Text('☠️'),
          SizedBox(width: 8),
          Text(_totalDeaths, style: TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}
