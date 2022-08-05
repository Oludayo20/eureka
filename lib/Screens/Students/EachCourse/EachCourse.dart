import 'package:flutter/material.dart';
import '../../../Models/Course.dart';
import '../../../Util/screen_layout.dart';
import '../../../Widgets/AppBar.dart';
import '../../../Widgets/MainDrawer.dart';
import 'Method.dart';
import 'NoteDisplay/NoteCard.dart';

class EachCourse extends StatelessWidget {
  const EachCourse(
      {Key? key, required this.course, required this.eachCourseMethod})
      : super(key: key);
  final Course course;
  final EachCourseMethod eachCourseMethod;
  List<Widget> lectureNotes(Layout layout, BuildContext context) {
    List<Widget> item = [];
    for (var i = 1; i < eachCourseMethod.list.length + 1; i++) {
      item.add(Padding(
        padding: EdgeInsets.only(left: 10, right: 10),
        child: NoteCard(
          lectureNote: eachCourseMethod.list[i - 1],
          num: i,
        ),
      ));
      item.add(SizedBox(
        height: 20,
      ));
    }
    item.add(SizedBox(
      height: 20,
    ));
    return item;
  }

  @override
  Widget build(BuildContext context) {
    Layout layout = Layout(size: MediaQuery.of(context).size);
    final GlobalKey<ScaffoldState> _scaffoldKey =
        new GlobalKey<ScaffoldState>();
    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        elevation: 0,
        child: MainDrawer(),
      ),
      appBar: CommonAppBar(
        menuenabled: true,
        notificationenabled: false,
        ontap: () {
          _scaffoldKey.currentState!.openDrawer();
        },
        title: "Student Dashboard",
      ),
      body: ListView(
        children: lectureNotes(layout, context),
      ),
      bottomSheet: Padding(
        padding: EdgeInsets.all(10),
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    "Back",
                    style: TextStyle(fontSize: 20),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
