import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:school_management/Models/Department.dart';
import 'package:school_management/Widgets/AppBar.dart';

import '../AdminMainDrawer.dart';
import 'ProgramsView.dart';

class DepartmentView extends StatefulWidget {
  const DepartmentView({Key? key, required this.facultyId, required this.title}) : super(key: key);
  final int facultyId;
  final String title;
  @override
  State<DepartmentView> createState() => _DepartmentViewState();
}

class _DepartmentViewState extends State<DepartmentView> {
  bool showAddScreen = false;
  List<Department> list = [];
  Department? model;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    showAddScreen = false;
    list = [];
    model = Department();
    model!.read(list, widget.facultyId).whenComplete(() {
      setState(() {});
    });
  }

  Future<void> _showMyDialogDelete(BuildContext context, int id) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Department'),
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
                model!.delete(widget.facultyId,id).whenComplete(() {
                  list = [];
                  model!.read(list, widget.facultyId).whenComplete(() {
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

  Future<void> _showMyDialogEdit(
      BuildContext context, Department model) async {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    TextEditingController controller = TextEditingController();
    controller.text = model.departmentName!;
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit Department'),
          content: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.only(left: 20),
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
                model.departmentName = controller.text;
                model.update(model).whenComplete(() {
                  list = [];
                  model.read(list, widget.facultyId).whenComplete(() {
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
    TextEditingController controller = TextEditingController();
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add Department'),
          content: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.only(left: 20),
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
                model!
                    .create(Department(departmentName: controller.text, facultyId: widget.facultyId))
                    .whenComplete(() {
                  list = [];
                  model!.read(list, widget.facultyId).whenComplete(() {
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


  List<Widget> rows1(List<Department> list, BuildContext context) {
    List<Widget> items = [];
    items.add(Card(
      color: Colors.white10,
      child: ListTile(
        trailing: Text(
          "Action",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
        title: Text(
          "Department Name",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
      ),
    ));
    for (var i = 0; i < list.length; i += 1) {
      items.add(Card(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: EdgeInsets.only(left: 20),
                child: Text(
                  list[i].departmentName!,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
              Row(
                children: [
                  IconButton(
                      color: Colors.blue,
                      onPressed: () {
                        _showMyDialogEdit(context, list[i]);
                      },
                      icon: Icon(
                        Icons.edit,
                      )),
                  IconButton(
                      color: Colors.red,
                      onPressed: () {
                        _showMyDialogDelete(context, list[i].departmentId!);
                      },
                      icon: Icon(
                        Icons.delete,
                      )),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) => ProgramView(
                              deptId: list[i].departmentId!,
                              title: "${widget.title}/ ${list[i].departmentName!}",
                            ),
                          ),
                        );
                      },
                      child: Text("Programs"))
                ],
              )
            ],
          )));
    }

    return items;
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
        title: "${widget.title}/Departments",
      ),
      body:ListView(
        children: rows1(list, context),
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
