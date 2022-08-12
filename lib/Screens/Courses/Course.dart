import 'package:flutter/material.dart';
import 'package:school_management/Models/Course.dart';
import 'package:school_management/Util/Notify.dart';
import '../../../Widgets/AppBar.dart';
import '../Admin/AdminMainDrawer.dart';
import 'CourseCRUD/Create.dart';
import 'CourseCRUD/Edit.dart';
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

  Future<void> _showMyDialogEdit(BuildContext context, Course model) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return EditCoursePopUp(refresh: refresh, model: model);
      },
    );
  }

  Future<void> _showMyDialogCreate(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return CreateCoursePopUp(
          refresh: refresh,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
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
              child: MyStatelessWidget(
                list: snapshot.data!,
                showCreate: _showMyDialogCreate,
                showDelete: _showMyDialogDelete,
                showEdit: _showMyDialogEdit,
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
                      child: Text(
                    element.courseTitle!,
                    overflow: TextOverflow.fade,
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
