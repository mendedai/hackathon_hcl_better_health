import 'package:flutter/material.dart';
import 'package:hcl_better_health/constants.dart';
import 'package:hcl_better_health/screens/login/login.dart';
import 'package:hcl_better_health/screens/login/registration.dart';
import 'package:hcl_better_health/screens/onboarding/components/header.dart';
import 'package:hcl_better_health/screens/onboarding/components/next_page_button.dart';
import 'package:hcl_better_health/screens/onboarding/pages/01_page/index.dart';
import 'package:hcl_better_health/screens/onboarding/pages/02_page/index.dart';
import 'package:hcl_better_health/screens/onboarding/pages/03_page/index.dart';
import 'package:hcl_better_health/screens/onboarding/pages/manager.dart';

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
    switch (_currentPage) {
      case 1:
        return OnboardingPageManager(
          currentPage: _currentPage,
          lightCardChild: FirstPageLightCardContent(),
          darkCardChild: FirstPageDarkCardContent(),
          textColumn: FirstPageTextColumn(),
        );
        break;
      case 2:
        return OnboardingPageManager(
          currentPage: _currentPage,
          lightCardChild: SecondPageLightCardContent(),
          darkCardChild: SecondPageDarkCardContent(),
          textColumn: SecondPageTextColumn(),
        );
        break;
      case 3:
        return OnboardingPageManager(
          currentPage: _currentPage,
          lightCardChild: ThirdPageLightCardContent(),
          darkCardChild: ThirdPageDarkCardContent(),
          textColumn: ThirdPageTextColumn(),
        );
        break;
      default:
        throw Exception('Page $_currentPage not implemented');
    }
  }

  void _nextPage() {
    setState(() {
      _currentPage < 3 ? _currentPage++ : _goToRegistration();
    });
  }

  void _goToRegistration() {
    // TODO animate the go to login/registration transition
    Navigator.pushNamed(context, RegistrationScreen.route);
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
                onSkip: _goToRegistration,
              ),
              Expanded(
                child: _getPage(),
              ),
              NextPageButton(
                onPressed: _nextPage,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
