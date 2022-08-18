import '../constants/constants.dart';

class AppRoutePath {
  final PageName? pageName;
  final bool isUnkwon;

  ///* while work will be home page, just put null for simplicity
  AppRoutePath.work()
      : isUnkwon = false,
        pageName = null;

  AppRoutePath.about()
      : pageName = PageName.about,
        isUnkwon = false;

  AppRoutePath.contact()
      : pageName = PageName.contact,
        isUnkwon = false;

  AppRoutePath.unknown()
      : pageName = null,
        isUnkwon = true;

  //* work-pages
  AppRoutePath.studentDashBord()
      : pageName = PageName.studentDashBord,
        isUnkwon = false;

  AppRoutePath.lecturesNote()
      : pageName = PageName.lectureNotes,
        isUnkwon = false;


  bool get isWork => pageName == null && !isUnkwon;
  bool get isAbout => pageName == PageName.about && !isUnkwon;
  bool get isContact => pageName == PageName.contact && !isUnkwon;

  //* work pages
  bool get isStudentDashBord =>
      pageName == PageName.studentDashBord && !isUnkwon;

  bool get isLectureNotes =>
      pageName == PageName.lectureNotes && !isUnkwon;


}