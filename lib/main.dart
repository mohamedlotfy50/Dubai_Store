import 'package:dubai/models/user_model.dart';
import 'package:dubai/services/auth.dart';
import 'package:dubai/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthServices().user,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Dubai Tech',
        theme: ThemeData(primaryColor: Color(0xFFFF7F11)),
        home: Wrapper(),
      ),
    );
  }
}
