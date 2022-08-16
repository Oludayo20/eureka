import 'package:flutter/material.dart';
import 'package:school_management/Screens/Students/Home/home.dart';
import 'package:school_management/Widgets/BouncingButton.dart';
import 'package:school_management/services/AuthExceptionHandler.dart';
import '../../../Models/User.dart';
import '../../../Util/Notify.dart';
import '../../../Util/screen_layout.dart';
import '../../../Widgets/CardMaker.dart';
import '../../../services/authentication_helper.dart';
import '../../Admin/HomePage/HomePage.dart';
import 'Widgets.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  Animation? animation, delayedAnimation, muchDelayedAnimation, leftCurve;
  AnimationController? animationController;

  @override
  void initState() {
    WidgetsFlutterBinding.ensureInitialized();
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
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  bool passshow = false;
  UserApp _userApp = UserApp();
  String? user1;
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    Layout layout = Layout(size: MediaQuery.of(context).size);
    animationController!.forward();
    return AnimatedBuilder(
      animation: animationController!,
      builder: (BuildContext context, Widget? child) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: ListView(
            children: <Widget>[
              helloThere(animation!, width),
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
                                emailTextFromField(_userApp),
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
                                    _userApp.password = val;
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
              Container(
                width: width,
                child: layout.width * 0.4 < 300
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          goToRegisterButton(context,delayedAnimation!,width),
                          // Forgot Password
                          forgotPasswordButton(context,delayedAnimation!,width)
                        ],
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          goToRegisterButton(context,delayedAnimation!,width),
                          // Forgot Password
                          forgotPasswordButton(context,delayedAnimation!,width)
                        ],
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
                              Notify.loading(context, "");
                              AuthenticationHelper()
                                  .signIn(email: _userApp.email!, password: _userApp.password!)
                                  .then((value) {
                                Navigator.pop(context);
                                if (value.name == AuthStatus.successful.name) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            _userApp.email! == "admin@gmail.com"
                                                ? AdminHome()
                                                : StudentHome(),
                                        // : Home(),
                                      ));
                                } else {
                                  Notify.error(
                                      context,
                                      AuthExceptionHandler.generateErrorMessage(
                                          value));
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
              ExtraSpace()
            ],
          ),
        );
      },
    );
  }
}
