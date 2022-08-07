import 'dart:async';
import 'package:flutter/material.dart';
import 'package:school_management/Models/LectureNote.dart';
import '../../../services/authentication_helper.dart';
import 'CRUD/Create.dart';
import 'Methods.dart';
import 'QuestionView.dart';
import 'ViewQuestions.dart';

class SmallScreen extends StatelessWidget {
  const SmallScreen(
      {Key? key,
      required this.buttonColumn,
      required this.questionMap,
      required this.streamController,
      required this.submitMethod,
      required this.isReviewing, required this.lectureNote})
      : super(key: key);
  final Function buttonColumn;
  final StreamController<int> streamController;
  final Map<int, QuestionView> questionMap;
  final Function submitMethod;
  final bool isReviewing;
  final LectureNote lectureNote;
  @override
  Widget build(BuildContext context) {
    QuizMethods quizMethods = QuizMethods(
        questionMap: questionMap, streamController: streamController);
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    double textButtonFontSize = height * 0.02;
    double textButtonWidth = width * 0.1;
    double textButtonHeight = height * 0.05;
    ScrollController controller = ScrollController();
    ScrollController controller2 = ScrollController();
    Widget buttonCol() {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: buttonColumn(
            perColumn: 2,
            perRow: 7,
            textButtonFontSize: textButtonFontSize,
            textButtonHeight: textButtonHeight,
            textButtonWidth: textButtonWidth),
      );
    }

    var butC = buttonCol();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
            width: width * 0.9,
            height: height * 0.7,
            child: questionMap.isNotEmpty
                ? ViewQuestions(
                    controller2: controller2,
                    questionMap: questionMap,
                    streamController: streamController,
                  )
                : Container()),
        Container(
          width: width * 0.7,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                  onPressed: () => quizMethods.previousQuestion(),
                  child: Text("Previous")),
              AuthenticationHelper().isAdmin()
                  ? TextButton(
                  onPressed: () {
                    showMyDialogCreate(context,lectureNote.courseId!, lectureNote.lectureNoteId!);
                  },
                  child: Text("Add new Quiz"))
                  : isReviewing
                      ? TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text("End review"))
                      : TextButton(
                          onPressed: () => submitMethod(),
                          child: Text("Submit")),
              TextButton(
                  onPressed: () => quizMethods.nextQuestion(),
                  child: Text("Next")),
            ],
          ),
        ),
        Container(
          height: height * 0.02,
        ),
        Container(
          width: width * 0.9,
          height: height * 0.15,
          child: Scrollbar(
            controller: controller,
            child: ListView(
              controller: controller,
              children: [butC],
            ),
          ),
        ),
      ],
    );
  }
}
