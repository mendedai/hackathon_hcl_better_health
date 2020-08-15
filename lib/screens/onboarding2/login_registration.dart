import 'package:flutter/material.dart';
import 'package:hcl_better_health/screens/onboarding2/welcome.dart';
import 'login_registration_form.dart';
import 'login_registration_model.dart';

class LoginRegistration extends StatelessWidget {
  final PageController _controller = PageController(
    initialPage: 0,
  );

  @override
  Widget build(BuildContext context) {
    final model = new LoginRegistrationModel();
    model.addListener(() {
      print('animateToPage ${model.currentPage}');

      _controller.animateToPage(
        model.currentPage,
        duration: Duration(
          milliseconds: 350,
        ),
        curve: Curves.easeInOut,
      );
    });

    return Container(
      height: 380,
      child: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: _controller,
        children: [
          LoginAndRegistrationForm(model: model),
          LoginAndRegistrationForm(model: model, isLogin: true),
          WelcomePage(),
        ],
      ),
    );
  }
}
