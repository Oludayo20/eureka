import 'dart:async';
import 'package:flutter/material.dart';
import '../../../../Widgets/BouncingButton.dart';
import 'Methods.dart';
import 'QuestionView.dart';
import 'ViewQuestions.dart';

class BigScreen extends StatelessWidget {
  const BigScreen(
      {Key? key,
      required this.buttonColumn,
      required this.questionMap,
      required this.streamController})
      : super(key: key);
  final Function buttonColumn;
  final StreamController<int> streamController;
  final Map<int, QuestionView> questionMap;

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
              child: ViewQuestions(
                controller2: controller2,
                questionMap: questionMap,
                streamController: streamController,
              ),
            ),
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
                  Bouncing(
                    child: Container(
                        width: width * 0.04,
                        height: width * 0.04,
                        child: Center(
                          child: Icon(
                            Icons.skip_previous,
                            color: Colors.black,
                            size: width * 0.04,
                          ),
                        )),
                    onPress: () => quizMethods.previousQuestion(),
                  ),
                  Bouncing(
                    child: Container(
                        width: width * 0.04,
                        height: width * 0.04,
                        child: Center(
                          child: Icon(
                            Icons.skip_next,
                            color: Colors.black,
                            size: width * 0.04,
                          ),
                        )),
                    onPress: () => quizMethods.nextQuestion(),
                  ),
                ],
              ),
            )
          ],
        )
      ],
    );
  }
}
