import 'package:dubai/authentication.dart';
import 'package:dubai/models/user_model.dart';
import 'package:dubai/pages/main_secreen/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatefulWidget {
  Wrapper({Key key}) : super(key: key);

  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    if (user == null) {
      return Authentication();
    } else {
      return ManiScreen();
    }
  }
}
