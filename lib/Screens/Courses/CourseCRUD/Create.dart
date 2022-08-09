
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

import '../../../Models/Course.dart';
import '../../../Util/Notify.dart';
import '../../../Util/screen_layout.dart';
import '../../../Widgets/CardMaker.dart';
import '../../../Widgets/TextFieldCard.dart';

class CreateCoursePopUp extends StatelessWidget {
  const CreateCoursePopUp({Key? key, required this.refresh}) : super(key: key);
  final Function refresh;
  @override
  Widget build(BuildContext context) {
    int level = 0;
    int semester = 0;
    TextEditingController controller = TextEditingController();
    TextEditingController controllerCode = TextEditingController();
    Layout layout = Layout(size: MediaQuery.of(context).size);
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
                              controller: controller,
                              originalHeight: 30,
                              headerText: "Course Code",
                            ),
                            TextFieldCard(
                              width: double.infinity,
                              controller: controllerCode,
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
                              validator: (v) =>
                              v == null ? "required field" : null,
                              //hint: "Please Select Leave type",

                              items: [
                                "100 Level",
                                "200 Level",
                                "300 Level",
                                '400 Level',
                                '500 Level'
                              ],
                              onChanged: (value) {
                                if (value == "100 Level") {
                                  level = 1;
                                } else if (value == "200 Level") {
                                  level = 2;
                                } else if (value == "300 Level") {
                                  level = 3;
                                } else if (value == "400 Level") {
                                  level = 4;
                                } else if (value == "500 Level") {
                                  level = 5;
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
                              validator: (v) =>
                              v == null ? "required field" : null,
                              //hint: "Please Select Leave type",

                              items: ["First", "Second"],
                              onChanged: (value) {
                                if (value == "First") {
                                  semester = 1;
                                } else {
                                  semester = 2;
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
                              try {
                                if (controller.text.isEmpty) {
                                  Notify.error(
                                      context, "Course Code cannot be empty");
                                  return;
                                } else if (controllerCode.text.isEmpty) {
                                  Notify.error(
                                      context, "Course title cannot be empty");
                                  return;
                                } else if (level == 0) {
                                  Notify.error(context, "Level must be selected");
                                  return;
                                } else if (semester == 0) {
                                  Notify.error(
                                      context, "Semester must be selected");
                                  return;
                                }
                                Notify.loading(context, "");
                                Course.create(Course(
                                    courseCode: controller.text,
                                    courseTitle: controllerCode.text,
                                    level: level,
                                    semester: semester,
                                    courseId:
                                    DateTime.now().microsecondsSinceEpoch))
                                    .whenComplete(() {
                                  Navigator.of(context).pop();
                                  Navigator.of(context).pop();
                                  //setState(() {});
                                  refresh();
                                });
                              } catch (e) {
                                print(e);
                              }
                            },
                          ),
                        ],
                      )),
                ),
              ),
            ]));
  }
}