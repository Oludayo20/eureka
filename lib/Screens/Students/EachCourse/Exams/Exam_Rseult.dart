import 'package:flutter/material.dart';
import 'package:school_management/Models/LectureNote.dart';
import 'package:school_management/Models/QuizResultInfo.dart';
import 'package:school_management/Util/Notify.dart';
import 'package:school_management/Widgets/AppBar.dart';
import 'package:school_management/Widgets/BouncingButton.dart';
import 'package:school_management/Widgets/MainDrawer.dart';
import '../../../../Models/Quiz.dart';
import '../../../Courses/QuizView/Quiz.dart';
import 'SubjectCard.dart';

class ExamResultArguments {
  final LectureNote lectureNote;
  final List<QuizResultInfo> quizResultInfo;
  ExamResultArguments(
      {required this.lectureNote, required this.quizResultInfo});
}

class ExamResult extends StatefulWidget {
  const ExamResult({Key? key}) : super(key: key);
  static const routeName = '/selfQuizResultPage';
  @override
  _ExamResultState createState() => _ExamResultState();
}

class _ExamResultState extends State<ExamResult>
    with SingleTickerProviderStateMixin {
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

  List<Widget> pastSelfQuizBuild(ExamResultArguments arguments) {
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
              "Note Title: ${arguments.lectureNote.title!}",
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

    for (int i = 0; i < arguments.quizResultInfo.length; i++) {
      var time = int.parse(arguments.quizResultInfo[i].startTime!);
      var date = DateTime.fromMicrosecondsSinceEpoch(time);
      var timeTaken = DateTime.fromMicrosecondsSinceEpoch(
              int.parse(arguments.quizResultInfo[i].endTime!))
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
            lectureNote: arguments.lectureNote,
            date: "${date.day}/${date.month}/${date.year}",
            grade: grade(arguments.quizResultInfo[i].questionNumber!,
                arguments.quizResultInfo[i].score!),
            mark: "${arguments.quizResultInfo[i].score}",
            timeTaken:
                "${timeTaken.hour}:${timeTaken.minute}:${timeTaken.second}",
            startTime: arguments.quizResultInfo[i].startTime!,
          ),
        ),
      );
      item.add(SizedBox(
        height: height * 0.02,
      ));
    }
    item.add(SizedBox(
      height: height * 0.1,
    ));
    return item;
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

  Future<void> takeQuiz(ExamResultArguments arguments) async {
    Notify.loading(context, "");
    List<Quiz> quizList = await Quiz.read(
        arguments.lectureNote.courseId!, arguments.lectureNote.lectureNoteId!);
    Navigator.pop(context);
    if (quizList.length == 0) {
      Notify.error(context, "Quiz not yet available");
      return;
    }
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => QuizView(
            quizViewArgument: QuizViewArgument(
          isReviewing: false,
          selectedOption: {},
          lectureNote: arguments.lectureNote,
          title: "",
          quizList: quizList,
        )),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (ModalRoute.of(context)!.settings.arguments == null) {
      Navigator.popUntil(context, ModalRoute.withName("/"));
    }
    final args =
        ModalRoute.of(context)!.settings.arguments as ExamResultArguments;
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
                  children: pastSelfQuizBuild(args),
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
                      onPress: () async {
                        await takeQuiz(args);
                      },
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
