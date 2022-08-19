import 'dart:async';

import 'package:flutter/material.dart';
import 'package:school_management/Models/OpenNote.dart';
import 'package:school_management/Authentication/Authentication.dart';

import '../../../Models/LectureNote.dart';
import '../../../Models/Quiz.dart';
import '../../../Models/QuizResult.dart';
import '../../../Models/QuizResultInfo.dart';
import '../../../Util/Notify.dart';
import '../../../Util/screen_layout.dart';
import '../../../Widgets/AppBar.dart';
import '../../../Widgets/MainDrawer.dart';
import '../../../constants/const.enum.pagesName.dart';
import '../../../routes/routes_to_name.dart';
import '../../Students/EachCourse/Exams/Exam_Rseult.dart';

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
      body: Row(
        children: [
          Container(
              width: layout.width * 0.4,
              margin: EdgeInsets.only(bottom: 30),
              child: AnimatedListView(
                selectedOption: selectedOption,
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
                var uid = AuthenticationHelper.getUser()!.uid!;
                QuizResultInfo()
                    .read(quizList[0].lectureNoteId!, uid)
                    .then((value) {
                  Navigator.popUntil(
                      context,
                      ModalRoute.withName(GenerateRootNames.generateRouteName(
                          PageName.studentDashBord)));
                  Navigator.pushNamed(
                    context,
                    GenerateRootNames.generateRouteName(
                        PageName.viewPastQuizAndTakeQuiz),
                    arguments: ExamResultArguments(
                        lectureNote: lectureNote, quizResultInfo: value),
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
      if (quizList[i].answer == selectedOption[i + 1]) {
        score++;
      }
    }
    return score;
  }

  Future unlockNextNote(String uid) async {
    await OpenNote.create(
        uid, lectureNote.courseId!, lectureNote.lectureNoteId!);
  }

  Future submitClick() async {
    var uid = AuthenticationHelper.getUser()!.uid!;
    int score = computeScore();
    if (score == quizList.length) {
      //await unlockNextNote(uid);
    }
    await QuizResult().create(
        QuizResult(
            quizResultInfo: QuizResultInfo(
                endTime: DateTime.now().microsecondsSinceEpoch.toString(),
                startTime: quizStartTime,
                questionNumber: quizList.length,
                score: score),
            selectedOption: selectedOption),
        quizList[0].lectureNoteId!,
        uid);
  }
}

class AnimatedListView extends StatelessWidget {
  const AnimatedListView({Key? key, required this.selectedOption})
      : super(key: key);
  final Map<int, int> selectedOption;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      cacheExtent: 0,
      padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 20),
      itemCount: selectedOption.length,
      itemBuilder: (context, index) => AnimatedScrollViewItem(
          child: ListItem(
        title: '${index + 1}',
        isSelected: selectedOption[index + 1] == 0 ? true : false,
      )),
    );
  }
}

class AnimatedScrollViewItem extends StatefulWidget {
  const AnimatedScrollViewItem({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;
  @override
  State<AnimatedScrollViewItem> createState() => _AnimatedScrollViewItemState();
}

class _AnimatedScrollViewItemState extends State<AnimatedScrollViewItem>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    )..forward();

    _scaleAnimation = Tween<double>(begin: 0.5, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: widget.child,
    );
  }
}

class ListItem extends StatelessWidget {
  const ListItem({
    Key? key,
    this.title = '',
    required this.isSelected,
  }) : super(key: key);

  final bool isSelected;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isSelected ? Colors.white : Colors.black12,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Center(
        child: Text(title),
      ),
    );
  }
}
