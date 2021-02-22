import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../providers/country_picker_provider.dart';

import '../widgets/home_header.dart';
import '../widgets/home_stats.dart';
import '../widgets/home_rank_list.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, constraints) => AnnotatedRegion(
        value: SystemUiOverlayStyle(
          statusBarBrightness: Brightness.dark,
        ),
        child: CupertinoPageScaffold(
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            children: [
              Container(
                height: 580,
                child: Stack(
                  overflow: Overflow.visible,
                  children: [
                    HomeHeader(),
                    Positioned(
                        top: 260,
                        child: Container(
                          width: constraints.maxWidth,
                          height: 650,
                          child: HomeStats(),
                        )),
                  ],
                ),
              ),
              SizedBox(
                child: HomeRankList(),
                height: 650,
              ),
            ],
          ),
        ),
      ),
    );
    ;
  }
}
