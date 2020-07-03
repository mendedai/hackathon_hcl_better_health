import 'package:flutter/material.dart';

class Layer01Clipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path()
      ..lineTo(0.0, 220.0)
      ..quadraticBezierTo(
        size.width / 2.2,
        260.0,
        size.width,
        170.0,
      )
      ..lineTo(size.width, 0.0)
      ..close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}

class Layer02Clipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path()
      ..lineTo(0.0, 265.0)
      ..quadraticBezierTo(
        size.width / 2.2,
        285.0,
        size.width,
        185.0,
      )
      ..lineTo(size.width, 0.0)
      ..close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}

class Layer03Clipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path()
      ..lineTo(0.0, 310.0)
      ..quadraticBezierTo(
        size.width / 2.2,
        310.0,
        size.width,
        210.0,
      )
      ..lineTo(size.width, 0.0)
      ..close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
