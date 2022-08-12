import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:school_management/Screens/Admin/HomePage/HomePage.dart';
import 'package:school_management/Widgets/TextFieldCard.dart';
import 'package:school_management/firebase_options.dart';
import 'package:school_management/services/authentication_helper.dart';
import 'Screens/Home_Page.dart';
import 'Screens/Students/EachCourse/Exams/Exam_Rseult.dart';
import 'Screens/Students/Home/home.dart';

void main() {
  Future<bool> init() async {
    try {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      return true;
    } on FirebaseOptions catch (e) {
      print(e);
      return false;
    }
  }
  //TODO: Implement the checking of isLogin better
  //runApp(MyApp());
   init().then((val) {
    if (val) {
      FirebaseAuth.instance.authStateChanges().listen((User? user) {
        if (user != null) {
          runApp(MyApp());
        }
      });
      runApp(MyApp());
    } else {
      runApp(ErrorMain());
    }
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
      //initialRoute: 'test',
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '/': (context) {
          return !authenticationHelper.isSignedIn()
              ? HomePage()
              : authenticationHelper.isAdmin()
                  ? AdminHome()
                  : StudentHome();
        },
        'test': (context) => Test(),
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
    TextEditingController controller = TextEditingController();
    return Scaffold(
      body: ListView(
        children: [
          TextFieldCard(
            controller: controller,
            originalHeight: 30,
            headerText: "Karo",
            width: 170,
          ),

        ],
      ),
    );
  }
}

class ErrorMain extends StatelessWidget {
  const ErrorMain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("NetWork error"),
    );
  }
}
