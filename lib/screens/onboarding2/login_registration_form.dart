import 'package:flutter/material.dart';
import 'package:hcl_better_health/constants.dart';
import 'package:hcl_better_health/screens/dashboard/dashboard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hcl_better_health/screens/onboarding2/gradient_button.dart';
import 'package:hcl_better_health/screens/questionnaire/questionnaire.dart';
import 'package:hcl_better_health/screens/therapy/therapy.dart';
import 'package:hcl_better_health/theme/fonts.dart';

import 'input_field.dart';
import 'login_registration_model.dart';

class LoginAndRegistrationForm extends StatelessWidget {
  final bool isLogin;
  final LoginRegistrationModel model;

  LoginAndRegistrationForm({this.isLogin, this.model});

  @override
  Widget build(BuildContext context) {
    print('isLogin = $isLogin');

    var height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    var space = height > 650 ? kSpaceM : kSpaceS;

    final _auth = FirebaseAuth.instance;
    String email = 'andre+1@gmail.com'; // TODO remove
    String password = '123456'; // TODO remove

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: kPaddingL),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _getTitle(isLogin),
              SizedBox(
                height: space,
              ),
              CustomInputField(
                label: 'Email',
                prefixIcon: Icons.person,
                obscureText: false,
                keyboardType: TextInputType.emailAddress,
                onChanged: (val) {
                  email = val.toString().trim();
                },
                text: email,
              ),
              SizedBox(height: space),
              // TODO implement reveal obscured text button
              CustomInputField(
                label: 'Password',
                prefixIcon: Icons.lock,
                obscureText: true,
                onChanged: (val) {
                  password = val.toString().trim();
                },
                text: password,
              ),
              SizedBox(height: 2 * space),
              Align(
                alignment: Alignment.centerRight,
                child: GradientButton(
                  onPressed: () async {
                    var user;
                    try {
                      if (isLogin == true) {
                        user = await _auth.signInWithEmailAndPassword(
                          email: email,
                          password: password,
                        );
                      } else {
                        user = await _auth.createUserWithEmailAndPassword(
                          email: email,
                          password: password,
                        );
                      }
                      if (user != null) {
                        // Navigator.pushNamed(context, DashboardScreen.route);
                        // Navigator.pushNamed(context, QuestionnaireScreen.route);
                        Navigator.pushNamed(context, TherapyScreen.route);
                      }
                    } catch (e) {
                      print(e);
                    }
                  },
                  text: isLogin == true ? 'Sign in' : 'Create account',
                ),
              ),
            ],
          ),
          _getGotoLoginOrRegistration(isLogin),
        ],
      ),
    );
  }

  Widget _getTitle(bool isLogin) {
    final String title = isLogin == true ? 'Log in now' : 'Join Mended';
    return Text(
      title,
      style: TextStyles.sectionTitle.bold,
    );
  }

  Widget _getGotoLoginOrRegistration(bool isLogin) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        isLogin == true
            ? Text('Need an account?')
            : Text('Already have an account?'),
        FlatButton(
          color: Colors.black12,
          child: isLogin == true ? Text('Join Mended') : Text('Sign in'),
          onPressed: () {
            isLogin == true ? model.goToRegister() : model.goToLogin();
          },
        ),
      ],
    );
  }
}
