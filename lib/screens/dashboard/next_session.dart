import 'package:flutter/material.dart';
import 'package:hcl_better_health/constants.dart';
import 'package:hcl_better_health/screens/therapy/activity/activity.dart';
import 'package:hcl_better_health/theme/fonts.dart';

class NextSessionWidget extends StatelessWidget {
  String getNextSessionDateTime() {
    // TODO Implement getNextSessionDateTime
    return '';
  }

  @override
  Widget build(BuildContext context) {
    final kTextColor = Colors.white70;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 9.0),
      child: FlatButton(
        onPressed: () {
          Navigator.pushNamed(context, TherapyActivityScreen.route);
        },
        child: Ink(
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              colors: [kPurple1, kPurple3],
            ),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(15),
              bottomRight: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Start your first session',
                    style: TextStyles.title.bold.copyWith(
                      color: kTextColor,
                    ),
                  ),
                  // Text(
                  //   '${getNextSessionDateTime()}',
                  //   style: TextStyles.body.semibold.copyWith(
                  //     color: kTextColor,
                  //   ),
                  // )
                ],
              ),
              Icon(
                Icons.alarm,
                size: 30,
                color: kTextColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
