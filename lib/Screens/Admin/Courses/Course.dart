import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:school_management/Models/Course.dart';

import '../../../Widgets/AppBar.dart';
import '../AdminMainDrawer.dart';
import 'LactureNote.dart';

class CourseView extends StatefulWidget {
  const CourseView({Key? key})
      : super(key: key);
  @override
  State<CourseView> createState() => _CourseViewState();
}

class _CourseViewState extends State<CourseView> {
  List<Course> list = [];
  Course? model;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    list = [];
    model = Course();
    model!.read(list).whenComplete(() {
      setState(() {});
    });
  }


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
                model!.delete(id).whenComplete(() {
                  list = [];
                  model!.read(list).whenComplete(() {
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

  Future<void> _showMyDialogEdit(BuildContext context, Course model) async {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    TextEditingController controller = TextEditingController();
    TextEditingController controllerCourseCode = TextEditingController();
    controller.text = model.courseTitle!;
    controllerCourseCode.text = model.courseCode!;
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
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit Course'),
          content: SingleChildScrollView(
              child: Column(
            children: [
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 5),
                    child: Text("Course Code"),
                  ),
                ],
              ),
              Container(
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
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 5),
                    child: Text("Course Title"),
                  ),
                ],
              ),
              Container(
                // height: height * 0.06,
                height: height * 0.07,
                width: width * 0.75,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: TextFormField(
                  controller: controllerCourseCode,
                  //autofocus: true,
                  minLines: 1,
                  maxLines: 10,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(7),
                  ),
                ),
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
                model.courseTitle = controller.text;
                model.courseCode = controllerCourseCode.text;
                model.update(model).whenComplete(() {
                  list = [];
                  model.read(list).whenComplete(() {
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

  Future<void> _showMyDialogCreate(BuildContext context) async {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    int level = 0;
    int semester = 0;
    TextEditingController controller = TextEditingController();
    TextEditingController controllerCode = TextEditingController();
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
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 5),
                    child: Text("Course Code"),
                  ),
                ],
              ),
              Container(
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
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 5),
                    child: Text("Course Title"),
                  ),
                ],
              ),
              Container(
                // height: height * 0.06,
                height: height * 0.07,
                width: width * 0.75,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: TextFormField(
                  controller: controllerCode,
                  //autofocus: true,
                  minLines: 1,
                  maxLines: 10,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(7),
                  ),
                ),
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
                model!
                    .create(Course(
                        courseCode: controller.text,
                        courseTitle: controllerCode.text,
                        level: level,
                        semester: semester,
                        courseId: 1))
                    .whenComplete(() {
                  list = [];
                  model!.read(list).whenComplete(() {
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

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey =
        new GlobalKey<ScaffoldState>();
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
        title: "Courses",
      ),
      body: MyStatelessWidget(
        list: list,
        showCreate: _showMyDialogCreate,
        showDelete: _showMyDialogDelete,
        showEdit: _showMyDialogEdit,
      ),
      // body: ListView(children: rows1(list, context)),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showMyDialogCreate(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class MyStatelessWidget extends StatelessWidget {
  final List<Course> list;
  MyStatelessWidget(
      {Key? key,
      required this.list,
      required this.showEdit,
      required this.showCreate,
      required this.showDelete})
      : super(key: key);
  final Function showEdit;
  final Function showCreate;
  final Function showDelete;
  final Course model = Course();

  Future<void> _showMyDialogActionButton(BuildContext context, Course course) async {
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
                      showEdit(context, course);
                    },
                    icon: Icon(
                      Icons.edit,
                    )),
                IconButton(
                    color: Colors.red,
                    onPressed: () {
                      Navigator.of(context).pop();
                      showDelete(context, course.courseId!);
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
  List<TableRow> tableRows(double width, double height, BuildContext context) {
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
      /*list.add(Course(courseTitle: "Introduction to Computer",
      courseCode: "CSC 120",
      level: 2, semester: 1, courseId: 1));*/
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
                    child: ListView(children: [
                      Text(
                        element.courseTitle!,
                      )
                    ],),
                  )),
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
                      element.semester == 1?"First":"Second",
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
                      onPressed:()=> _showMyDialogActionButton(context, element),
                      icon: Icon(Icons.mouse),
                    )
                  )),
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
    return ListView(
      children: [
        Table(
            border: TableBorder.all(),
            columnWidths: const <int, TableColumnWidth>{
              0: IntrinsicColumnWidth(),
              1: FlexColumnWidth(),
              2: FixedColumnWidth(64),
            },
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            children: tableRows(width, height, context))
      ],
    );
  }
}
