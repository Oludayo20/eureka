import 'dart:async';
import 'package:flutter/material.dart';
import 'QuestionView.dart';

class NumberButtons extends StatefulWidget {
  const NumberButtons(
      {Key? key,
      required this.numberButtonStreamController,
      required this.textButtonWidth,
      required this.textButtonHeight,
      required this.textButtonFontSize,
      required this.number,
      required this.selectedOption})
      : super(key: key);
  final StreamController<int> numberButtonStreamController;
  final double textButtonWidth;
  final double textButtonHeight;
  final double textButtonFontSize;
  final Map<int, int> selectedOption;
  final int number;

  @override
  State<NumberButtons> createState() => _NumberButtonsState();
}

class _NumberButtonsState extends State<NumberButtons> {
  Color buttonColor = Colors.white;
  @override
  void initState() {
    super.initState();
    widget.numberButtonStreamController.stream.listen((event) {
      if (widget.number == event) {
        widget.selectedOption[event] == 0
            ? buttonColor = Colors.white
            : buttonColor = Colors.black12;
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.textButtonWidth,
      height: widget.textButtonHeight,
      decoration: BoxDecoration(
          color: buttonColor,
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.all(Radius.circular(5))),
      child: Center(
        child: Text(
          "${widget.number}",
          style: TextStyle(

              fontSize: widget.textButtonFontSize,
          ),
        ),
      ),
    );
  }
}
