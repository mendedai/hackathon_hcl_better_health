import 'package:flutter/material.dart';
import 'package:hcl_better_health/components/logo.dart';
import 'package:hcl_better_health/constants.dart';

class Header extends StatelessWidget {
  final VoidCallback onSkip;

  Header({@required this.onSkip});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Logo(
          color: kWhite,
          size: 32.0,
        ),
        GestureDetector(
          child: Text(
            'Skip',
            style: Theme.of(context).textTheme.subtitle1.copyWith(
                  color: kWhite,
                ),
          ),
        )
      ],
    );
  }
}
