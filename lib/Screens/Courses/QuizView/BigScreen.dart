import 'dart:async';
import 'package:flutter/material.dart';
import '../../../services/authentication_helper.dart';
import 'CRUD/Create.dart';
import 'Methods.dart';
import 'QuestionView.dart';
import 'ViewQuestions.dart';

class BigScreen extends StatelessWidget {
  const BigScreen(
      {Key? key,
      required this.buttonColumn,
      required this.questionMap,
      required this.streamController,
      required this.submitMethod,
      required this.isReviewing, required this.lectureNoteId})
      : super(key: key);
  final Function buttonColumn;
  final StreamController<int> streamController;
  final Map<int, QuestionView> questionMap;
  final Function submitMethod;
  final bool isReviewing;
  final int lectureNoteId;
  @override
  Widget build(BuildContext context) {
    QuizMethods quizMethods = QuizMethods(
        questionMap: questionMap, streamController: streamController);

    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    double textButtonFontSize = width * 0.015;
    double textButtonWidth = width * 0.05;
    double textButtonHeight = height * 0.05;
    ScrollController controller = ScrollController();
    ScrollController controller2 = ScrollController();
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: width * 0.3,
              height: height * 0.8,
              child: Scrollbar(
                controller: controller,
                child: ListView(
                  controller: controller,
                  children: [
                    Column(
                      children: buttonColumn(
                          perColumn: 10,
                          perRow: 5,
                          textButtonFontSize: textButtonFontSize,
                          textButtonHeight: textButtonHeight,
                          textButtonWidth: textButtonWidth),
                    )
                  ],
                ),
              ),
            ),
            Container(
                width: width * 0.7,
                height: height * 0.8,
                child: questionMap.isNotEmpty
                    ? ViewQuestions(
                        controller2: controller2,
                        questionMap: questionMap,
                        streamController: streamController,
                      )
                    : Container()),
          ],
        ),
        Row(
          children: [
            Container(
              width: width * 0.3,
              height: 10,
            ),
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
                        showMyDialogCreate(context, lectureNoteId);
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
            )
          ],
        )
      ],
    );
  }
}
