import 'package:flutter/material.dart';
import 'package:hcl_better_health/layout/fab_speed_dial.dart';
import 'package:hcl_better_health/screens/discover/feed_screen.dart';
import 'package:hcl_better_health/screens/insights/insight_screen.dart';

class BodyFab extends StatelessWidget {
  final String currentRoute;
  final Widget child;

  const BodyFab({
    @required this.currentRoute,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return FabSpeedDial(
      items: [
        FabSpeedDialItem(
          icon: Icon(Icons.person),
          label: 'Me',
          onPressed: () {},
        ),
        FabSpeedDialItem(
          icon: Icon(Icons.bookmark_border),
          label: 'Log an activity',
          onPressed: () {},
        ),
        FabSpeedDialItem(
          icon: Icon(Icons.graphic_eq),
          label: 'View insights',
          onPressed: () {
            Navigator.pushNamed(
              context,
              InsightScreen.route,
            );
          },
        ),
        FabSpeedDialItem(
          icon: Icon(Icons.bubble_chart),
          label: 'Discover',
          onPressed: () {
            Navigator.pushNamed(
              context,
              FeedScreen.route,
            );
          },
        ),
      ],
      body: child,
    );
  }
}
