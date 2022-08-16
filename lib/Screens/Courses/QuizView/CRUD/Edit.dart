import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:school_management/Models/QuizOption.dart';
import 'package:school_management/Widgets/CardMaker.dart';

import '../../../../../Models/Quiz.dart';
import '../../../../Util/Notify.dart';
import '../Stream.dart';
import 'General.dart';

String answerToString(int ans) {
  switch (ans) {
    case 1:
      return "A";
    case 2:
      return "B";
    case 3:
      return "C";
    case 4:
      return "D";
    case 5:
      return "E";
  }
  return "";
}

Future<void> showMyDialogCEdit(BuildContext context, Quiz quiz) async {
  TextEditingController questionController = TextEditingController();
  TextEditingController optionAControllerCode = TextEditingController();
  TextEditingController optionBControllerCode = TextEditingController();
  TextEditingController optionCControllerCode = TextEditingController();
  TextEditingController optionDControllerCode = TextEditingController();
  TextEditingController optionEControllerCode = TextEditingController();
  TextEditingController answerControllerCode = TextEditingController();
  questionController.text = quiz.question!;
  optionAControllerCode.text = quiz.options!.quizOptionA!;
  optionBControllerCode.text = quiz.options!.quizOptionB!;
  optionCControllerCode.text = quiz.options!.quizOptionC!;
  optionDControllerCode.text = quiz.options!.quizOptionD!;
  optionEControllerCode.text = quiz.options!.quizOptionE!;

  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return CardMaker(
        body: ListView(
          children: [
            optionsAdd(questionController, "Question"),
            heading("Answer"),
            DropdownSearch<String>(
              validator: (v) => v == null ? "required field" : null,
              //hint: "Please Select Leave type",
              selectedItem: answerToString(quiz.answer!),
              items: ["A", "B", "C", "D", "E"],
              onChanged: (value) {
                answerControllerCode.text = value!;
              },
            ),
            optionsAdd(optionAControllerCode, "Option A"),
            optionsAdd(optionBControllerCode, "Option B"),
            optionsAdd(optionCControllerCode, "Option C"),
            optionsAdd(optionDControllerCode, "Option D"),
            optionsAdd(optionEControllerCode, "Option E"),
            ExtraSpace()
          ],
        ),
        title: 'Add Course',
        footerActionLeft: TextButton(
          child: Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        footerActionRight: TextButton(
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
                true);
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

            Quiz.update(Quiz(
              question: questionController.text,
              lectureNoteId: quiz.lectureNoteId,
              answer: ans,
              quizId: quiz.quizId,
              options: QuizOptions(
                quizOptionA: optionAControllerCode.text,
                quizOptionB: optionBControllerCode.text,
                quizOptionC: optionCControllerCode.text,
                quizOptionD: optionDControllerCode.text,
                quizOptionE: optionEControllerCode.text,
              ),
            )).whenComplete(() {
              quizController.add(1);
              Navigator.of(context).pop();
            });
          },
        ),
      );
    },
  );
}
