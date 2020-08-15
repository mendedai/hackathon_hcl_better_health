import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hcl_better_health/screens/questionnaire/questionnaire.dart';
import 'package:hcl_better_health/theme/fonts.dart';

import '../../constants.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 3), () {
      Navigator.pushNamedAndRemoveUntil(
        context,
        QuestionnaireScreen.route,
        (route) {
          print(route);
          return false;
        },
      );
    });

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(
            'Welcome to Mended.\n\nThis is your first time so our friendly assistant Em will start by asking you a few questions.\n\nLet\'s get started 💪',
            style: TextStyles.pageTitle.bold.copyWith(
              color: kBlack,
            ),
            textAlign: TextAlign.center,
          ),
        )
      ],
    );
  }
}
