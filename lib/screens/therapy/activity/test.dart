import 'package:flutter/material.dart';

class Test extends StatefulWidget {
  final int startInt;

  Test({this.startInt});

  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  void initState() {
    super.initState();
    print('init state!!!!');
  }

  @override
  Widget build(BuildContext context) {
    print('build');
    return Center(
      child: Text(
        widget.startInt.toString(),
        style: TextStyle(
          fontSize: 60,
          color: Colors.white,
        ),
      ),
    );
  }
}
