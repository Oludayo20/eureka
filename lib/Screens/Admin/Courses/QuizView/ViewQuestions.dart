import 'dart:async';
import 'package:flutter/material.dart';
import 'QuestionView.dart';

class ViewQuestions extends StatefulWidget {
  const ViewQuestions(
      {Key? key,
      required this.controller2,
      required this.questionMap,
      required this.streamController})
      : super(key: key);
  final ScrollController controller2;
  final Map<int, QuestionView> questionMap;
  final StreamController<int> streamController;

  @override
  State<ViewQuestions> createState() => _ViewQuestionsState();
}

class _ViewQuestionsState extends State<ViewQuestions> {
  int selectedIndex = 1;
  void changeQuestion(int number) {
    selectedIndex = number;
    setState(() {});
  }

  ScrollController controller2 = ScrollController();
  @override
  void initState() {
    super.initState();
    widget.streamController.stream.listen((event) {
      changeQuestion(event);
      if (controller2.hasClients) {
        final position = controller2.position.minScrollExtent;
        controller2.jumpTo(position);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
        controller: controller2,
        child: ListView(
          controller: controller2,
          children: [
            selectedIndex % 2 == 0
                ? widget.questionMap[selectedIndex - 1]!
                : widget.questionMap[selectedIndex]!,
            Container(
              height: 10,
            ),
            selectedIndex % 2 == 0
                ? widget.questionMap[selectedIndex]!
                : widget.questionMap.containsKey(selectedIndex + 1)
                    ? widget.questionMap[selectedIndex + 1]!
                    : Container(),
          ],
        ));
  }
}
