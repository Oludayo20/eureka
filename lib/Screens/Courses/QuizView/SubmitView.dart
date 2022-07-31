import 'dart:async';

import 'package:flutter/material.dart';

import '../../../Util/screen_layout.dart';
import '../../../Widgets/AppBar.dart';
import '../../../Widgets/MainDrawer.dart';
import 'Buttons.dart';

class SubmitView extends StatelessWidget {
  const SubmitView({Key? key, required this.selectedOption}) : super(key: key);
  final Map<int, int> selectedOption;
  @override
  Widget build(BuildContext context) {
    Layout layout = Layout(size: MediaQuery.of(context).size);
    List<Widget> numberList() {
      List<Widget> item = [];
      selectedOption.forEach((key, value) {
        item.add(NumberButtons(
          selectedOption: selectedOption,
          textButtonWidth: layout.width * 0.03,
          textButtonHeight: layout.height * 0.04,
          textButtonFontSize: 20,
          number: key,
          numberButtonStreamController: StreamController(),
        ));
        item.add(SizedBox(
          height: 5,
        ));
      });
      return item;
    }

    final GlobalKey<ScaffoldState> _scaffoldKey =
        new GlobalKey<ScaffoldState>();
    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        elevation: 0,
        child: MainDrawer(),
      ),
      appBar: CommonAppBar(
        menuenabled: true,
        notificationenabled: true,
        ontap: () {
          _scaffoldKey.currentState!.openDrawer();
        },
        title: "Student Dashboard",
      ),
      body: Container(
          width: layout.width * 0.09,
          child: ListView(
            children: numberList(),
          )),
      bottomSheet: Padding(
        padding: EdgeInsets.all(10),
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    "Back",
                    style: TextStyle(fontSize: 20),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
