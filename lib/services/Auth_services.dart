import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:school_management/Screens/Admin/HomePage/HomePage.dart';
import 'package:school_management/Screens/home.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googlesignin = GoogleSignIn();

  void fireBaseSignIn(
      String email, String password, BuildContext context) async {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) =>
              email == "admin@gmail.com" ? AdminHome() : Home(),
        ));
  }

  void googlesignin() async {
    final GoogleSignInAccount? googleuser = await _googlesignin.signIn();
    final GoogleSignInAuthentication? authentication =
        await googleuser?.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: authentication?.accessToken,
      idToken: authentication?.idToken,
    );
  }
}
