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