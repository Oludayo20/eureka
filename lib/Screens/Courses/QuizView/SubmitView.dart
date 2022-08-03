import 'dart:async';

import 'package:flutter/material.dart';
import 'package:school_management/services/authentication_helper.dart';

import '../../../Models/LectureNote.dart';
import '../../../Models/Quiz.dart';
import '../../../Models/QuizResult.dart';
import '../../../Models/QuizResultInfo.dart';
import '../../../Util/Notify.dart';
import '../../../Util/screen_layout.dart';
import '../../../Widgets/AppBar.dart';
import '../../../Widgets/MainDrawer.dart';
import '../../Students/EachCourse/Exams/Exam_Rseult.dart';
import 'Buttons.dart';

class SubmitView extends StatelessWidget {
  const SubmitView(
      {Key? key,
      required this.selectedOption,
      required this.quizList,
      required this.quizStartTime,
      required this.lectureNote})
      : super(key: key);
  final Map<int, int> selectedOption;
  final List<Quiz> quizList;
  final String quizStartTime;
  final LectureNote lectureNote;
  @override
  Widget build(BuildContext context) {
    Layout layout = Layout(size: MediaQuery.of(context).size);
    List<Widget> numberList() {
      List<Widget> item = [];
      selectedOption.forEach((key, value) {
        item.add(Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            NumberButtons(
              selectedOption: selectedOption,
              textButtonWidth: layout.width * 0.09,
              textButtonHeight: layout.height * 0.04,
              textButtonFontSize: 20,
              number: key,
              numberButtonStreamController: StreamController(),
            )
          ],
        ));
        item.add(SizedBox(
          height: 5,
        ));
      });
      return item;
    }

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
      body: Row(
        children: [
          Container(
              width: layout.width * 0.4,
              child: ListView(
                children: numberList(),
              )),
        ],
        mainAxisAlignment: MainAxisAlignment.center,
      ),
      bottomSheet: Padding(
        padding: EdgeInsets.all(10),
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    "Back",
                    style: TextStyle(fontSize: 20),
                  )),
              TextButton(
                  onPressed: () => _showConfirmSubmit(context),
                  child: Text(
                    "Submit",
                    style: TextStyle(fontSize: 20),
                  )),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _showConfirmSubmit(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm submit'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Are you sure you want to submit '),
              ],
            ),
          ),
          actionsAlignment: MainAxisAlignment.spaceBetween,
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Approve'),
              onPressed: () async {
                Notify.loading(context, "");
                await submitClick();
                var uid = AuthenticationHelper().getUser()!.uid!;
                QuizResultInfo()
                    .read(quizList[0].lectureNoteId!, uid)
                    .then((value) {
                  Navigator.popUntil(
                      context, ModalRoute.withName(ExamResult.routeName));
                  Navigator.pop(context);
                  Navigator.pushNamed(
                    context,
                    ExamResult.routeName,
                    arguments: ExamResultArguments(
                        lectureNote: lectureNote,
                        quizResultInfo: value),
                  );
                });
              },
            ),
          ],
        );
      },
    );
  }

  int computeScore() {
    int score = 0;
    for (var i = 0; i < quizList.length; i++) {
      if (quizList[i].answer == selectedOption[i+1]) {
        score++;
      }
    }
    return score;
  }

  Future submitClick() async {
    int score = computeScore();
    await QuizResult().create(
        QuizResult(
            quizResultInfo: QuizResultInfo(
                endTime: DateTime.now().microsecondsSinceEpoch.toString(),
                startTime: quizStartTime,
                questionNumber: quizList.length,
                score: score),
            selectedOption: selectedOption),
        quizList[0].lectureNoteId!,
        AuthenticationHelper().getUser()!.uid!);
  }
}
