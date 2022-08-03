import 'dart:async';
import 'package:flutter/material.dart';
import 'package:school_management/Models/ProgramCourse.dart';
import 'package:school_management/Models/User.dart';
import 'package:school_management/Screens/Students/EachCourse/EachCourse.dart';
import 'package:school_management/Util/Notify.dart';
import 'package:school_management/Widgets/AppBar.dart';
import 'package:school_management/Widgets/MainDrawer.dart';
import '../../../Models/Course.dart';
import '../../../Models/LectureNote.dart';
import '../../../Models/Student.dart';
import '../../../Util/ImagePath.dart';
import '../../../Util/screen_layout.dart';
import '../../../services/authentication_helper.dart';
import '../EachCourse/Method.dart';
import 'Widgets.dart';

class StudentHome extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<StudentHome>
    with SingleTickerProviderStateMixin {
  Animation? animation, delayedAnimation, muchDelayedAnimation, leftCurve;
  AnimationController? animationController;
  List<Widget> showingWidgets = [];
  int selectedCourse = 0;
  Student? student;
  CurrentUser? currentUser;
  List<Course> courseList = [];
  @override
  void initState() {
    // TODO: implement initState
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
    AuthenticationHelper authenticationHelper = AuthenticationHelper();
    currentUser = authenticationHelper.getUser();
    //getStudentDetails();
    getCourse();
  }

  Future getCourse() async {
    await Course().read(courseList).whenComplete(() {});
  }

  Future<void> getCourseUnderProgram() async {
    List<ProgramCourse> proList = [];
    List<Course> allCourse = [];
    var set = Set<int>();
    await ProgramCourse()
        .read(proList, student!.programId!)
        .whenComplete(() async {
      proList.forEach((val) {
        set.add(val.courseId!);
      });
      await Course().read(allCourse).whenComplete(() {
        allCourse.forEach((course) {
          if (set.contains(course.courseId)) {
            courseList.add(course);
          }
        });
      });
    });
  }

  Future<void> getStudentDetails() async {
    student = await Student().read(currentUser!.uid!);
  }

  EachCourseMethod? eachCourseMethod;

  Future<void> showEachCourse(int index) async {
    eachCourseMethod = EachCourseMethod();
    selectedCourse = index;
    await LectureNote()
        .read(eachCourseMethod!.list, courseList[index].courseId!)
        .whenComplete(() {
      if (eachCourseMethod!.list.isEmpty) {
        Notify.error(context, "Lecture note not available");
      } else {
        eachCourseMethod!.passOnlyActiveLectureNote();
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => EachCourse(
                    course: courseList[selectedCourse],
                    eachCourseMethod: eachCourseMethod!,
                  )),
        );
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    animationController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey =
        new GlobalKey<ScaffoldState>();
    animationController!.forward();
    Layout layout = Layout(size: MediaQuery.of(context).size);
    return AnimatedBuilder(
      animation: animationController!,
      builder: (BuildContext context, Widget? child) {
        return Scaffold(
          key: _scaffoldKey,
          drawer: Drawer(
            elevation: 0,
            child: MainDrawer(),
          ),
          appBar: CommonAppBar(
            menuenabled: true,
            notificationenabled: true,
            ontap: () {
              _scaffoldKey.currentState!.openDrawer();
            },
            title: "Student Dashboard",
          ),
          body: Container(
            decoration: BoxDecoration(
                color: Colors.black,
                image: DecorationImage(
                    image: NetworkImage(ImagePath.home),
                    fit: layout.isAndroid ? BoxFit.cover : BoxFit.fill)),
            child: ListView(
              children: studentCoursesByColumn(
                  courseList,
                  context,
                  muchDelayedAnimation!,
                  Student(fullName: currentUser!.displayName),
                  showEachCourse),
            ),
          ),
        );
      },
    );
  }
}
