import 'package:flutter/material.dart';
import 'package:school_management/Widgets/DrawerListTile.dart';

import '../Courses/Course.dart';
import 'Faculty/Faculty.dart';
import 'HomePage/HomePage.dart';

class AdminMainDrawer extends StatefulWidget {
  @override
  _MainDrawerState createState() => _MainDrawerState();
}

class _MainDrawerState extends State<AdminMainDrawer> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        DrawerListTile(
            imgpath: "home.png",
            name: "Home",
            ontap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => AdminHome(),
                ),
              );
            }),
        DrawerListTile(
          imgpath: "attendance.png",
          name: "Faculty",
          ontap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => Faculty(),
              ),
            );
          },
        ),
        DrawerListTile(
          imgpath: "attendance.png",
          name: "Courses",
          ontap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => CourseView(),
              ),
            );
          },
        ),
      ],
    );
  }
}
