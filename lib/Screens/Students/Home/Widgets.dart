import 'package:flutter/material.dart';
import 'package:school_management/Models/Student.dart';
import '../../../Models/Course.dart';
import '../../../Widgets/BouncingButton.dart';
import '../../../Widgets/DashboardCards.dart';

List<Widget> studentCoursesByRow(
    List<Course> courseList,
    int currIndex,
    BuildContext context,
    Animation muchDelayedAnimation,
    Function showEachCourse) {
  List<Widget> items = [];
  final double width = MediaQuery.of(context).size.width;
  for (var i = currIndex; i < courseList.length; i++) {
    if (i == currIndex + 2) break;
    items.add(Transform(
      transform:
          Matrix4.translationValues(muchDelayedAnimation.value * width, 0, 0),
      child: Bouncing(
        onPress: () => showEachCourse(i),
        child: DashboardCard(
          name: courseList[i].courseCode,
          imgpath: "attendance.png",
        ),
      ),
    ));
  }
  return items;
}

List<Widget> studentCoursesByColumn(
    List<Course> courseList,
    BuildContext context,
    Animation muchDelayedAnimation,
    Student student,
    Function showEachCourse) {
  List<Widget> items = [];
  for (var i = 0; i < courseList.length; i += 2) {
    items.add(Padding(
      padding: const EdgeInsets.fromLTRB(30.0, 10, 30, 10),
      child: Container(
        alignment: Alignment(1.0, 0),
        child: Padding(
          padding: const EdgeInsets.only(top: 10.0, right: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: studentCoursesByRow(
                courseList, i, context, muchDelayedAnimation, showEachCourse),
          ),
        ),
      ),
    ));
  }
  return items;
}
