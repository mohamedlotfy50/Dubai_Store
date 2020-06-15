import 'dart:io';
import 'package:path/path.dart' as Path;

import 'package:dubai/loading.dart';
import 'package:dubai/models/user_model.dart';
import 'package:dubai/pages/login/form_field.dart';
import 'package:dubai/pages/main_secreen/myapp_bar.dart';
import 'package:dubai/services/database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';

class Settings extends StatefulWidget {
  Settings({Key key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final _formKey = GlobalKey<FormState>();
  String userName;
  String phoneNumber;
  String adress;
  bool isLoading = true;

  File _image;
  String _uploadedFileURL;

  Future chooseFile() async {
    await ImagePicker.pickImage(source: ImageSource.gallery).then((image) {
      setState(() {
        _image = image;
      });
    });
  }

  Future uploadFile() async {
    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child('users/${Path.basename(_image.path)}');
    StorageUploadTask uploadTask = storageReference.putFile(_image);
    await uploadTask.onComplete;
    storageReference.getDownloadURL().then((fileURL) {
      setState(() {
        _uploadedFileURL = fileURL;

        isLoading = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return isLoading
        ? Scaffold(
            resizeToAvoidBottomPadding: false,
            appBar: MyAppBar(),
            body: StreamBuilder<UserData>(
                stream: DataBaseService(uid: user.uid).userData,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    UserData userData = snapshot.data;

                    return Form(
                      key: _formKey,
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Text(
                              'Settings',
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Column(
                              children: <Widget>[
                                InkWell(
                                  onTap: () async {
                                    await chooseFile();
                                    setState(() {
                                      isLoading = false;
                                    });
                                    uploadFile();
                                  },
                                  child: _image == null
                                      ? CircleAvatar(
                                          radius: 50,
                                          backgroundColor: Colors.black45,
                                        )
                                      : CircleAvatar(
                                          radius: 50,
                                          backgroundImage:
                                              NetworkImage(_uploadedFileURL),
                                        ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                MyFormField(
                                  /*validator: (val) {
                                    if (val.isEmpty) {
                                      return 'Please enter a name';
                                    } else {
                                      return null;
                                    }
                                  },*/
                                  isPassword: false,
                                  prefixIcon: Icons.person,
                                  hintText: 'name',
                                  onChange: (value) {
                                    setState(() {
                                      userName = value;
                                    });
                                  },
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                MyFormField(
                                  /* validator: (val) {
                                    if (val.isEmpty) {
                                      return 'wrong phone number';
                                    } else {
                                      return null;
                                    }
                                  },*/
                                  isPassword: false,
                                  prefixIcon: FontAwesomeIcons.phoneAlt,
                                  hintText: 'phone number',
                                  onChange: (value) {
                                    setState(() {
                                      phoneNumber = value;
                                    });
                                  },
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                MyFormField(
                                  /*validator: (val) {
                                    if (val.isEmpty) {
                                      return 'please enter an address';
                                    } else {
                                      return null;
                                    }
                                  },*/
                                  isPassword: false,
                                  prefixIcon: FontAwesomeIcons.mapMarker,
                                  hintText: 'address',
                                  onChange: (value) {
                                    setState(() {
                                      adress = value;
                                    });
                                  },
                                ),
                                SizedBox(
                                  height: 25,
                                ),
                                Container(
                                  width: 150,
                                  height: 50,
                                  child: RaisedButton(
                                    color: Colors.deepOrangeAccent,
                                    child: Text('Update'),
                                    onPressed: () async {
                                      isLoading = false;
                                      if (_formKey.currentState.validate()) {
                                        await DataBaseService(uid: user.uid)
                                            .updateUserCollection(
                                          userName ?? userData.userName,
                                          _uploadedFileURL,
                                          phoneNumber ?? userData.phoneNumber,
                                          adress ?? userData.address,
                                        );

                                        Navigator.pop(context);
                                      }
                                    },
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  } else {
                    return Loaading();
                  }
                }),
          )
        : Loaading();
  }
}
