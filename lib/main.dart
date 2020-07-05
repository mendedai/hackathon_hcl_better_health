import 'package:flutter/material.dart';
import 'package:hcl_better_health/screens/login/login.dart';
import 'package:hcl_better_health/screens/login/registration.dart';
import 'package:hcl_better_health/screens/onboarding/onboarding.dart';
import 'package:hcl_better_health/screens/questionnaire/questionnaire.dart';
import 'package:hcl_better_health/screens/therapy/activity/activity.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Onboarding Concept',
      initialRoute: OnboardingScreen.route,
      onGenerateRoute: (settings) {
        var routes = {
          OnboardingScreen.route: MaterialPageRoute(builder: (context) {
            var screenHeight = MediaQuery.of(context).size.height;
            return OnboardingScreen(
              screenHeight: screenHeight,
            );
          }),
          LoginScreen.route: MaterialPageRoute(builder: (context) {
            return LoginScreen();
          }),
          RegistrationScreen.route: MaterialPageRoute(builder: (context) {
            return RegistrationScreen();
          }),
          TherapyActivityScreen.route: MaterialPageRoute(builder: (context) {
            return TherapyActivityScreen();
          }),
          QuestionnaireScreen.route: MaterialPageRoute(builder: (context) {
            return QuestionnaireScreen();
          }),
        };

        return routes[settings.name];
      },
    );
  }
}

void main() => runApp(App());
