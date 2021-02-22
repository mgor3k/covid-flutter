import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:intl/intl.dart';

import '../models/country_stats.dart';
import '../providers/country_stats_provider.dart';

class HomeStats extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CountryStatsProvider>(context);
    return FutureBuilder(
      future: provider.getStats(),
      builder: (ctx, snapshot) => IgnorePointer(
        child: snapshot.connectionState == ConnectionState.waiting
            ? Center(
                child: CircularProgressIndicator(),
              )
            : _Grid(snapshot.data),
      ),
    );
  }
}

class _Grid extends StatelessWidget {
  final CountryStats stats;

  _Grid(this.stats);

  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: EdgeInsets.symmetric(horizontal: 32),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2.3,
        crossAxisSpacing: 24,
        mainAxisSpacing: 24,
      ),
      children: [
        HomeStatsCell('Confirmed', stats.confirmed, Colors.red),
        HomeStatsCell('Active', stats.active, Colors.blue),
        HomeStatsCell('Recovered', stats.recovered, Colors.green),
        HomeStatsCell('Deaths', stats.deaths, Colors.grey),
      ],
    );
  }
}

class HomeStatsCell extends StatelessWidget {
  final String title;
  final int value;
  final Color color;

  HomeStatsCell(
    this.title,
    this.value,
    this.color,
  );

  String get _formattedValue {
    final formatter = NumberFormat("#,###,###");
    return formatter.format(value);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              color: Colors.black.withAlpha(20),
              blurRadius: 20,
              spreadRadius: 5),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title.toUpperCase(),
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.black54,
              ),
            ),
            SizedBox(height: 20),
            FittedBox(
              child: Text(
                _formattedValue,
                style: TextStyle(
                  color: color,
                  fontSize: 24,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
