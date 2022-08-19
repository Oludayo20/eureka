import 'package:flutter/material.dart';
import 'package:school_management/Models/models.dart';
import 'package:school_management/Widgets/widgets.dart';
import 'package:school_management/Widgets/UserDetailCard.dart';
import '../../../Util/ImagePath.dart';
import '../../Courses/Course.dart';
import '../AdminMainDrawer.dart';

class AdminHome extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<AdminHome> with SingleTickerProviderStateMixin {
  Animation? animation, delayedAnimation, muchDelayedAnimation, leftCurve;
  AnimationController? animationController;

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
  }

  @override
  void dispose() {
    // TODO: implement dispose
    animationController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    animationController!.forward();
    return AnimatedBuilder(
      animation: animationController!,
      builder: (BuildContext context, Widget? child) {
        final GlobalKey<ScaffoldState> _scaffoldKey =
            new GlobalKey<ScaffoldState>();
        return Scaffold(
          key: _scaffoldKey,
          drawer: Drawer(
            elevation: 0,
            child: AdminMainDrawer(),
          ),
          appBar: CommonAppBar(
            menuenabled: true,
            notificationenabled: false,
            ontap: () {
              _scaffoldKey.currentState!.openDrawer();
            },
            title: "Dashboard",
          ),
          body: Container(
            decoration: BoxDecoration(
                color: Colors.black,
                image: DecorationImage(
                    image: NetworkImage(ImagePath.home),
                    //image: AssetImage(ImagePath().homePageImageAssert),
                    fit: width < 650 ? BoxFit.cover : BoxFit.fill)),
          child: ListView(
            children: [
              UserDetailCard(
                user: UserApp(
                    userName: "Admin",
                    profilePic: "assets/home.png",
                    section: "Main",
                    standard: "Main"),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30.0, 10, 30, 10),
                child: Container(
                  alignment: Alignment(1.0, 0),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10.0, right: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Transform(
                          transform: Matrix4.translationValues(
                              muchDelayedAnimation!.value * width, 0, 0),
                          child: Bouncing(
                            onPress: () {
                              /*Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        Faculty(),
                                  ));*/
                            },
                            child: DashboardCard(
                              name: "Faculty",
                              imgpath: "attendance.png",
                            ),
                          ),
                        ),
                        Transform(
                          transform: Matrix4.translationValues(
                              delayedAnimation!.value * width, 0, 0),
                          child: Bouncing(
                            onPress: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        CourseView(),
                                  ));
                            },
                            child: DashboardCard(
                              name: "Courses",
                              imgpath: "profile.png",
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

            ],
          ),
          ),

        );
      },
    );
  }
}
