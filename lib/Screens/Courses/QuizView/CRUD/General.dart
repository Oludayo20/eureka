import 'package:flutter/material.dart';
Widget optionsAdd(TextEditingController controller, double width, double height){
  return Container(
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
  );
}

Widget heading(String text){
  return Row(
    children: [
      Container(
        margin: EdgeInsets.only(left: 5, bottom: 10),
        child: Text(text),
      ),
    ],
  );
}


String emptyField(
    String question,
    String a,
    String b,
    String c,
    String d,
    String e,
    String answer,
    bool isEdit
    ) {
  if (question.isEmpty)
    return "Question field cannot be empty";
  else if (answer.isEmpty && !isEdit)
    return "Answer field cannot be empty";
  else if (a.isEmpty)
    return "Option A field cannot be empty";
  else if (b.isEmpty)
    return "Option B field cannot be empty";
  else if (c.isEmpty)
    return "Option C field cannot be empty";
  else if (d.isEmpty)
    return "Option D field cannot be empty";
  else if (e.isEmpty) return "Option E field cannot be empty";
  return "";
}
