import 'package:flutter/material.dart';
import 'package:fzregex/utils/fzregex.dart';
import 'package:fzregex/utils/pattern.dart';
import '../../../Models/User.dart';
import '../../../Widgets/BouncingButton.dart';
import '../ForgetPasseord.dart';
import '../SignUp.dart';
import '../Widgets.dart';

Widget forgotPasswordButton(BuildContext context,Animation delayedAnimation, double width){
  return Padding(
    padding: const EdgeInsets.fromLTRB(0.0, 10, 30, 10),
    child: Transform(
      transform: Matrix4.translationValues(
          delayedAnimation.value * width, 0, 0),
      child: Container(
        alignment: Alignment(1.0, 0),
        child: Bouncing(
          onPress: () {
            Navigator.pop(context);
            showAuthDialog(context,ForgetPassword());
          },
          child: Text(
            "Forgot password?",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.teal[200],
            ),
          ),
        ),
      ),
    ),
  );
}

Widget goToRegisterButton(BuildContext context,Animation delayedAnimation, double width){
  return Padding(
    padding:
    const EdgeInsets.fromLTRB(30.0, 10, 13, 10),
    child: Transform(
      transform: Matrix4.translationValues(
          delayedAnimation.value * width, 0, 0),
      child: Container(
        padding: const EdgeInsets.all(5),
        alignment: Alignment(1.0, 0),
        child: Bouncing(
          onPress: () {
            Navigator.pop(context);
            showAuthDialog(context,SignUp());
          },
          child: Text(
            "Don't Have an account?",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.teal[200],
            ),
          ),
        ),
      ),
    ),
  );
}

Widget emailTextFromField(UserApp userApp){
  return TextFormField(
    validator: (value) {
      var ema = value!.toLowerCase().trim();
      if ((Fzregex.hasMatch(
          ema, FzPattern.email) ==
          false)) {
        return "Enter a valid email address";
      } else {
        return null;
      }
    },
    onSaved: (value) {
      var ema = value!.toLowerCase().trim();
      userApp.email = ema;
    },
    keyboardType: TextInputType.emailAddress,
    decoration: InputDecoration(
      labelText: 'EMAIL',
      contentPadding: EdgeInsets.all(5),
      labelStyle: TextStyle(
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.bold,
          fontSize: 14,
          color: Colors.black),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: Colors.teal[200]!,
        ),
      ),
    ),
  );
}

Widget helloThere(Animation animation,double width){
  return Padding(
    padding: const EdgeInsets.only(top: 20.0),
    child: Transform(
      transform: Matrix4.translationValues(
          animation.value * width, 0.0, 0.0),
      child: Center(
        child: Stack(
          children: <Widget>[
            Container(
              child: Text(
                'Hello',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              child: Padding(
                padding:
                const EdgeInsets.fromLTRB(30.0, 35.0, 0, 0),
                child: Text(
                  'There',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 40.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(135.0, 0.0, 0, 30),
              child: Container(
                child: Text(
                  '.',
                  style: TextStyle(
                      color: Colors.teal[200],
                      fontSize: 80.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}