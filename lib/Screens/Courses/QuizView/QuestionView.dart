import 'dart:async';
import 'package:flutter/material.dart';
import '../../../../Models/models.dart';
import '../../../Authentication/Authentication.dart';
import 'CRUD/crud.dart';

class QuestionView extends StatefulWidget {
  final int questionNumber;
  final Map<int, int> selectedOption;
  final StreamController<int> numberButtonStreamController;
  final Quiz quiz;
  final bool isReviewing;
  const QuestionView(
      {Key? key,
      required this.questionNumber,
      required this.quiz,
      required this.selectedOption,
      required this.numberButtonStreamController,
      required this.isReviewing})
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
    bool isAdmin = AuthenticationHelper.isAdmin();
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            //TODO: Add width
            height: width < 600 ? height * 0.03 : width * 0.03,
            margin: EdgeInsets.only(bottom: 5),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                isAdmin
                    ? Container(
                        child: IconButton(
                            color: Colors.blue,
                            onPressed: () {
                              showMyDialogCEdit(context, widget.quiz);
                            },
                            icon: Icon(
                              Icons.edit,
                            )),
                      )
                    : Container(),
                isAdmin
                    ? Container(
                        child: IconButton(
                            color: Colors.red,
                            onPressed: () {
                              showMyDialogDelete(context, widget.quiz);
                            },
                            icon: Icon(
                              Icons.delete,
                            )),
                      )
                    : Container(),
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
              widget.isReviewing ? Container() : clearOption(),
              widget.questionNumber % 2 == 0
                  ? SizedBox(
                      height: 20,
                    )
                  : Container()
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

  Color isCorrectOption(int opt) {
    if (widget.selectedOption[widget.questionNumber] == widget.quiz.answer)
      return Colors.greenAccent;
    else
      return Colors.redAccent;
  }

  Widget options(String option, int opt) {
    return GestureDetector(
        child: Container(
          color: widget.isReviewing &&
                  opt == widget.selectedOption[widget.questionNumber]
              ? isCorrectOption(opt)
              : null,
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
        onTap: () => widget.isReviewing || AuthenticationHelper.isAdmin()
            ? () {}
            : onClickOption(opt));
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
