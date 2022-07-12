import 'dart:async';
import 'package:flutter/material.dart';
import '../../../../Widgets/BouncingButton.dart';
import 'Methods.dart';
import 'QuestionView.dart';
import 'ViewQuestions.dart';

class SmallScreen extends StatelessWidget {
  const SmallScreen(
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
    double textButtonFontSize = height * 0.02;
    double textButtonWidth = width * 0.1;
    double textButtonHeight = height * 0.05;
    ScrollController controller = ScrollController();
    ScrollController controller2 = ScrollController();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          width: width * 0.9,
          height: height * 0.7,

          child: ViewQuestions(
            controller2: controller2,
            questionMap: questionMap,
            streamController: streamController,
          ),
        ),
        Container(
          width: width * 0.7,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Bouncing(
                child: Container(
                    width: height * 0.04,
                    height: height * 0.04,
                    child: Center(
                      child: Icon(
                        Icons.skip_previous,
                        color: Colors.black,
                        size: height * 0.04,
                      ),
                    )),
                onPress: () => quizMethods.previousQuestion(),
              ),
              Bouncing(
                child: Container(
                    width: height * 0.04,
                    height: height * 0.04,
                    child: Center(
                      child: Icon(
                        Icons.skip_next,
                        color: Colors.black,
                        size: height * 0.04,
                      ),
                    )),
                onPress: () => quizMethods.nextQuestion(),
              ),
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
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: buttonColumn(
                      perColumn: 2,
                      perRow: 7,
                      textButtonFontSize: textButtonFontSize,
                      textButtonHeight: textButtonHeight,
                      textButtonWidth: textButtonWidth),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}