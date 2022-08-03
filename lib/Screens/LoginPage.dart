import 'package:flutter/material.dart';
import 'package:school_management/Screens/Students/Home/home.dart';
import 'package:school_management/Widgets/BouncingButton.dart';
import '../Util/Notify.dart';
import '../services/authentication_helper.dart';
import 'Admin/HomePage/HomePage.dart';
import 'ForgetPasseord.dart';
import 'SignUp.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  Animation? animation, delayedAnimation, muchDelayedAnimation, leftCurve;
  AnimationController? animationController;

  @override
  void initState() {
    WidgetsFlutterBinding.ensureInitialized();
    // Firebase.initializeApp();
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

    leftCurve = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
        parent: animationController!,
        curve: Interval(0.5, 1.0, curve: Curves.easeInOut)));
  }

  @override
  void dispose() {
    animationController!.dispose();
    super.dispose();
  }

  // UserModel _userfromfirebase(FirebaseUser user) {
  //   return user != null ? UserModel(uid: user.uid) : null;
  //   print(user);
  // }

  GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  bool passshow = false;
  String? _pass;
  String? _email;
  String? user1;
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
              ),
              SizedBox(height: 5.0),
              Padding(
                padding: const EdgeInsets.fromLTRB(30.0, 10, 30, 10),
                child: Transform(
                  transform:
                      Matrix4.translationValues(leftCurve!.value * width, 0, 0),
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        Form(
                            key: _formkey,
                            // autovalidate: _autoValidate,
                            child: Column(
                              children: [
                                TextFormField(
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Enter Valid Email address";
                                    } else {
                                      return null;
                                    }
                                  },
                                  onSaved: (value) {
                                    _email = value;
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
                                ),
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
                                          color: Colors.black),
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
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30.0, 10, 13, 10),
                    child: Transform(
                      transform: Matrix4.translationValues(
                          delayedAnimation!.value * width, 0, 0),
                      child: Container(
                        alignment: Alignment(1.0, 0),
                        child: Padding(
                          padding:
                              const EdgeInsets.only(top: 10.0, right: 400.0),
                          child: Bouncing(
                            onPress: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (BuildContext context) => SignUp(),
                                  ));
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
                    ),
                  ),
                  // Forgot Password
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30.0, 10, 30, 10),
                    child: Transform(
                      transform: Matrix4.translationValues(
                          delayedAnimation!.value * width, 0, 0),
                      child: Container(
                        alignment: Alignment(1.0, 0),
                        child: Padding(
                          padding:
                              const EdgeInsets.only(top: 10.0, right: 20.0),
                          child: Bouncing(
                            onPress: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        ForgetPassword(),
                                  ));
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
                    ),
                  ),
                ],
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
                              /*try {
                                final FirebaseUser user =
                                    (await _auth.signInWithEmailAndPassword(
                                  email: _email!,
                                  password: _pass!,
                                ))
                                        .user;
                                dynamic userinfo = _auth.currentUser;
                                return _userfromfirebase(userinfo);
                              } catch (e) {
                                if (e.code == 'user-not-found') {
                                  print("user not found");
                                } else if (e.code == 'wrong-password') {
                                  print("wrong password");
                                } else {
                                  print("check internet connection!");
                                }
                              }
                            } else {
                              setState(() {
                                _autoValidate = true;
                              });
                            }*/
                              Notify.loading(context, "");
                              AuthenticationHelper()
                                  .signIn(email: _email!, password: _pass!)
                                  .then((value) {
                                Navigator.pop(context);
                                if (value == _email) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            _email! == "admin@gmail.com"
                                                ? AdminHome()
                                                : StudentHome(),
                                        // : Home(),
                                      ));
                                } else {
                                  Notify.error(context, value);
                                }
                              });
                            }
                          },
                          child: MaterialButton(
                            onPressed: () {},
                            elevation: 0.0,
                            minWidth: MediaQuery.of(context).size.width,
                            color: Colors.teal[200],
                            child: Text(
                              "Login",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        SizedBox(height: 10.0),

                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Coded By eruka team",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              )
            ],
          ),
        );
      },
    );
  }
}
