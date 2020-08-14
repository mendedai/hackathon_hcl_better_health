import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hcl_better_health/screens/dashboard/dashboard.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class TherapyScreen extends StatefulWidget {
  static final String route = 'therapy';

  @override
  _TherapyScreenState createState() => _TherapyScreenState();
}

class _TherapyScreenState extends State<TherapyScreen> {
  int _currentIndex = 0;
  final ItemScrollController itemScrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();

  final List items = [
    '',
    'Scanning database',
    'Finding similar outcomes',
    'Correlating health indicators',
    'Building physiological model',
    'Creating customized therapy plan',
    'Finalizing...',
    '',
  ];

  Widget _getListTile(String title) {
    if (title == '') {
      return ListTile();
    }

    return ListTile(
      leading: Icon(
        Icons.check_circle_outline,
        size: 30,
      ),
      title: Text(title),
    );
  }

  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 1), (Timer timer) {
      if (_currentIndex < items.length - 1) {
        _currentIndex++;
        setState(() {
          print(_currentIndex);
          itemScrollController.scrollTo(
              index: _currentIndex,
              duration: Duration(milliseconds: 350),
              curve: Curves.easeInOutCubic);
        });

        if (_currentIndex == items.length - 2) {
          timer.cancel();
          Navigator.pushNamed(context, DashboardScreen.route);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Container(),
              ),
              Container(
                // color: Colors.blue,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 175,
                      width: 300,
                      // color: Colors.blue,
                      constraints: BoxConstraints(
                        maxHeight: 200,
                        maxWidth: 300,
                      ),
                      child: Stack(
                        children: [
                          Padding(
                            // shift a little to the right to make it feel more centered
                            padding: const EdgeInsets.only(left: 16.0),
                            child: ScrollablePositionedList.builder(
                              itemCount: items.length,
                              itemBuilder: (context, index) =>
                                  _getListTile(items[index]),
                              itemScrollController: itemScrollController,
                              itemPositionsListener: itemPositionsListener,
                            ),
                          ),
                          Container(
                            // color: Colors.black12,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.white,
                                  Colors.white.withOpacity(0),
                                  Colors.white,
                                ],
                                stops: [0.1, 0.5, 0.9],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Center(
                  child: SpinKitDoubleBounce(
                    color: Theme.of(context).primaryColor,
                    size: 50,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
