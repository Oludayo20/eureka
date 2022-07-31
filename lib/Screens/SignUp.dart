import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:fzregex/fzregex.dart';
import 'package:fzregex/utils/pattern.dart';
import 'package:school_management/Models/Department.dart';
import 'package:school_management/Models/Faculty.dart';
import 'package:school_management/Models/Programs.dart';
import 'package:school_management/Models/User.dart';
import 'package:school_management/Screens/Admin/HomePage/HomePage.dart';
import 'package:school_management/Util/Notify.dart';
import 'package:school_management/Util/screen_layout.dart';
import 'package:school_management/Widgets/BouncingButton.dart';
import '../services/authentication_helper.dart';
import 'RequestProcessing.dart';
import 'home.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> with SingleTickerProviderStateMixin {
  Animation? animation, delayedAnimation, muchDelayedAnimation, LeftCurve;
  AnimationController? animationController;

  @override
  void initState() {
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

  bool passshow1 = false;
  bool passshow2 = false;
  String? _pass;
  var confirmPass;
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
              //  Register Heading
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

              //  All TextField
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
                                // Username
                                TextFormField(
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
                                        color: Colors.black),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.teal[200]!,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 20.0),

                                // Email Address
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
                                        color: Colors.black),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.teal),
                                    ),
                                  ),
                                ),
                                /*SizedBox(height: 20.0),

                                //  Phone Number

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

                                // Password 1
                                TextFormField(
                                  obscuringCharacter: '*',

                                  validator: (val) {
                                    confirmPass = val;
                                    if (val!.isEmpty) {
                                      return "Enter Vaild password";
                                    } else if (val.length < 6) {
                                      return "Password must be atleast 6 characters long";
                                    } else {
                                      return null;
                                    }
                                  },
                                  // onSaved: (val) {
                                  //   _pass = val;
                                  // },
                                  decoration: InputDecoration(
                                      suffix: passshow1 == false
                                          ? IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  passshow1 = true;
                                                });
                                              },
                                              icon: Icon(Icons.lock_open),
                                            )
                                          : IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  passshow1 = false;
                                                });
                                              },
                                              icon: Icon(Icons.lock),
                                            ),
                                      labelText: 'Password',
                                      contentPadding: EdgeInsets.all(5),
                                      labelStyle: TextStyle(
                                          fontFamily: 'Montserrat',
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                          color: Colors.black),
                                      focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.teal[200]!))),
                                  obscureText:
                                      passshow1 == false ? true : false,
                                ),

                                //  Password 2
                                TextFormField(
                                  obscuringCharacter: '*',
                                  validator: (val) {
                                    if (val!.isEmpty) {
                                      return "Please Re-Enter New Password";
                                    } else if (val.length < 6) {
                                      return "Password must be atleast 8 characters long";
                                    } else if (val != confirmPass) {
                                      return "Password must be same as above";
                                    } else {
                                      return null;
                                    }
                                  },
                                  onSaved: (val) {
                                    _pass = val;
                                  },
                                  decoration: InputDecoration(
                                      suffix: passshow2 == false
                                          ? IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  passshow2 = true;
                                                });
                                              },
                                              icon: Icon(Icons.lock_open),
                                            )
                                          : IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  passshow2 = false;
                                                });
                                              },
                                              icon: Icon(Icons.lock),
                                            ),
                                      labelText: 'Confirm Password',
                                      contentPadding: EdgeInsets.all(5),
                                      labelStyle: TextStyle(
                                          fontFamily: 'Montserrat',
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                          color: Colors.black),
                                      focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.teal[200]!))),
                                  obscureText:
                                      passshow2 == false ? true : false,
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

              //  Register Button
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
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        CompleteRegistration(
                                            // userApp: UserApp(
                                            //     email: email, password: _pass),
                                            ),
                                  ));
                              // AuthenticationHelper()
                              //     .signUp(email: email, password: _pass!)
                              //     .then((value) {
                              //   if (value == email) {
                              //     Navigator.push(
                              //         context,
                              //         MaterialPageRoute(
                              //           builder: (BuildContext context) =>
                              //               CompleteRegistration(),
                              //         ));
                              //   } else {
                              //     Notify.error(context, value);
                              //     print(value);
                              //   }
                              // });
                            }
                          },
                          child: MaterialButton(
                            onPressed: () {},
                            elevation: 0.0,
                            minWidth: MediaQuery.of(context).size.width,
                            height: 50.0,
                            color: Colors.teal[200],
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

class CompleteRegistration extends StatefulWidget {
  CompleteRegistration({
    Key? key,
    // required this.userApp,
  }) : super(key: key);
  // final UserApp userApp;
  @override
  State<CompleteRegistration> createState() => _CompleteRegistrationState();
}

class _CompleteRegistrationState extends State<CompleteRegistration> {
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  String _selectedItemCountry = "Italia";

  List<String> facultyList = [];
  Map<String, int> facultyMap = {};

  List<String> departmentList = [];
  Map<String, int> departmentMap = {};

  List<String> programList = [];
  Map<String, int> programMap = {};

  @override
  void initState() {
    super.initState();
    getFaculty();
  }

  Future getFaculty() async {
    List<FacultyModel> fList = [];
    FacultyModel().read(fList).whenComplete(() {
      fList.forEach((element) {
        facultyList.add(element.facultyName!);
        facultyMap[element.facultyName!] = element.facultyId!;
      });
    });
  }

  void _getLevel(String level) {
    print(level);
  }

  void _getSemester(String semester) {}
  void _getFaculty(String faculty) {}

  
  void _getDepartment(String department) {
    List<Department> dList = [];
    departmentList.clear();
    Department().read(dList, facultyMap[department]!).whenComplete(() {
      dList.forEach((element) {
        departmentList.add(element.departmentName!);
        departmentMap[element.departmentName!] = element.departmentId!;
      });
    });
  }

  void _getProgramm(String program) {
    List<Programs> pList = [];
    programList.clear();
    Programs().read(pList, departmentMap[program]!).whenComplete(() {
      pList.forEach((element) {
        programList.add(element.programName!);
        programMap[element.programName!] = element.programId!;
      });
    });
  }

  Widget _dropDown(
      double width, String title, List<String> item, Function? function) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          child: Text(
            "$title:",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          width: width,
          child: DropdownSearch<String>(
            popupProps: PopupProps.menu(
              showSelectedItems: true,
              disabledItemFn: (String s) => s.startsWith('I'),
            ),
            items: item,
            onChanged: (value) {
              function!(value);
            },
            selectedItem: title,
            validator: (String? item) {
              if (item == null)
                return "Required field";
              else if (item == "Brazil")
                return "Invalid item";
              else
                return null;
            },
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    List<String> levelList = [
      "100 Level",
      "200 Level",
      "300 Level",
      "400 Level",
      "500 Level"
    ];
    List<String> semesterList = [
      "First Semester",
      "Second Semester",
    ];
    Layout layout = Layout(size: MediaQuery.of(context).size);
    return Center(
      child: Container(
        width: layout.isAndroid ? layout.width : layout.width * 0.4,
        child: Scaffold(
          body: ListView(
            children: <Widget>[
              //  Register Heading
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                // child: Transform(
                //   transform:
                //       Matrix4.translationValues(animation!.value * width, 0.0, 0.0),
                child: Center(
                  child: Stack(
                    children: <Widget>[
                      Container(
                        child: Text(
                          'Complete',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 40.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(70.0, 35.0, 0, 0),
                          child: Text(
                            'Your Registration',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 40.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(370.0, 0.0, 0, 30),
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
              Padding(
                padding: const EdgeInsets.fromLTRB(30.0, 10, 30, 10),
                child: Container(
                    child: Column(
                  children: <Widget>[
                    Form(
                      key: _formkey,
                      child: Column(
                        children: [
                          layout.isAndroid
                              ? Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      30.0, 10, 30, 10),
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        _dropDown(layout.width * 0.8, "Level",
                                            levelList, _getLevel),
                                        SizedBox(
                                          height: 10.0,
                                        ),
                                        _dropDown(
                                            layout.width * 0.8,
                                            "Semester",
                                            semesterList,
                                            _getSemester),
                                      ]))
                              : Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      30.0, 10, 30, 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      _dropDown(layout.width * 0.15, "Level",
                                          levelList, _getLevel),
                                      _dropDown(layout.width * 0.15, "Semester",
                                          levelList, _getSemester),
                                    ],
                                  ),
                                ),

                          Padding(
                            padding:
                                const EdgeInsets.fromLTRB(30.0, 10, 30, 10),
                            child: _dropDown(
                                layout.isAndroid
                                    ? layout.width * 0.8
                                    : layout.width * 0.34,
                                "Faculty",
                                facultyList,
                                _getDepartment),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.fromLTRB(30.0, 10, 30, 10),
                            child: _dropDown(
                                layout.isAndroid
                                    ? layout.width * 0.8
                                    : layout.width * 0.34,
                                "Department",
                                departmentList,
                                _getProgramm),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.fromLTRB(30.0, 10, 30, 10),
                            child: _dropDown(
                                layout.isAndroid
                                    ? layout.width * 0.8
                                    : layout.width * 0.34,
                                "Program/Course",
                                programList,
                                _getProgramm),
                          ),

                          // Button
                          Padding(
                            padding:
                                const EdgeInsets.fromLTRB(20.0, 5, 20.0, 5),
                            child: Container(
                              child: Column(
                                children: <Widget>[
                                  Bouncing(
                                    onPress: () {
                                      if (_formkey.currentState!.validate()) {
                                        _formkey.currentState!.save();
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  CompleteRegistration(
                                                      // userApp: UserApp(
                                                      //     email: email, password: _pass),
                                                      ),
                                            ));
                                        // AuthenticationHelper()
                                        //     .signUp(email: email, password: _pass!)
                                        //     .then((value) {
                                        //   if (value == email) {
                                        //     Navigator.push(
                                        //         context,
                                        //         MaterialPageRoute(
                                        //           builder: (BuildContext context) =>
                                        //               CompleteRegistration(),
                                        //         ));
                                        //   } else {
                                        //     Notify.error(context, value);
                                        //     print(value);
                                        //   }
                                        // });
                                      }
                                    },
                                    child: MaterialButton(
                                      onPressed: () {},
                                      elevation: 0.0,
                                      minWidth:
                                          MediaQuery.of(context).size.width,
                                      height: 50.0,
                                      color: Colors.teal[200],
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
                        ],
                      ),
                    )
                  ],
                )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
