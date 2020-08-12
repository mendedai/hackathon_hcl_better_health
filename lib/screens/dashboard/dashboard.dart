import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hcl_better_health/components/botton_nav_bar.dart';
import 'package:hcl_better_health/constants.dart';
import 'package:hcl_better_health/layout/body_fab.dart';
import 'package:hcl_better_health/screens/dashboard/header.dart';
import 'package:hcl_better_health/screens/dashboard/insights_chart.dart';
import 'package:hcl_better_health/screens/dashboard/next_session.dart';
import 'package:hcl_better_health/screens/dashboard/quest_list.dart';

class DashboardScreen extends StatefulWidget {
  static final String route = 'dashboard';

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        bottomNavigationBar: BottomNavBar(currentRoute: DashboardScreen.route),
        extendBody: true,
        body: SafeArea(
          top: true,
          bottom: false,
          child: Stack(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/bg_gradient.jpg'),
                    fit: BoxFit.none,
                    alignment: Alignment.topLeft,
                  ),
                ),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                  child: Container(
                    color: kLightGrey.withOpacity(0.8),
                  ),
                ),
              ),
              BodyFab(
                currentRoute: DashboardScreen.route,
                child: ListView(
                  children: <Widget>[
                    SizedBox(
                      height: 20.0,
                    ),
                    DashboardHeaderWidget(),
                    SizedBox(
                      height: 10.0,
                    ),
                    QuestListWidget(),
                    NextSessionWidget(),
                    InsightsChartWidget(),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
