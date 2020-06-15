import 'package:dubai/models/user_model.dart';
import 'package:dubai/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'dart:convert' as JSON;
import 'package:http/http.dart' as http;
import 'package:google_sign_in/google_sign_in.dart';

class AuthServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final facebookLogin = FacebookLogin();

  Future signInWithGoogle() async {
    try {
      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      FirebaseUser user = (await _auth.signInWithCredential(credential)).user;
      DataBaseService(uid: user.uid).updateUserCollection(
        user.displayName,
        user.photoUrl,
        user.phoneNumber,
        '',
      );
      return _userFromFirebase(user);
    } catch (e) {
      return null;
    }
  }

  Future signInWithFacbook() async {
    try {
      final FacebookLoginResult facebookUser =
          await facebookLogin.logInWithReadPermissions(['email']);

      final FacebookAccessToken facebookAuth = facebookUser.accessToken;

      AuthCredential credential = FacebookAuthProvider.getCredential(
        accessToken: facebookAuth.token,
      );
      final token = facebookUser.accessToken.token;

      final graphResponse = await http.get(
          'https://graph.facebook.com/v2.12/me?fields=name,picture,email&access_token=$token');
      final profile = JSON.jsonDecode(graphResponse.body);

      FirebaseUser user = (await _auth.signInWithCredential(credential)).user;
      DataBaseService(uid: user.uid).updateUserCollection(
        profile['name'],
        profile['picture']['data']['url'],
        'no number yet',
        '',
      );
      return _userFromFirebase(user);
    } catch (e) {
      return null;
    }
  }

  User _userFromFirebase(FirebaseUser user) {
    if (user != null) {
      return User(
        uid: user.uid,
      );
    } else {
      return null;
    }
  }

  Stream<User> get user {
    return _auth.onAuthStateChanged.map(_userFromFirebase);
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      return null;
    }
  }

  Future signUpWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      FirebaseUser user = result.user;
      DataBaseService(uid: user.uid)
          .updateUserCollection('new member', '', 'no number yet', '');
      return _userFromFirebase(user);
    } catch (e) {
      return null;
    }
  }

  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      return _userFromFirebase(user);
    } catch (e) {
      return null;
    }
  }
}
