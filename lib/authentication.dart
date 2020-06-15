import 'package:dubai/pages/login/login.dart';
import 'package:dubai/pages/signup/signup.dart';
import 'package:flutter/material.dart';

class Authentication extends StatefulWidget {
  Authentication({Key key}) : super(key: key);

  @override
  _AuthenticationState createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
  bool showSignIn = true;
  void toggelView() {
    setState(() {
      showSignIn = !showSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return Login(
        toggel: toggelView,
      );
    } else {
      return Signup(
        toggel: toggelView,
      );
    }
  }
}
