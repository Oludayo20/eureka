import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:school_management/Models/Course.dart';

import '../../../Models/ProgramCourse.dart';
import '../../../Widgets/AppBar.dart';
import '../AdminMainDrawer.dart';

class ProgramCourseView extends StatefulWidget {
  const ProgramCourseView(
      {Key? key, required this.programId, required this.title})
      : super(key: key);
  final int programId;
  final String title;
  @override
  State<ProgramCourseView> createState() => _ProgramCourseViewState();
}

class _ProgramCourseViewState extends State<ProgramCourseView> {
  List<Course> list = [];
  List<Course> courseList = [];
  List<String> courseCodeList = [];
  late final Map<int, int> programIds={};

  Map<String, int> courseCodeMap = {};
  Course? model;
  ProgramCourse? programCourseModel;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    list = [];
    courseList = [];
    model = Course();
    programCourseModel = ProgramCourse();
    model!.read(courseList).whenComplete(() {
      courseList.forEach((element) {
        courseCodeList.add(element.courseCode!);
        courseCodeMap[element.courseCode!] = element.courseId!;
      });
       readView();
    });
  }

  Future readView() async{
    List<ProgramCourse> proList = [];
    programIds.clear();
    int index = 0;
    await programCourseModel!.read(proList, widget.programId).whenComplete(() {
      proList.forEach((element) async {

        await Course().readById(list, element.courseId!).whenComplete((){
          programIds.addAll({index:element.courseProgramId!});
          index++;
          if(index==list.length)
            setState(() {});
        });

      });
    });
  }
  Future<void> _showMyDialogDelete(BuildContext context, int id) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Programs'),
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
                programCourseModel!
                    .delete(id, widget.programId)
                    .whenComplete(() {
                  list = [];
                  readView().whenComplete(() {
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
    String courseCodyKey = "";
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add Programs'),
          content: SingleChildScrollView(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    child: Text("Course"),
                  ),
                ],
              ),
              DropdownSearch<String>(
                validator: (v) => v == null ? "required field" : null,
                //hint: "Please Select Leave type",

                items: courseCodeList,
                onChanged: (value) {
                  courseCodyKey = value!;
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
                ProgramCourse()
                    .create(ProgramCourse(
                        courseId: courseCodeMap[courseCodyKey],
                        programId: widget.programId))
                    .whenComplete(() {
                  list = [];
                  readView().whenComplete(() {
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
        title: widget.title + "/ Courses",
      ),
      body: MyStatelessWidget(
        list: list,
        programIds: programIds,
        showCreate: _showMyDialogCreate,
        showDelete: _showMyDialogDelete,
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
  final Map<int, int> programIds;
  MyStatelessWidget(
      {Key? key,
      required this.list,
      required this.showCreate,
      required this.showDelete, required this.programIds})
      : super(key: key);
  final Function showCreate;
  final Function showDelete;
  final Course model = Course();
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
      int index = 0;
      String level = "";
      print(programIds.length);
      print(list.length);

      for(var i = 0; i<list.length; i++){
        Course element = list[i];
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
                    child: ListView(
                      children: [
                        Text(
                          element.courseTitle!,
                        )
                      ],
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                            color: Colors.red,
                            onPressed: () {
                              showDelete(context, programIds[i]);
                            },
                            icon: Icon(
                              Icons.delete,
                            )),
                      ],
                    ),
                  )),
            ),
          ],
        ));
        print("index: $index");
        index++;
      }
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
