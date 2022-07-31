import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:school_management/Models/LectureNote.dart';
import 'package:school_management/Models/QuizResultInfo.dart';
import 'package:school_management/Util/Notify.dart';

import 'package:school_management/Widgets/AppBar.dart';
import 'package:school_management/Widgets/BouncingButton.dart';
import 'package:school_management/Widgets/MainDrawer.dart';

import '../../../../Models/Quiz.dart';
import '../../../Courses/QuizView/Quiz.dart';
import 'SubjectCard.dart';

class ExamResult extends StatefulWidget {
  const ExamResult(
      {Key? key, required this.lectureNote, required this.quizResultInfo})
      : super(key: key);
  final LectureNote lectureNote;
  final List<QuizResultInfo> quizResultInfo;
  @override
  _ExamResultState createState() => _ExamResultState();
}

class _ExamResultState extends State<ExamResult>
    with SingleTickerProviderStateMixin {
  Animation? animation, delayedAnimation, muchDelayedAnimation, LeftCurve;
  AnimationController? animationController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //SystemChrome.setEnabledSystemUIOverlays([]);

    animationController =
        AnimationController(duration: Duration(seconds: 3), vsync: this);
    animation = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
        parent: animationController!, curve: Curves.fastOutSlowIn));

    delayedAnimation = Tween(begin: 1.0, end: 0.0).animate(CurvedAnimation(
        parent: animationController!,
        curve: Interval(0.2, 0.5, curve: Curves.fastOutSlowIn)));

    muchDelayedAnimation = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
        parent: animationController!,
        curve: Interval(0.3, 0.5, curve: Curves.fastOutSlowIn)));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    animationController!.dispose();
    super.dispose();
  }

  List<Widget> pastSelfQuizBuild() {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    List<Widget> item = [];
    item.add(Padding(
      padding: const EdgeInsets.only(
        top: 8.0,
        bottom: 8.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Transform(
            transform: Matrix4.translationValues(
                muchDelayedAnimation!.value * width, 0, 0),
            child: Text(
              "Note Title: ${widget.lectureNote.title!}",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 17,
              ),
            ),
          ),
          Transform(
            transform: Matrix4.translationValues(
                delayedAnimation!.value * width, 0, 0),
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(
                "",
                style: TextStyle(
                  fontSize: 11,
                ),
              ),
            ),
          ),
        ],
      ),
    ));
    item.add(SizedBox(
      height: height * 0.02,
    ));

    for (int i = 0; i < widget.quizResultInfo.length; i++) {
      var time = int.parse(widget.quizResultInfo[i].startTime!);
      var date = DateTime.fromMicrosecondsSinceEpoch(time);
      var timeTaken = DateTime.fromMicrosecondsSinceEpoch(
              int.parse(widget.quizResultInfo[i].endTime!))
          .subtract(Duration(
              days: date.day,
              hours: date.hour,
              seconds: date.second,
              minutes: date.minute));
      item.add(
        Transform(
          transform: Matrix4.translationValues(
              muchDelayedAnimation!.value * width, 0, 0),
          child: SubjectCard(
            subjectname: "Quiz ${i + 1}",
            reviewQuiz: () => reviewQuiz(widget.quizResultInfo[i].startTime!),
            date: "${date.day}/${date.month}/${date.year}",
            grade: grade(widget.quizResultInfo[i].questionNumber!,
                widget.quizResultInfo[i].score!),
            mark: "${widget.quizResultInfo[i].score}",
            time: "${timeTaken.hour}:${timeTaken.minute}:${timeTaken.second}",
          ),
        ),
      );
      item.add(SizedBox(
        height: height * 0.02,
      ));
    }
    return item;
  }

  void reviewQuiz(String time) {
    print(time);
  }

  String grade(int total, int score) {
    var pec = (total / score) * 100;
    if (pec < 45)
      return "F";
    else if (pec >= 45 && pec <= 49)
      return "D";
    else if (pec >= 50 && pec <= 59)
      return "C";
    else if (pec >= 60 && pec <= 69)
      return "B";
    else
      return "A";
  }

  void takeQuiz() {
    List<Quiz> quizList = [];
    Notify.loading(context, "");
    Quiz().read(quizList, widget.lectureNote.lectureNoteId!).whenComplete(() {
      Navigator.pop(context);
      if (quizList.length == 0) {
        Notify.error(context, "Quiz not yet available");
        return;
      }
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => QuizView(
            lectureNoteId: widget.lectureNote.lectureNoteId!,
            title: "",
            quizList: quizList,
          ),
        ),
      );
    });
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
            appBar: CommonAppBar(
              menuenabled: true,
              notificationenabled: false,
              title: "Self Quiz",
              ontap: () {
                _scaffoldKey.currentState!.openDrawer();
              },
            ),
            drawer: Drawer(
              elevation: 0,
              child: MainDrawer(),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 5,
                  horizontal: 15,
                ),
                child: Column(
                  children: pastSelfQuizBuild(),
                ),
              ),
            ),
            bottomSheet: Padding(
              padding: const EdgeInsets.fromLTRB(0, 18, 0, 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Transform(
                    transform: Matrix4.translationValues(
                        muchDelayedAnimation!.value * width, 0, 0),
                    child: Bouncing(
                      onPress: () => Navigator.pop(context),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(3),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                              ),
                            ]),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Back",
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Transform(
                    transform: Matrix4.translationValues(
                        delayedAnimation!.value * width, 0, 0),
                    child: Bouncing(
                      onPress: () => takeQuiz(),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(3),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                              ),
                            ]),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Take Quiz",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
