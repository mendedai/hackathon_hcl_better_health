import 'package:flutter/material.dart';
import 'package:hcl_better_health/constants.dart';
import 'package:hcl_better_health/screens/dashboard/dashboard.dart';
import 'package:hcl_better_health/screens/questionnaire/questionnaire.dart';
import 'package:hcl_better_health/screens/therapy/activity/activity.dart';

class BottomNavBar extends StatelessWidget {
  final String currentRoute;
  final Color kButtonColor = kColorMainNavButton;

  const BottomNavBar({
    Key key,
    @required this.currentRoute,
  }) : super(key: key);

  void goToRoute(context, routeName) {
    if (currentRoute != routeName) {
      Navigator.pushNamed(
        context,
        routeName,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final double iconSize = 25.0;
    final Color iconColor = Colors.white;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 5),
              decoration: BoxDecoration(
                color: kButtonColor,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  IconButton(
                      icon: Icon(
                        Icons.home,
                        color: iconColor,
                        size: iconSize,
                      ),
                      onPressed: () {
                        goToRoute(context, DashboardScreen.route);
                      }),
                  IconButton(
                    onPressed: () {
                      goToRoute(context, QuestionnaireScreen.route);
                    },
                    color: kButtonColor,
                    icon: Icon(
                      Icons.add,
                      color: iconColor,
                      size: iconSize,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(flex: 1, child: SizedBox())
        ],
      ),
    );
  }
}
