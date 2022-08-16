import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:school_management/Models/Course.dart';
import 'package:school_management/Util/Notify.dart';
import '../../../Widgets/AppBar.dart';
import '../../Widgets/CardMaker.dart';
import '../../Widgets/TextFieldCard.dart';
import '../Admin/AdminMainDrawer.dart';
import 'LactureNote.dart';

class CourseView extends StatefulWidget {
  const CourseView({Key? key}) : super(key: key);
  @override
  State<CourseView> createState() => _CourseViewState();
}

class _CourseViewState extends State<CourseView> {
  Course? model;
  @override
  void initState() {
    super.initState();
  }

  void refresh() => setState(() {});
  Future<void> _showMyDialogDelete(BuildContext context, int id) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Course'),
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
                Course.delete(id).whenComplete(() async {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                  setState(() {});
                });
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> showMyDialogCourseEdit(
      BuildContext context, Course model) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        TextEditingController controller = TextEditingController();
        TextEditingController controllerCourseCode = TextEditingController();
        controller.text = model.courseTitle!;
        controllerCourseCode.text = model.courseCode!;
        String setLevel() {
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

        String level = setLevel();
        return CardMaker(
          body: ListView(
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
              Padding(
                padding: EdgeInsets.only(left: 5,top: 3),
                child: Row(
                  children: [
                    Container(
                      child: Text("Level"),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 5),
                child: DropdownSearch<String>(
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
              ),
              Padding(
                padding: EdgeInsets.only(left: 5,top: 5),
                child: Row(
                  children: [
                    Container(
                      child: Text("Semesters"),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 5),
                child: DropdownSearch<String>(
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
              ),
            ],
          ),
          footerActionLeft: TextButton(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          footerActionRight: TextButton(
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
          title: 'Edit Course',
        );
      },
    );
  }

  Future<void> showMyDialogCreate(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        int level = 0;
        int semester = 0;
        TextEditingController controller = TextEditingController();
        TextEditingController controllerCode = TextEditingController();
        return CardMaker(
          body: ListView(
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
              Padding(
                padding: EdgeInsets.only(left: 5,top: 3),
                child: Row(
                  children: [
                    Container(
                      child: Text("Level"),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 5),
                child: DropdownSearch<String>(
                  validator: (v) => v == null ? "required field" : null,
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
              ),
              Padding(
                padding: EdgeInsets.only(left: 5,top: 5),
                child: Row(
                  children: [
                    Container(
                      child: Text("Semesters"),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 5),
                child: DropdownSearch<String>(
                  validator: (v) => v == null ? "required field" : null,
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
              ),
              ExtraSpace()
            ],
          ),
          title: "Add Course",
          footerActionLeft: TextButton(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          footerActionRight: TextButton(
            child: const Text('Approve'),
            onPressed: () {
              try {
                if (controller.text.isEmpty) {
                  Notify.error(context, "Course Code cannot be empty");
                  return;
                } else if (controllerCode.text.isEmpty) {
                  Notify.error(context, "Course title cannot be empty");
                  return;
                } else if (level == 0) {
                  Notify.error(context, "Level must be selected");
                  return;
                } else if (semester == 0) {
                  Notify.error(context, "Semester must be selected");
                  return;
                }
                Notify.loading(context, "");
                Course.create(Course(
                        courseCode: controller.text,
                        courseTitle: controllerCode.text,
                        level: level,
                        semester: semester,
                        courseId: DateTime.now().microsecondsSinceEpoch))
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
        );
      },
    );
  }

  Future<void> _showMyDialogActionButton(
      BuildContext context, Course course) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Course'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                    color: Colors.blue,
                    onPressed: () {
                      Navigator.of(context).pop();
                      showMyDialogCourseEdit(context, course);
                    },
                    icon: Icon(
                      Icons.edit,
                    )),
                IconButton(
                    color: Colors.red,
                    onPressed: () {
                      Navigator.of(context).pop();
                      _showMyDialogDelete(context, course.courseId!);
                    },
                    icon: Icon(
                      Icons.delete,
                    )),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => LectureNoteView(
                            courseId: course.courseId!,
                            title: "${course.courseCode!}",
                          ),
                        ),
                      );
                    },
                    child: Text("Lecture Notes"))
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
          ],
        );
      },
    );
  }

  List<TableRow> tableRows(
      double width, double height, BuildContext context, List<Course> list) {
    List<TableRow> item = [];
    item.add(TableRow(
      decoration: const BoxDecoration(
        color: Colors.white24,
      ),
      children: <Widget>[
        TableCell(
          verticalAlignment: TableCellVerticalAlignment.top,
          child: Container(
              height: 40,
              width: width * 0.20,
              child: Center(
                child: Text(
                  "Course Title",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              )),
        ),
        TableCell(
          verticalAlignment: TableCellVerticalAlignment.top,
          child: Container(
              height: 40,
              width: width * 0.20,
              child: Center(
                child: Text(
                  "Course Code",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              )),
        ),
        TableCell(
          verticalAlignment: TableCellVerticalAlignment.top,
          child: Container(
              height: 40,
              width: width * 0.20,
              child: Center(
                child: Text(
                  "Level",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              )),
        ),
        TableCell(
          verticalAlignment: TableCellVerticalAlignment.top,
          child: Container(
              height: 40,
              width: width * 0.20,
              child: Center(
                child: Text(
                  "Semester",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              )),
        ),
        TableCell(
          verticalAlignment: TableCellVerticalAlignment.top,
          child: Container(
              height: 40,
              width: width * 0.20,
              child: Center(
                child: Text(
                  "Action",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              )),
        ),
      ],
    ));
    try {
      String level = "";
      list.forEach((element) {
        level = "";
        if (element.level == 1) {
          level = "100 Level";
        } else if (element.level == 2) {
          level = "200 Level";
        } else if (element.level == 3) {
          level = "300 Level";
        } else if (element.level == 4) {
          level = "400 Level";
        } else if (element.level == 5) {
          level = "500 Level";
        }
        item.add(TableRow(
          children: <Widget>[
            TableCell(
              verticalAlignment: TableCellVerticalAlignment.top,
              child: Container(
                  margin: EdgeInsets.only(left: 5, top: 5),
                  height: 40,
                  width: width * 0.20,
                  child: Center(
                      child: Text(
                    element.courseTitle!,
                    overflow: TextOverflow.ellipsis,
                  ))),
            ),
            TableCell(
              verticalAlignment: TableCellVerticalAlignment.top,
              child: Container(
                  height: 40,
                  width: width * 0.20,
                  child: Center(
                    child: Text(
                      element.courseCode!,
                    ),
                  )),
            ),
            TableCell(
              verticalAlignment: TableCellVerticalAlignment.top,
              child: Container(
                  height: 40,
                  width: width * 0.20,
                  child: Center(
                    child: Text(
                      level,
                    ),
                  )),
            ),
            TableCell(
              verticalAlignment: TableCellVerticalAlignment.top,
              child: Container(
                  height: 40,
                  width: width * 0.20,
                  child: Center(
                    child: Text(
                      element.semester == 1 ? "First" : "Second",
                    ),
                  )),
            ),
            TableCell(
              verticalAlignment: TableCellVerticalAlignment.top,
              child: Container(
                  height: 40,
                  width: width * 0.20,
                  child: Center(
                      child: IconButton(
                    onPressed: () =>
                        _showMyDialogActionButton(context, element),
                    icon: Icon(Icons.mouse),
                  ))),
            ),
          ],
        ));
      });
    } catch (ex) {}

    return item;
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    final GlobalKey<ScaffoldState> _scaffoldKey =
        new GlobalKey<ScaffoldState>();
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
        title: "Courses",
      ),
      body: FutureBuilder<List<Course>>(
        future:
            Course.getCourse(), // a previously-obtained Future<String> or null
        builder: (BuildContext context, AsyncSnapshot<List<Course>> snapshot) {
          Widget children;
          if (snapshot.hasData) {
            children = Padding(
              padding: EdgeInsets.all(5),
              child: ListView(
                children: [
                  Table(
                      border: TableBorder.all(),
                      columnWidths: const <int, TableColumnWidth>{
                        0: IntrinsicColumnWidth(),
                        1: FlexColumnWidth(),
                        2: FixedColumnWidth(64),
                      },
                      defaultVerticalAlignment:
                          TableCellVerticalAlignment.middle,
                      children:
                          tableRows(width, height, context, snapshot.data!))
                ],
              ),
            );
          } else if (snapshot.hasError) {
            children = Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            children = Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 60,
                      height: 60,
                      child: CircularProgressIndicator(
                        color: Colors.lime,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 16),
                      child: Text('Getting Course...'),
                    )
                  ]),
            );
          }
          return Center(
            child: children,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showMyDialogCreate(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
