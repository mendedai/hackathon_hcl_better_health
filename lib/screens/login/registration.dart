import 'package:flutter/material.dart';
import 'package:hcl_better_health/constants.dart';
import 'package:hcl_better_health/screens/login/components/clippers.dart';
import 'package:hcl_better_health/screens/login/components/header.dart';
import 'package:hcl_better_health/screens/login/components/login_registration_form.dart';

class RegistrationScreen extends StatefulWidget {
  static final String route = '/registration';

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite,
      body: Stack(
        children: <Widget>[
          ClipPath(
            clipper: Layer03Clipper(),
            child: Container(
              color: kGrey,
            ),
          ),
          ClipPath(
            clipper: Layer02Clipper(),
            child: Container(
              color: kBlue,
            ),
          ),
          ClipPath(
            clipper: Layer01Clipper(),
            child: Container(
              color: kWhite,
            ),
          ),
          SafeArea(
            child: Column(
              children: <Widget>[
                LoginHeader(),
                Spacer(),
                LoginAndRegistrationForm(
                  isLogin: false,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
