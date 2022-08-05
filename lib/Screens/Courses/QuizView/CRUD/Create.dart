import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:school_management/Models/QuizOption.dart';
import 'package:school_management/Util/Notify.dart';

import '../../../../../Models/Quiz.dart';
import '../Stream.dart';
import 'General.dart';

Future<void> showMyDialogCreate(BuildContext context, int lectureNoteId) async {
  final double width = MediaQuery.of(context).size.width;
  final double height = MediaQuery.of(context).size.height;
  TextEditingController questionController = TextEditingController();
  TextEditingController optionAControllerCode = TextEditingController();
  TextEditingController optionBControllerCode = TextEditingController();
  TextEditingController optionCControllerCode = TextEditingController();
  TextEditingController optionDControllerCode = TextEditingController();
  TextEditingController optionEControllerCode = TextEditingController();
  TextEditingController answerControllerCode = TextEditingController();
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Add Course'),
        content: SingleChildScrollView(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            heading("Question"),
            optionsAdd(questionController, width, height),
            heading("Answer"),
            DropdownSearch<String>(
              validator: (v) => v == null ? "required field" : null,
              //hint: "Please Select Leave type",
              items: ["A", "B", "C", "D", "E"],
              onChanged: (value) {
                answerControllerCode.text = value!;
              },
            ),
            heading("Option A"),
            optionsAdd(optionAControllerCode, width, height),
            heading("Option B"),
            optionsAdd(optionBControllerCode, width, height),
            heading("Option C"),
            optionsAdd(optionCControllerCode, width, height),
            heading("Option D"),
            optionsAdd(optionDControllerCode, width, height),
            heading("Option E"),
            optionsAdd(optionEControllerCode, width, height),
          ],
        )),
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
            onPressed: () {
              var check = emptyField(
                  questionController.text,
                  optionAControllerCode.text,
                  optionBControllerCode.text,
                  optionCControllerCode.text,
                  optionDControllerCode.text,
                  optionEControllerCode.text,
                  answerControllerCode.text,
              false);
              if (check.isNotEmpty) {
                Notify.error(context, check);
                return;
              }
              int ans = 0;
              if (answerControllerCode.text == "A")
                ans = 1;
              else if (answerControllerCode.text == "B")
                ans = 2;
              else if (answerControllerCode.text == "C")
                ans = 3;
              else if (answerControllerCode.text == "D")
                ans = 4;
              else if (answerControllerCode.text == "E") ans = 5;

              Quiz()
                  .create(Quiz(
                question: questionController.text,
                lectureNoteId: lectureNoteId,
                answer: ans,
                options: QuizOptions(
                  quizOptionA: optionAControllerCode.text,
                  quizOptionB: optionBControllerCode.text,
                  quizOptionC: optionCControllerCode.text,
                  quizOptionD: optionDControllerCode.text,
                  quizOptionE: optionEControllerCode.text,
                ),
              ))
                  .whenComplete(() {
                quizController.add(1);
                Navigator.of(context).pop();
              });
            },
          ),
        ],
      );
    },
  );
}
