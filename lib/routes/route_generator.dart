import 'package:flutter/material.dart';
import 'package:school_management/Authentication/authentication_helper.dart';
import 'package:school_management/Models/models.dart';
import 'package:school_management/Screens/Students/EachCourse/Exams/Exam_Rseult.dart';
import 'package:school_management/Widgets/widgets.dart';
import 'package:school_management/routes/routes_to_name.dart';
import '../Screens/screens.dart';
import '../constants/constants.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    if (!AuthenticationHelper.isSignedIn())
      return MaterialPageRoute(builder: (_) => HomePage());
    //error
    if (AuthenticationHelper.isAdmin() &&
        settings.name ==
            GenerateRootNames.generateRouteName(PageName.unknown)) {
      return MaterialPageRoute(builder: (_) => AdminHome());
    } else if (settings.name ==
        GenerateRootNames.generateRouteName(PageName.unknown)) {
      return MaterialPageRoute(builder: (_) => StudentHome());
    }
    if (settings.name ==
        GenerateRootNames.generateRouteName(PageName.studentDashBord))
      return MaterialPageRoute(builder: (_) => StudentHome());
    else if (settings.name ==
        GenerateRootNames.generateRouteName(PageName.homePage))
      return MaterialPageRoute(builder: (_) => HomePage());
    else if (settings.name ==
        GenerateRootNames.generateRouteName(PageName.adminHomePage))
      return MaterialPageRoute(builder: (_) => AdminHome());
    //student routs
    else if (settings.name ==
        GenerateRootNames.generateRouteName(PageName.lectureNotes)) {
      if (args is EachCourseArguments) {
        return MaterialPageRoute(
            builder: (_) => EachCourse(
                  eachCourseArguments: args,
                ));
      } else {
        return MaterialPageRoute(builder: (_) => ErrorPage());
      }
    } else if (settings.name ==
        GenerateRootNames.generateRouteName(PageName.takeQuiz)) {
      print(111);
      if (args is QuizViewArgument) {
        return MaterialPageRoute(
            builder: (_) => QuizView(
                  quizViewArgument: args,
                ));
      } else {
        return MaterialPageRoute(builder: (_) => ErrorPage());
      }
    } else if (settings.name ==
        GenerateRootNames.generateRouteName(PageName.viewPastQuizAndTakeQuiz)) {
      if (args is ExamResultArguments) {
        return MaterialPageRoute(
            builder: (_) => ExamResult(
                  examResultArguments: args,
                ));
      } else {
        return MaterialPageRoute(builder: (_) => ErrorPage());
      }
    } else if (settings.name ==
        GenerateRootNames.generateRouteName(
            PageName.viewNoteUnderLectureNote)) {
      if (args is LectureNote) {
        return MaterialPageRoute(
            builder: (_) => NoteView(
                  lectureNote: args,
                ));
      } else {
        return MaterialPageRoute(builder: (_) => ErrorPage());
      }
    } else {
      return MaterialPageRoute(builder: (_) => ErrorPage());
    }
  }
}
