import 'package:flutter/material.dart';
import 'package:hcl_better_health/components/logo.dart';
import 'package:hcl_better_health/constants.dart';

class LoginHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: kPaddingL),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Logo(
          //   color: kBlue,
          //   size: 32.0,
          // ),
          SizedBox(height: kSpaceM),
          Text(
            'Welcome to Mended',
            style: Theme.of(context).textTheme.headline5.copyWith(
                  color: kBlack,
                  fontWeight: FontWeight.bold,
                ),
          ),
          SizedBox(height: kSpaceM),
          Text(
            'Est ad dolor aute ex commodo tempor exercitation proident.',
            style: Theme.of(context).textTheme.subtitle1.copyWith(
                  color: kBlack.withOpacity(0.5),
                ),
          )
        ],
      ),
    );
  }
}
