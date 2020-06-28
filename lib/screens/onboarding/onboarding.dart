import 'package:flutter/material.dart';
import 'package:hcl_better_health/components/header.dart';
import 'package:hcl_better_health/components/text_column.dart';
import 'package:hcl_better_health/constants.dart';
import 'package:hcl_better_health/screens/onboarding/pages/pages.dart';

class OnboardingScreen extends StatefulWidget {
  static final String route = '/onboarding';

  final double screenHeight;

  const OnboardingScreen({
    @required this.screenHeight,
  });


  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int _currentPage = 1;

  bool get isFirstPage => _currentPage == 1;

  Widget _getPage() {
    // TODO implement the pages and update this
    return OnboardingPages(
      currentPage: _currentPage,
      lightCardChild: Container(),
      darkCardChild: Container(),
      textColumn: TextColumn(
        title: 'Hello World',
        text: 'Lorem ipsum dolor',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBlue,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(kPaddingL),
          child: Column(
            children: <Widget>[
              Header(
                onSkip: () {
                  print('onSkip');
                },
              ),
              Expanded(
                child: _getPage(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
