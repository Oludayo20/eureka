import 'package:flutter/material.dart';

import '../../../Models/Faculty.dart';
import 'Methods.dart';

Future<void> showMyDialogCreate(
    BuildContext context, FacultyMethods facultyMethods) async {
  final double width = MediaQuery.of(context).size.width;
  final double height = MediaQuery.of(context).size.height;
  TextEditingController controller = TextEditingController();
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Create Faculty'),
        content: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(left: 20),
            // height: height * 0.06,
            height: height * 0.07,
            width: width * 0.75,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(5),
            ),
            child: TextFormField(
              controller: controller,
              //autofocus: true,
              minLines: 1,
              maxLines: 10,
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(7),
              ),
            ),
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
              if (controller.text.isNotEmpty) {
                facultyMethods
                    .facultyCreateOnApprove(controller.text, context)
                    .whenComplete(() {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                  facultyMethods.setState();
                });
              }
            },
          ),
        ],
      );
    },
  );
}

Future<void> showMyDialogDelete(
    BuildContext context, int id, FacultyMethods facultyMethods) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Delete Faculty'),
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
              facultyMethods.facultyDeleteOnApprove(id).whenComplete(() {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              });
            },
          ),
        ],
      );
    },
  );
}

Future<void> showMyDialogEdit(BuildContext context, FacultyModel facultyModel,
    FacultyMethods facultyMethods) async {
  final double width = MediaQuery.of(context).size.width;
  final double height = MediaQuery.of(context).size.height;
  TextEditingController controller = TextEditingController();
  controller.text = facultyModel.facultyName!;
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Edit Faculty'),
        content: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(left: 20),
            // height: height * 0.06,
            height: height * 0.07,
            width: width * 0.75,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(5),
            ),
            child: TextFormField(
              controller: controller,
              //autofocus: true,
              minLines: 1,
              maxLines: 10,
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(7),
              ),
            ),
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
              if (controller.text.isNotEmpty){
                facultyModel.facultyName = controller.text;
                facultyMethods
                    .facultyEditOnApprove(facultyModel, context)
                    .whenComplete(() {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                });
              }

            },
          ),
        ],
      );
    },
  );
}

