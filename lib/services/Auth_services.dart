import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:school_management/Screens/Admin/HomePage/HomePage.dart';
import 'package:school_management/Screens/Students/Home/home.dart';

class AuthService {
  final GoogleSignIn _googlesignin = GoogleSignIn();

  void fireBaseSignIn(
      String email, String password, BuildContext context) async {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) =>
              email == "admin@gmail.com" ? AdminHome() : StudentHome(),
        ));
  }

  void googleSignIn() async {
    final GoogleSignInAccount? googleuser = await _googlesignin.signIn();
  }
}
