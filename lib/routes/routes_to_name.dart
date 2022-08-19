import '../constants/constants.dart';

class GenerateRootNames{
  static String generateRouteName(error) {
    String routeName;
    switch (error) {
      case PageName.studentDashBord:
        routeName = "studentDashBord";
        break;
      case PageName.homePage:
        routeName = "/";
        break;
      case PageName.adminHomePage:
        routeName = "adminDashBoard";
        break;
      case PageName.lectureNotes:
        routeName = "lecturesNotes";
        break;
      case PageName.viewPastQuizAndTakeQuiz:
        routeName = "viewPastQuizAndTakeQuiz";
        break;
      case PageName.takeQuiz:
        routeName = "takeQuiz";
        break;
      case PageName.viewNoteUnderLectureNote:
        routeName = "viewNoteUnderLectureNote";
        break;
      case PageName.unknown:
        routeName = "unknown";
        break;

      default:
        routeName = "/";
    }
    return routeName;
  }
}