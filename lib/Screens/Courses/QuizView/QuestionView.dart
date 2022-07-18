import 'dart:async';

import 'package:flutter/material.dart';

import '../../../../Models/Quiz.dart';
import '../QuizView/CRUD/Edit.dart';
import '../QuizView/CRUD/Delete.dart';

class QuestionView extends StatefulWidget {
  final int questionNumber;
  final Map<int, int> selectedOption;
  final StreamController<int> numberButtonStreamController;
  final Quiz quiz;
  const QuestionView(
      {Key? key,
      required this.questionNumber,
      required this.quiz,
      required this.selectedOption,
      required this.numberButtonStreamController})
      : super(key: key);

  @override
  State<QuestionView> createState() => _QuestionViewState();
}

class _QuestionViewState extends State<QuestionView> {
  void refresh() => setState(() {});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: width < 600 ? height * 0.03 : width * 0.03,
            margin: EdgeInsets.only(bottom: 5),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  child: IconButton(
                      color: Colors.blue,
                      onPressed: () {
                        showMyDialogCEdit(context, widget.quiz);
                      },
                      icon: Icon(
                        Icons.edit,
                      )),
                ),
                Container(
                  child: IconButton(
                      color: Colors.red,
                      onPressed: () {
                        showMyDialogDelete(context, widget.quiz);
                      },
                      icon: Icon(
                        Icons.delete,
                      )),
                ),
                Container(
                  margin: EdgeInsets.only(right: 20),
                  child: Center(
                    child: Text(
                      "${widget.questionNumber}",
                      style: TextStyle(
                          fontSize: width < 600 ? height * 0.03 : width * 0.03),
                    ),
                  ),
                ),
              ],
            ),
          ),
          question(widget.quiz.question!, width),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                child: Container(
                  child: Text(
                    "Select one:",
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                ),
                padding: EdgeInsets.only(
                  left: 10,
                ),
              ),
            ],
          ),
          Column(
            children: [
              options(widget.quiz.options!.quizOptionA!, 1),
              options(widget.quiz.options!.quizOptionB!, 2),
              options(widget.quiz.options!.quizOptionC!, 3),
              options(widget.quiz.options!.quizOptionD!, 4),
              options(widget.quiz.options!.quizOptionE!, 5),
              clearOption()
            ],
          )
        ],
      ),
    );
  }


  Widget clearOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          child: Container(
            child: TextButton(
              child: Text(
                "Clear option",
                style: TextStyle(fontSize: 15),
              ),
              onPressed: onClickClearOption,
            ),
          ),
          padding: EdgeInsets.only(
            left: 10,
          ),
        ),
      ],
    );
  }

  Widget question(String question, double width) {
    return Container(
      width: width < 600 ? width * 0.9 : width * 0.7,
      child: Card(
          child: Container(
        padding: EdgeInsets.all(10),
        child: Text(
          question,
          style: TextStyle(fontSize: 17),
        ),
      )),
    );
  }

  Widget options(String option, int opt) {
    return GestureDetector(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Row(
            children: [
              opt == widget.selectedOption[widget.questionNumber]
                  ? Icon(Icons.radio_button_checked)
                  : Icon(Icons.radio_button_off),
              Container(
                width: 10,
              ),
              Expanded(
                child: Text(
                  option,
                  style: TextStyle(fontSize: 17),
                ),
              )
            ],
          ),
        ),
        onTap: () => onClickOption(opt));
  }

  void onClickOption(int opt) {
    widget.selectedOption[widget.questionNumber] = opt;
    widget.numberButtonStreamController.add(widget.questionNumber);
    setState(() {});
  }

  void onClickClearOption() {
    widget.selectedOption[widget.questionNumber] = 0;
    widget.numberButtonStreamController.add(widget.questionNumber);
    setState(() {});
  }
}
