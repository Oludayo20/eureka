// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:school_management/Screens/Leave_Apply/Leave_apply.dart';
import 'package:school_management/Screens/LoginPage.dart';
import 'package:school_management/Screens/SpleashScreen.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'Screens/Admin/Courses/Course.dart';
import 'Screens/Admin/Courses/QuizView/Quiz.dart';
import 'Screens/Home_Page.dart';
import 'firebase_options.dart';

void main() {
  Future init() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }
  init().whenComplete(() {
    runApp(MyApp());
  });

}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Eureka',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      /*home: Scaffold(
          body: SfPdfViewer.network(
              'https://cdn.syncfusion.com/content/PDFViewer/flutter-succinctly.pdf')),*/
      home: QuizView(lectureNoteId: 1, title: "Memory",),
    );
  }
}
