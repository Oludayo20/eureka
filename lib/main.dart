import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:school_management/Screens/Admin/HomePage/HomePage.dart';
import 'package:school_management/firebase_options.dart';
import 'package:school_management/services/authentication_helper.dart';
import 'Screens/Home_Page.dart';
import 'Screens/Students/EachCourse/Exams/Exam_Rseult.dart';
import 'Screens/Students/Home/home.dart';

void main() {
  Future init() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  //runApp(MyApp());
  init().whenComplete(() {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  }

  @override
  Widget build(BuildContext context) {
    AuthenticationHelper authenticationHelper = AuthenticationHelper();
    return GetMaterialApp(
      title: 'Eureka',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '/': (context) {
          return !authenticationHelper.isSignedIn()
              ? HomePage()
              : authenticationHelper.isAdmin()
                  ? AdminHome()
                  : StudentHome();
        },
        ExamResult.routeName: (context) => const ExamResult(),
        // When navigating to the "/second" route, build the SecondScreen widget.
        //'/second': (context) => const SecondScreen(),
      },
    );
  }
}

class Test extends StatelessWidget {
  const Test({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
          onPressed: () {},
          child: Text("Text"),
        ),
      ),
    );
  }
}
