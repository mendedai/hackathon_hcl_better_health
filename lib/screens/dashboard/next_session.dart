import 'package:flutter/material.dart';
import 'package:hcl_better_health/constants.dart';
import 'package:hcl_better_health/theme/fonts.dart';

class NextSessionWidget extends StatelessWidget {
  String getNextSessionDateTime() {
    // TODO Implement getNextSessionDateTime
    return 'Tomorrow at 7:30am';
  }

  @override
  Widget build(BuildContext context) {
    // final kTextColor =
    //     Color.alphaBlend(Colors.brown[800].withOpacity(0.7), kColorAccent3);
    final kTextColor = Colors.white70;
    // final kTextColor = Color(0xFFFB5607);
    // final kTextColor = Colors.brown[300];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 9.0),
      child: Card(
        color: kColorAccent3,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(15),
            bottomRight: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Next Session',
                    style: TextStyles.title.bold.copyWith(
                      color: kTextColor,
                    ),
                  ),
                  Text(
                    '${getNextSessionDateTime()}',
                    style: TextStyles.body.semibold.copyWith(
                      color: kTextColor,
                    ),
                  )
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
