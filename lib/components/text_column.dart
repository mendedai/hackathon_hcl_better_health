import 'package:flutter/material.dart';
import 'package:hcl_better_health/constants.dart';

class TextColumn extends StatelessWidget {
  final String title;
  final String text;

  TextColumn({this.title, this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          title,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headline5.copyWith(
                color: kWhite,
                fontWeight: FontWeight.bold,
              ),
        ),
        SizedBox(
          height: kSpaceS,
        ),
        Text(
          text,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.subtitle1.copyWith(
                color: kWhite,
              ),
        ),
      ],
    );
  }
}
