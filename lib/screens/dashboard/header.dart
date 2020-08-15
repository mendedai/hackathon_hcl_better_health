import 'package:flutter/material.dart';
import 'package:hcl_better_health/constants.dart';
import 'package:hcl_better_health/theme/fonts.dart';

class DashboardHeaderWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        // crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Hi Bill 👋',
                  style: TextStyles.body.copyWith(color: kColorTitle)),
              Text('Good evening',
                  style: TextStyles.pageTitle.copyWith(
                    color: kColorTitle,
                    height: 1.2,
                  )),
            ],
          ),
          Row(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(30.0)),
                ),
                child: Icon(Icons.sync),
              )
            ],
          )
        ],
      ),
    );
  }
}
