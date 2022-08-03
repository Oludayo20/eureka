import 'package:flutter/material.dart';
import 'package:school_management/Models/QuizResultInfo.dart';
import 'package:school_management/services/authentication_helper.dart';
import '../../../Models/Course.dart';
import '../../../Util/screen_layout.dart';
import '../../../Widgets/AppBar.dart';
import '../../../Widgets/MainDrawer.dart';
import '../Events.dart';
import 'Exams/Exam_Rseult.dart';
import 'Method.dart';
import 'NoteDisplay/NoteView.dart';

class EachCourse extends StatelessWidget {
  const EachCourse(
      {Key? key, required this.course, required this.eachCourseMethod})
      : super(key: key);
  final Course course;
  final EachCourseMethod eachCourseMethod;
  List<Widget> lectureNotes(Layout layout, BuildContext context) {
    List<Widget> item = [];
    for (var i = 1; i < eachCourseMethod.list.length + 1; i++) {
      item.add(eachLectureNote(
          i, eachCourseMethod.list[i - 1].title!, layout, context));
      item.add(SizedBox(
        height: 20,
      ));
    }
    if (layout.isAndroid) {
      item.add(EurekaEvents());
    }
    return item;
  }

  void onSelfQuizClick(BuildContext context, int index) {
    var uid = AuthenticationHelper().getUser()!.uid!;
    print(uid);
    QuizResultInfo()
        .read(eachCourseMethod.list[index].lectureNoteId!, uid)
        .then((value) {
      Navigator.pushNamed(
        context,
        ExamResult.routeName,
        arguments: ExamResultArguments(
            lectureNote: eachCourseMethod.list[index], quizResultInfo: value),
      );
    });
  }

  void onDisplayNoteClick(BuildContext context, int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) =>
            NoteView(lectureNote: eachCourseMethod.list[index]),
      ),
    );
  }

  Widget eachLectureNote(
      int num, String title, Layout layout, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Container(
          height: layout.height * 0.2,
          child: Card(

            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Card(
                    color: Colors.black,
                    child: Center(
                      child: Text(
                        "Note $num",
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(left: 5, right: 5),
                    child: TextButton(
                      child: Text(
                        title,
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.greenAccent,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      onPressed: () => onDisplayNoteClick(context, num - 1),
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => onSelfQuizClick(context, num - 1),
                      child: Text(
                        "Self Quiz $num",
                        style: TextStyle(fontSize: 20),
                      ),
                    )
                  ],
                )
              ],
            ),
          )),
    );
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
        notificationenabled: true,
        ontap: () {
          _scaffoldKey.currentState!.openDrawer();
        },
        title: "Student Dashboard",
      ),
      body: layout.isAndroid
          ? Container(
              child: ListView(
              children: lectureNotes(layout, context),
            ))
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                    width: layout.width * 0.45,
                    child: ListView(
                      children: lectureNotes(layout, context),
                    )),
                EurekaEvents()
              ],
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
