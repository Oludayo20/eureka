import 'dart:async';
import 'dart:html';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:school_management/Models/QuizOption.dart';

import '../../../../Models/Quiz.dart';
import '../../../../Widgets/AppBar.dart';
import '../../../../Widgets/BouncingButton.dart';
import '../../../../services/authentication_helper.dart';
import '../../AdminMainDrawer.dart';
import 'BigScreen.dart';
import 'Buttons.dart';
import 'QuestionView.dart';
import 'SmallScreen.dart';

class QuizView extends StatefulWidget {
  const QuizView({Key? key, required this.title, required this.lectureNoteId})
      : super(key: key);
  final String title;
  final int lectureNoteId;
  @override
  State<QuizView> createState() => _QuizViewState();
}

class _QuizViewState extends State<QuizView> {

  Map<int, QuestionView> questionMap = Map<int, QuestionView>();
  Map<int, int> selectedOption = Map<int, int>();
  late StreamController<int> streamController;
  late  StreamController<int> numberButtonStreamController;
  List<Quiz> list = [];
  Quiz? model;
  int numberOfQuestion= 0;
  bool isAdmin = false;
  @override
  void initState() {
    super.initState();
    streamController = StreamController.broadcast();
    numberButtonStreamController = StreamController.broadcast();
    list = [];
    model = Quiz();
    isAdmin = AuthenticationHelper().isAdmin();
    model!.read(list, widget.lectureNoteId).whenComplete(() {
      setState(() {});
    });
  }
  @override
  void dispose() {
    // TODO: implement dispose
    streamController.close();
    super.dispose();
  }
  void changeQuestion(int number) {
    streamController.add(number);
  }
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
                  optionsAdd(questionController,width,height),
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
                  optionsAdd(optionAControllerCode,width,height),
                  heading("Option B"),
                  optionsAdd(optionBControllerCode,width,height),
                  heading("Option C"),
                  optionsAdd(optionCControllerCode,width,height),
                  heading("Option D"),
                  optionsAdd(optionDControllerCode,width,height),
                  heading("Option E"),
                  optionsAdd(optionEControllerCode,width,height),

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
                int ans = 0;
                if(answerControllerCode.text == "A")
                  ans = 1;
                else if(answerControllerCode.text == "B")
                  ans  = 2;
                else if(answerControllerCode.text == "C")
                  ans  = 3;
                else if(answerControllerCode.text == "D")
                  ans  = 4;
                else if(answerControllerCode.text == "E")
                  ans  = 5;

                Quiz()
                    .create(Quiz(
                  question: questionController.text,
                  lectureNoteId: lectureNoteId,
                  answer:  ans,
                  options: QuizOptions(
                    quizOptionA: optionAControllerCode.text,
                    quizOptionB: optionBControllerCode.text,
                    quizOptionC: optionCControllerCode.text,
                    quizOptionD: optionDControllerCode.text,
                    quizOptionE: optionEControllerCode.text,
                  ),
                ))
                    .whenComplete(() {
                  list = [];
                  Quiz().read(list, widget.lectureNoteId).whenComplete(() {
                    Navigator.of(context).pop();
                    setState(() {});
                  });
                });
              },
            ),
          ],
        );
      },
    );
  }

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
  List<Widget> buttonRow(
      {required int length,
      required int number,
      required double textButtonFontSize,
      required double textButtonWidth,
      required double textButtonHeight}) {
    List<Widget> buttons = [];
    for (var i = number; i < number + length; i++) {
      questionMap[i] = QuestionView(
        numberButtonStreamController: numberButtonStreamController,
        selectedOption: selectedOption,
        questionNumber: i,
        quiz: list[i-1],
      );
      selectedOption[i] = 0;
      buttons.add(Bouncing(
          onPress: () => changeQuestion(i),
          child: NumberButtons(
            selectedOption: selectedOption,
            numberButtonStreamController: numberButtonStreamController,
            number: i,
            textButtonFontSize: textButtonFontSize,
            textButtonHeight: textButtonHeight,
            textButtonWidth: textButtonWidth,
          )));
      numberOfQuestion--;
      if(numberOfQuestion == 0)
        break;
    }
    return buttons;
  }

  List<Widget> buttonColumn(
      {required int perColumn,
      required int perRow,
      required double textButtonFontSize,
      required double textButtonWidth,
      required double textButtonHeight}) {
    List<Widget> items = [];
    int number = 1;
    if(list.length == 0)
      return items;
    numberOfQuestion = list.length;
    while(numberOfQuestion > 0) {
      var buttons = buttonRow(
          length: perRow,
          number: number,
          textButtonFontSize: textButtonFontSize,
          textButtonWidth: textButtonWidth,
          textButtonHeight: textButtonHeight);
      number += buttons.length;
      items.add(Padding(
        padding: EdgeInsets.only(top: 5),
        child: Row(
          children: buttons,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        ),
      ));
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey =
        new GlobalKey<ScaffoldState>();
    final double width = MediaQuery.of(context).size.width;
    streamController = StreamController.broadcast();
    numberButtonStreamController = StreamController.broadcast();
    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        elevation: 0,
        child: AdminMainDrawer(),
      ),
      appBar: CommonAppBar(
        menuenabled: true,
        notificationenabled: false,
        ontap: () {
          _scaffoldKey.currentState!.openDrawer();
        },
        title: "${widget.title}/Quiz",
      ),
      body: width < 600
          ? SmallScreen(
              questionMap: questionMap,
              buttonColumn: buttonColumn,
              streamController: streamController,
            )
          : BigScreen(
              questionMap: questionMap,
              buttonColumn: buttonColumn,
              streamController: streamController,
            ),
      floatingActionButtonLocation:isAdmin? FloatingActionButtonLocation.centerDocked:null,
      floatingActionButton: isAdmin? FloatingActionButton(
        onPressed: () => showMyDialogCreate(context, widget.lectureNoteId),
        child: Icon(Icons.add),
      ):null,
    );
  }
}
