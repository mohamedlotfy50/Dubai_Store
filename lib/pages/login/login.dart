import 'package:dubai/loading.dart';
import 'package:dubai/pages/login/form_field.dart';
import 'package:dubai/pages/login/round_button.dart';
import 'package:dubai/pages/login/wave.dart';
import 'package:dubai/pages/main_secreen/alert.dart';
import 'package:dubai/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Login extends StatefulWidget {
  final Function toggel;

  Login({Key key, this.toggel}) : super(key: key);
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String email, password;
  bool loading = false;
  bool hide = true;

  final AuthServices _auth = AuthServices();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loaading()
        : SafeArea(
            child: Scaffold(
              body: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    TopShape(),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 7,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: <Widget>[
                            MyFormField(
                              validator: (val) {
                                if (val.isEmpty) {
                                  return 'please enter an email';
                                } else {
                                  return null;
                                }
                              },
                              isPassword: false,
                              prefixIcon: Icons.person,
                              hintText: 'User Name',
                              onChange: (value) {
                                setState(() {
                                  email = '$value@dubai.com';
                                });
                              },
                            ),
                            SizedBox(height: 10),
                            MyFormField(
                              validator: (val) {
                                if (val.isEmpty) {
                                  return 'please enter a passwoed';
                                } else {
                                  return null;
                                }
                              },
                              isPassword: hide,
                              prefixIcon: Icons.lock,
                              hintText: 'Password',
                              suffixIcon: IconButton(
                                icon: Icon(Icons.remove_red_eye),
                                onPressed: () {
                                  setState(() {
                                    hide = !hide;
                                  });
                                },
                              ),
                              onChange: (value) {
                                setState(() {
                                  password = value;
                                });
                              },
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[],
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                SizedBox(
                                  height: 50,
                                  width: 200,
                                  child: FlatButton(
                                    color: Color(0xFFFF7F11),
                                    onPressed: () async {
                                      if (_formKey.currentState.validate()) {
                                        setState(() {
                                          loading = true;
                                        });
                                        dynamic result = await _auth
                                            .signInWithEmailAndPassword(
                                                email, password);
                                        if (result == null) {
                                          Dialogs.yesCancellDailog(
                                              context,
                                              'error',
                                              'error please try again soon');
                                          setState(() {
                                            loading = false;
                                          });
                                        }
                                      }
                                    },
                                    child: Text(
                                      'SIGN IN',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16),
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                  ),
                                ),
                                RoundButtonIcon(
                                  color: Color(0xFF3b5998),
                                  icon: FaIcon(
                                    FontAwesomeIcons.facebookF,
                                    color: Colors.white,
                                  ),
                                  onpress: () async {
                                    setState(() {
                                      loading = true;
                                    });
                                    dynamic result =
                                        await _auth.signInWithFacbook();
                                    if (result == null) {
                                      Dialogs.yesCancellDailog(context, 'error',
                                          'error please try again soon');
                                      setState(() {
                                        loading = false;
                                      });
                                    }
                                  },
                                ),
                                RoundButtonIcon(
                                  color: Color(0xFFD44638),
                                  icon: FaIcon(FontAwesomeIcons.google),
                                  onpress: () async {
                                    setState(() {
                                      loading = true;
                                    });
                                    dynamic result =
                                        await _auth.signInWithGoogle();
                                    if (result == null) {
                                      Dialogs.yesCancellDailog(context, 'error',
                                          'error please try again soon');
                                      setState(() {
                                        loading = false;
                                      });
                                    }
                                  },
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  'DON\'T HAVE AN ACCOUNT ?',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15,
                                    color: Color(0xFF757076),
                                  ),
                                ),
                                FlatButton(
                                  child: Text(
                                    'SIGN UP',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Color(0xFFD44638),
                                    ),
                                  ),
                                  onPressed: () {
                                    widget.toggel();
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
