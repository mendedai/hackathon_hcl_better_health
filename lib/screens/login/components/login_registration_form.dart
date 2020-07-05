import 'package:flutter/material.dart';
import 'package:hcl_better_health/constants.dart';
import 'package:hcl_better_health/screens/login/components/button.dart';
import 'package:hcl_better_health/screens/login/components/input_field.dart';
import 'package:hcl_better_health/screens/login/login.dart';
import 'package:hcl_better_health/screens/login/registration.dart';
import 'package:hcl_better_health/screens/questionnaire/questionnaire.dart';
import 'package:hcl_better_health/screens/therapy/activity/activity.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginAndRegistrationForm extends StatelessWidget {
  final bool isLogin;

  LoginAndRegistrationForm({this.isLogin});

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
        children: <Widget>[
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
          SizedBox(height: space),
          CustomButton(
            color: kBlue,
            textColor: kWhite,
            text: isLogin == true ? 'Log in' : 'Create account',
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
                  // Navigator.pushNamed(context, TherapyActivityScreen.route);
                  Navigator.pushNamed(context, QuestionnaireScreen.route);
                }
              } catch (e) {
                print(e);
              }
            },
          ),
          SizedBox(height: 4 * space),
          CustomButton(
            color: kWhite,
            textColor: kBlack.withOpacity(0.5),
            text: 'Continue with Google',
            // image: Image(
            //   image: AssetImage(kGoogleLogoPath),
            //   height: 48.0,
            // ),
            onPressed: () {},
          ),
          SizedBox(height: space),
          CustomButton(
            color: kBlack,
            textColor: kWhite,
            text: isLogin == true
                ? 'New here? Create an account'
                : 'Have an account? Log in',
            onPressed: () {
              String route = isLogin == true
                  ? RegistrationScreen.route
                  : LoginScreen.route;

              print('go to $route | isLogin = $isLogin');
              Navigator.pushNamed(context, route);
            },
          ),
        ],
      ),
    );
  }
}
