import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hcl_better_health/constants.dart';

class Logo extends StatelessWidget {
  final Color color;
  final double size;

  Logo({@required this.color, @required this.size});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Mended',
      style: Theme.of(context).textTheme.headline5.copyWith(
            color: color,
            fontWeight: FontWeight.bold,
            fontSize: size,
          ),
    );
    // return Transform.rotate(
    //   angle: -pi / 4,
    //   child: Icon(
    //     Icons.format_bold,
    //     color: color,
    //     size: size,
    //   ),
    // );
  }
}
