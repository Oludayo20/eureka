import 'package:flutter/material.dart';
import 'package:fzregex/fzregex.dart';
import 'package:fzregex/utils/pattern.dart';
import 'package:school_management/Widgets/BouncingButton.dart';

import '../services/authentication_helper.dart';
import 'RequestProcessing.dart';
import 'home.dart';

class RequestLogin extends StatefulWidget {
  @override
  _RequestLoginState createState() => _RequestLoginState();
}

class _RequestLoginState extends State<RequestLogin>
    with SingleTickerProviderStateMixin {
  Animation? animation, delayedAnimation, muchDelayedAnimation, LeftCurve;
  AnimationController? animationController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animationController =
        AnimationController(duration: Duration(seconds: 3), vsync: this);
    animation = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
        parent: animationController!, curve: Curves.fastOutSlowIn));

    delayedAnimation = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
        parent: animationController!,
        curve: Interval(0.5, 1.0, curve: Curves.fastOutSlowIn)));

    muchDelayedAnimation = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
        parent: animationController!,
        curve: Interval(0.8, 1.0, curve: Curves.fastOutSlowIn)));

    LeftCurve = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
        parent: animationController!,
        curve: Interval(0.5, 1.0, curve: Curves.easeInOut)));
  }

  bool passshow = false;
  String? _pass;
  late String email, phno, _class, name, rollno = "";
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    animationController!.forward();
    return AnimatedBuilder(
      animation: animationController!,
      builder: (BuildContext context, Widget? child) {
        return Scaffold(
          body: ListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Transform(
                  transform: Matrix4.translationValues(
                      animation!.value * width, 0.0, 0.0),
                  child: Center(
                    child: Stack(
                      children: <Widget>[
                        Container(
                          child: Text(
                            'Register',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 40.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          child: Padding(
                            padding:
                                const EdgeInsets.fromLTRB(70.0, 35.0, 0, 0),
                            child: Text(
                              'Yourself',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 40.0,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(220.0, 0.0, 0, 30),
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
              ),
              SizedBox(height: 5.0),
              Padding(
                padding: const EdgeInsets.fromLTRB(30.0, 10, 30, 10),
                child: Transform(
                  transform:
                      Matrix4.translationValues(LeftCurve!.value * width, 0, 0),
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        Form(
                            key: _formkey,
                            child: Column(
                              children: [
                                /*  TextFormField(
                                  validator: (value) {
                                    RegExp nameRegExp = RegExp('[a-zA-Z]');
                                    RegExp numberRegExp = RegExp(r'\d');
                                    if (value!.isEmpty) {
                                      return 'You Must enter your Username!';
                                    } else if (nameRegExp.hasMatch(value)) {
                                      return null;
                                    } else {
                                      return 'Enter Vaild username';
                                    }
                                  },
                                  onSaved: (val) {
                                    name = val!;
                                  },
                                  keyboardType: TextInputType.name,
                                  decoration: InputDecoration(
                                    labelText: 'Username',
                                    contentPadding: EdgeInsets.all(5),
                                    labelStyle: TextStyle(
                                        fontFamily: 'Montserrat',
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        color: Colors.grey),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.teal[200]!,
                                      ),
                                    ),
                                  ),
                                ),

                                SizedBox(height: 20.0),*/
                                TextFormField(
                                  validator: (value) {
                                    if ((Fzregex.hasMatch(
                                            value!, FzPattern.email) ==
                                        false)) {
                                      return "Enter Vaild Email address";
                                    } else {
                                      return null;
                                    }
                                  },
                                  onSaved: (value) {
                                    email = value!;
                                  },
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                      labelText: 'E-Mail',
                                      contentPadding: EdgeInsets.all(5),
                                      labelStyle: TextStyle(
                                          fontFamily: 'Montserrat',
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                          color: Colors.grey),
                                      focusedBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.green))),
                                ),
                                /*SizedBox(height: 20.0),
                                TextFormField(
                                  validator: (value) {
                                    String pattern =
                                        r'(^(?:[+0]9)?[0-9]{10,12}$)';
                                    RegExp regExp = new RegExp(pattern);
                                    if (value!.length == 0) {
                                      return 'Please enter mobile number';
                                    } else if (!regExp.hasMatch(value)) {
                                      return 'Please enter valid mobile number';
                                    }
                                    return null;
                                  },
                                  onSaved: (val) {
                                    phno = val!;
                                  },
                                  decoration: InputDecoration(
                                      labelText: 'Phone Number',
                                      contentPadding: EdgeInsets.all(5),
                                      labelStyle: TextStyle(
                                          fontFamily: 'Montserrat',
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                          color: Colors.grey),
                                      focusedBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.green))),
                                ),*/
                                SizedBox(height: 20.0),
                                TextFormField(
                                  obscuringCharacter: '*',
                                  validator: (val) {
                                    if (val!.isEmpty) {
                                      return "Enter Vaild password";
                                    } else {
                                      return null;
                                    }
                                  },
                                  onSaved: (val) {
                                    _pass = val;
                                  },
                                  decoration: InputDecoration(
                                      suffix: passshow == false
                                          ? IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  passshow = true;
                                                });
                                              },
                                              icon: Icon(Icons.lock_open),
                                            )
                                          : IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  passshow = false;
                                                });
                                              },
                                              icon: Icon(Icons.lock),
                                            ),
                                      labelText: 'PASSWORD',
                                      contentPadding: EdgeInsets.all(5),
                                      labelStyle: TextStyle(
                                          fontFamily: 'Montserrat',
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                          color: Colors.grey),
                                      focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.teal[200]!))),
                                  obscureText: passshow == false ? true : false,
                                ),
                              ],
                            )),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 5, 20.0, 5),
                child: Transform(
                  transform: Matrix4.translationValues(
                      muchDelayedAnimation!.value * width, 0, 0),
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        Bouncing(
                          onPress: () {
                            if (_formkey.currentState!.validate()) {
                              _formkey.currentState!.save();
                              AuthenticationHelper()
                                  .signUp(email: email, password: _pass!)
                                  .then((value) {
                                print(value);
                                if (value == email) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            Home(),
                                      ));
                                } else {
                                  print(value);
                                }
                              });
                            }
                          },
                          child: MaterialButton(
                            onPressed: () {},
                            elevation: 0.0,
                            minWidth: MediaQuery.of(context).size.width,
                            color: Colors.green,
                            child: Text(
                              "Register",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
            ],
          ),
        );
      },
    );
  }
}
