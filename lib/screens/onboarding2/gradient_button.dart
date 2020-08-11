import 'package:flutter/material.dart';
import 'package:hcl_better_health/constants.dart';
import 'package:hcl_better_health/theme/fonts.dart';

class GradientButton extends StatelessWidget {
  final Function onPressed;
  final double elevation;
  final String text;

  GradientButton({
    @required this.onPressed,
    @required this.text,
    this.elevation = 10,
  });

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      elevation: elevation,
      padding: EdgeInsets.all(0.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      child: Ink(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            colors: [kPurple1, kPurple3],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 50),
          child: Text(
            text,
            style: TextStyles.title.copyWith(color: Colors.white),
          ),
        ),
      ),
      onPressed: onPressed,
    );
  }
}
