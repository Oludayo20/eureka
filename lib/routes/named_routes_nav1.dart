import 'package:flutter/widgets.dart';
import '../constants/constants.dart';
import '../Screens/screens.dart';
import '../routes/routes.dart';
import '../Authentication/Authentication.dart';
//* Test on navigator1
final Map<String, WidgetBuilder> routes = {
  ///* main 3 pages
  GenerateRootNames.generateRouteName(PageName.studentDashBord): (_) => StudentHome(),
  GenerateRootNames.generateRouteName(PageName.adminHomePage): (_) => AdminHome(),
  //* work-pages
  GenerateRootNames.generateRouteName(PageName.homePage): (context) => HomePage(),
};

String initialRoute(){
  return !AuthenticationHelper.isSignedIn()
      ? GenerateRootNames.generateRouteName(PageName.homePage)
      : AuthenticationHelper.isAdmin()
      ? GenerateRootNames.generateRouteName(PageName.adminHomePage)
      : GenerateRootNames.generateRouteName(PageName.studentDashBord);
}