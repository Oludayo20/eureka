import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

import '../../../Models/Course.dart';
import '../../../Util/Notify.dart';
import '../../../Util/screen_layout.dart';
import '../../../Widgets/CardMaker.dart';
import '../../../Widgets/TextFieldCard.dart';


class EditCoursePopUp extends StatelessWidget {
  const EditCoursePopUp({Key? key, required this.refresh, required this.model}) : super(key: key);
  final Function refresh;
  final Course model;
  @override
  Widget build(BuildContext context) {
    Layout layout = Layout(size: MediaQuery.of(context).size);
    TextEditingController controller = TextEditingController();
    TextEditingController controllerCourseCode = TextEditingController();
    controller.text = model.courseTitle!;
    controllerCourseCode.text = model.courseCode!;
    String level = _setLevel();

    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CardHeader(cardTitle: "Add Course",),
              Container(
                height: layout.height * 0.7,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      color: Colors.white,
                      width: layout.isAndroid
                          ? layout.width * 0.8
                          : layout.width * 0.5,
                      child: Padding(
                        padding: EdgeInsets.all(4),
                        child: ListView(
                          children: [
                            TextFieldCard(
                              width: double.infinity,
                              controller: controllerCourseCode,
                              originalHeight: 30,
                              headerText: "Course Code",
                            ),
                            TextFieldCard(
                              width: double.infinity,
                              controller: controller,
                              originalHeight: 30,
                              headerText: "Course Title",
                            ),
                            Row(
                              children: [
                                Container(
                                  child: Text("Level"),
                                ),
                              ],
                            ),
                            DropdownSearch<String>(
                              validator: (v) => v == null ? "required field" : null,
                              //hint: "Please Select Leave type",
                              selectedItem: level,
                              items: [
                                "100 Level",
                                "200 Level",
                                "300 Level",
                                '400 Level',
                                '500 Level'
                              ],
                              onChanged: (value) {
                                if (value == "100 Level") {
                                  model.level = 1;
                                } else if (value == "200 Level") {
                                  model.level = 2;
                                } else if (value == "300 Level") {
                                  model.level = 3;
                                } else if (value == "400 Level") {
                                  model.level = 4;
                                } else if (value == "500 Level") {
                                  model.level = 5;
                                }
                              },
                            ),
                            Row(
                              children: [
                                Container(
                                  child: Text("Semesters"),
                                ),
                              ],
                            ),
                            DropdownSearch<String>(
                              validator: (v) => v == null ? "required field" : null,
                              //hint: "Please Select Leave type",
                              selectedItem: model.semester == 1 ? "First" : "Second",
                              items: ["First", "Second"],
                              onChanged: (value) {
                                if (value == "First") {
                                  model.semester = 1;
                                } else {
                                  model.semester = 2;
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                height: layout.height * 0.1,
                color: Colors.white,
                width:
                layout.isAndroid ? layout.width * 0.8 : layout.width * 0.5,
                child: Card(
                  child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            child: const Text('Cancel'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          TextButton(
                            child: const Text('Approve'),
                            onPressed: () {
                              if (controllerCourseCode.text.isEmpty) {
                                Notify.error(context, "Course Code cannot be empty");
                                return;
                              } else if (controller.text.isEmpty) {
                                Notify.error(context, "Course title cannot be empty");
                                return;
                              } else if (model.level == 0) {
                                Notify.error(context, "Level must be selected");
                                return;
                              } else if (model.semester == 0) {
                                Notify.error(context, "Semester must be selected");
                                return;
                              }
                              Notify.loading(context, "");
                              model.courseTitle = controller.text;
                              model.courseCode = controllerCourseCode.text;
                              model.update(model).whenComplete(() async {
                                Navigator.pop(context);
                                Navigator.pop(context);
                                refresh();
                              });
                            },
                          ),
                        ],
                      )),
                ),
              ),
            ]));
  }

  String _setLevel(){
    String level = "";
    if (model.level == 1) {
      level = "100 Level";
    } else if (model.level == 2) {
      level = "200 Level";
    } else if (model.level == 3) {
      level = "300 Level";
    } else if (model.level == 4) {
      level = "400 Level";
    } else if (model.level == 5) {
      level = "500 Level";
    }
    return level;
  }
}
