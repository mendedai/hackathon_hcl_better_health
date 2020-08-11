import 'package:flutter/material.dart';
import 'package:hcl_better_health/constants.dart';
import 'package:hcl_better_health/screens/dashboard/dashboard.dart';
import 'package:hcl_better_health/screens/discover/feed_screen.dart';
import 'package:hcl_better_health/screens/discover/tittok_screen.dart';
import 'package:hcl_better_health/screens/insights/insight_screen.dart';
import 'package:hcl_better_health/screens/login/login.dart';
import 'package:hcl_better_health/screens/login/registration.dart';
import 'package:hcl_better_health/screens/onboarding2/onboarding_screen.dart';
import 'package:hcl_better_health/screens/questionnaire/questionnaire.dart';
import 'package:hcl_better_health/screens/therapy/activity/activity.dart';
import 'package:hcl_better_health/screens/therapy/therapy.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Onboarding Concept',
      theme: ThemeData.from(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: kPurpleSwatch,
        ),
      ),
      initialRoute: OnboardingScreen.route,
      onGenerateRoute: (settings) {
        var routes = {
          OnboardingScreen.route: MaterialPageRoute(builder: (context) {
            var screenHeight = MediaQuery.of(context).size.height;
            return OnboardingScreen(
              screenHeight: screenHeight,
            );
          }),
          // LoginScreen.route: MaterialPageRoute(builder: (context) {
          //   return LoginScreen();
          // }),
          // RegistrationScreen.route: MaterialPageRoute(builder: (context) {
          //   return RegistrationScreen();
          // }),
          TherapyScreen.route: MaterialPageRoute(builder: (context) {
            return TherapyScreen();
          }),
          TherapyActivityScreen.route: MaterialPageRoute(builder: (context) {
            return TherapyActivityScreen();
          }),
          QuestionnaireScreen.route: MaterialPageRoute(builder: (context) {
            return QuestionnaireScreen();
          }),
          DashboardScreen.route: MaterialPageRoute(builder: (context) {
            return DashboardScreen();
          }),
          FeedScreen.route: MaterialPageRoute(builder: (context) {
            return FeedScreen();
          }),
          WebViewExample.route: MaterialPageRoute(builder: (context) {
            return WebViewExample();
          }),
          InsightScreen.route: MaterialPageRoute(builder: (context) {
            return InsightScreen();
          })
        };

        return routes[settings.name];
      },
    );
  }
}

void main() => runApp(App());
