import 'package:dubai/loading.dart';
import 'package:dubai/pages/login/form_field.dart';
import 'package:dubai/pages/login/wave.dart';
import 'package:dubai/pages/main_secreen/alert.dart';
import 'package:dubai/services/auth.dart';
import 'package:flutter/material.dart';

class Signup extends StatefulWidget {
  final Function toggel;

  Signup({Key key, this.toggel}) : super(key: key);

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  bool hide = true;

  String email, password, reEnterPassword, error;
  bool loading = false;
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    TopShape(),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 20,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            MyFormField(
                              validator: (val) {
                                if (val.isEmpty) {
                                  return 'the email cannot be empty';
                                } else {
                                  return null;
                                }
                              },
                              isPassword: false,
                              prefixIcon: Icons.person,
                              hintText: 'username',
                              onChange: (value) {
                                setState(() {
                                  email = '$value@dubai.com';
                                });
                              },
                            ),
                            SizedBox(height: 10),
                            MyFormField(
                              validator: (val) {
                                if (val.isEmpty || val.length < 6) {
                                  return 'the password can not be less than 6 characters';
                                } else {
                                  return null;
                                }
                              },
                              isPassword: true,
                              prefixIcon: Icons.lock,
                              hintText: 'Password',
                              onChange: (value) {
                                setState(() {
                                  password = value;
                                });
                              },
                            ),
                            SizedBox(height: 10),
                            MyFormField(
                              validator: (val) {
                                if (val != password) {
                                  return 'the password doesnot match';
                                } else {
                                  return null;
                                }
                              },
                              isPassword: hide,
                              prefixIcon: Icons.lock,
                              hintText: 'Re-Enter Password',
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
                                  reEnterPassword = value;
                                });
                              },
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: <Widget>[
                                Text('By tapin sign in you agree to '),
                                Text(
                                  'terms and condition',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 20,
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
                                            .signUpWithEmailAndPassword(
                                                email, password);
                                        if (result == null) {
                                          Dialogs.yesCancellDailog(
                                              context,
                                              'error',
                                              'error please try again soon, or try another user name');
                                          setState(() {
                                            loading = false;
                                          });
                                        }
                                      }
                                    },
                                    child: Text(
                                      'SIGN UP',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16),
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                  ),
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
                                  'ALREADY HAVE AN ACCOUNT ?',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15,
                                    color: Color(0xFF757076),
                                  ),
                                ),
                                FlatButton(
                                    child: Text(
                                      'SIGN IN',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Color(0xFFD44638),
                                      ),
                                    ),
                                    onPressed: () {
                                      widget.toggel();
                                    }),
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
  }
}
