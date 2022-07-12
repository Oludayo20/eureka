import 'dart:async';
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:school_management/Models/QuizOption.dart';

import '../../../../Models/Quiz.dart';
import '../../../../Widgets/AppBar.dart';
import '../../../../Widgets/BouncingButton.dart';
import '../../AdminMainDrawer.dart';
import 'BigScreen.dart';
import 'Buttons.dart';
import 'QuestionView.dart';
import 'SmallScreen.dart';

class QuizView extends StatefulWidget {
  const QuizView({Key? key, required this.title, required this.lectureNoteId})
      : super(key: key);
  final String title;
  final int lectureNoteId;
  @override
  State<QuizView> createState() => _QuizViewState();
}

class _QuizViewState extends State<QuizView> {
  Quiz quiz = Quiz(
      question:
          "As you are telling when multiple instances are rendered, you are getting this error. When your ScrollController is multiple(one for one view), you will not get any problem. But you have only one ScrollController (because you have static).",
      options: QuizOptions(
        quizOptionA:"boy",
        quizOptionB:
            "As you are telling when multiple instances are rendered, you are getting this error. When your ScrollController is multiple(one for one view), you will not get any problem. But you have only one ScrollController (because you have static).",
        quizOptionC:
            "As you are telling when multiple instances are rendered, you are getting this error. When your ScrollController is multiple(one for one view), you will not get any problem. But you have only one ScrollController (because you have static).",
        quizOptionD:
            "As you are telling when multiple instances are rendered, you are getting this error. When your ScrollController is multiple(one for one view), you will not get any problem. But you have only one ScrollController (because you have static).",
        quizOptionE:
            "As you are telling when multiple instances are rendered, you are getting this error. When your ScrollController is multiple(one for one view), you will not get any problem. But you have only one ScrollController (because you have static).",
      ));
  Map<int, QuestionView> questionMap = Map<int, QuestionView>();
  Map<int, int> selectedOption = Map<int, int>();
  late StreamController<int> streamController;
  late  StreamController<int> numberButtonStreamController;
  @override
  void initState() {
    super.initState();
    streamController = StreamController.broadcast();
    numberButtonStreamController = StreamController.broadcast();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    streamController.close();
    super.dispose();
  }
  void changeQuestion(int number) {
    streamController.add(number);
  }

  List<Widget> buttonRow(
      {required int length,
      required int number,
      required double textButtonFontSize,
      required double textButtonWidth,
      required double textButtonHeight}) {
    List<Widget> buttons = [];
    for (var i = number; i < number + length; i++) {
      questionMap[i] = QuestionView(
        numberButtonStreamController: numberButtonStreamController,
        selectedOption: selectedOption,
        questionNumber: i,
        quiz: quiz,
      );
      selectedOption[i] = 0;
      buttons.add(Bouncing(
          onPress: () => changeQuestion(i),
          child: NumberButtons(
            selectedOption: selectedOption,
            numberButtonStreamController: numberButtonStreamController,
            number: i,
            textButtonFontSize: textButtonFontSize,
            textButtonHeight: textButtonHeight,
            textButtonWidth: textButtonWidth,
          )));
    }
    return buttons;
  }

  List<Widget> buttonColumn(
      {required int perColumn,
      required int perRow,
      required double textButtonFontSize,
      required double textButtonWidth,
      required double textButtonHeight}) {
    List<Widget> items = [];
    int number = 1;
    for (var i = 0; i < perColumn; i++) {
      var buttons = buttonRow(
          length: perRow,
          number: number,
          textButtonFontSize: textButtonFontSize,
          textButtonWidth: textButtonWidth,
          textButtonHeight: textButtonHeight);
      number += buttons.length;
      items.add(Padding(
        padding: EdgeInsets.only(top: 5),
        child: Row(
          children: buttons,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        ),
      ));
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey =
        new GlobalKey<ScaffoldState>();
    final double width = MediaQuery.of(context).size.width;
    streamController = StreamController.broadcast();
    numberButtonStreamController = StreamController.broadcast();
    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        elevation: 0,
        child: AdminMainDrawer(),
      ),
      appBar: CommonAppBar(
        menuenabled: true,
        notificationenabled: false,
        ontap: () {
          _scaffoldKey.currentState!.openDrawer();
        },
        title: "${widget.title}/Quiz",
      ),
      body: width < 600
          ? SmallScreen(
              questionMap: questionMap,
              buttonColumn: buttonColumn,
              streamController: streamController,
            )
          : BigScreen(
              questionMap: questionMap,
              buttonColumn: buttonColumn,
              streamController: streamController,
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
    );
  }
}
