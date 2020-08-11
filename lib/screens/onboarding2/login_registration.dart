import 'package:flutter/material.dart';
import 'login_registration_form.dart';
import 'login_registration_model.dart';

// class LoginRegistration extends StatefulWidget {
//   @override
//   _LoginRegistrationState createState() => _LoginRegistrationState();
// }

class LoginRegistration extends StatelessWidget {
  final PageController _controller = PageController(
    initialPage: 0,
  );

  @override
  Widget build(BuildContext context) {
    final model = new LoginRegistrationModel();
    model.addListener(() {
      print('animateToPage ${model.currentPage}');
      // setState(() {
      _controller.animateToPage(
        model.currentPage,
        duration: Duration(
          milliseconds: 350,
        ),
        curve: Curves.easeInOut,
      );
      // });
    });

    return Container(
      height: 500,
      child: PageView(
        physics: ClampingScrollPhysics(),
        controller: _controller,
        children: [
          LoginAndRegistrationForm(model: model),
          LoginAndRegistrationForm(model: model, isLogin: true),
        ],
      ),
    );
  }
}
