import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:school_management/Models/LectureNote.dart';
import 'package:school_management/Models/QuizResultInfo.dart';
import 'package:school_management/Screens/Admin/HomePage/HomePage.dart';
import 'package:school_management/Screens/Courses/Course.dart';
import 'package:school_management/Screens/Courses/LactureNote.dart';
import 'package:school_management/firebase_options.dart';
import 'package:school_management/services/authentication_helper.dart';
import 'Models/QuizResult.dart';
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
        home:
            !authenticationHelper.isSignedIn()
          ? HomePage()
          : authenticationHelper.isAdmin()
              ? AdminHome()
              : StudentHome(),
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
          onPressed: () {
            // QuizResult().create(
            //     QuizResult(
            //         quizResultInfo: QuizResultInfo(
            //             endTime: DateTime.now().microsecondsSinceEpoch.toString(),
            //             startTime: DateTime.now().microsecondsSinceEpoch.toString(),
            //             questionNumber: 5,
            //             score: 4),
            //         selectedOption: {1: 3, 2: 2, 3: 1, 4: 4}),
            //     1,
            //     "test");
            QuizResultInfo().read(1, "test").then((value) {
              print(value.length);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => ExamResult(
                    quizResultInfo: value,
                    lectureNote: LectureNote(lectureNoteId: 1,title: "Memory"),
                  ),
                ),
              );
            });


          },
          child: Text("Text"),
        ),
      ),
    );
  }
}

