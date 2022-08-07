import 'package:flutter/material.dart';
import '../../../../../Models/Quiz.dart';
import '../../../../Util/Notify.dart';
import '../Stream.dart';

Future<void> showMyDialogDelete(BuildContext context, Quiz quiz) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Delete Quiz'),
        content: SingleChildScrollView(
          child: ListBody(
            children: const <Widget>[
              Text('Are you sure you want to delete '),
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
            onPressed: () {
              Notify.loading(context, "");
              Quiz
                  .delete(quiz.courseId!,quiz.lectureNoteId!, quiz.quizId!)
                  .whenComplete(() {
                Navigator.pop(context);
                Navigator.pop(context);
                quizController.add(1);
                Notify.success(context, "Success");
              });
            },
          ),
        ],
      );
    },
  );
}
