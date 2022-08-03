import 'package:flutter/material.dart';
import 'package:school_management/Models/Programs.dart';
import 'package:school_management/Widgets/AppBar.dart';
import '../../Courses/ProgramCourse.dart';
import '../AdminMainDrawer.dart';

class ProgramView extends StatefulWidget {
  const ProgramView({Key? key, required this.deptId, required this.title}) : super(key: key);
  final int deptId;
  final String title;
  @override
  State<ProgramView> createState() => _ProgramViewState();
}

class _ProgramViewState extends State<ProgramView> {
  bool showAddScreen = false;
  List<Programs> list = [];
  Programs? model;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    showAddScreen = false;
    list = [];
    model = Programs();
    model!.read(list, widget.deptId).whenComplete(() {
      setState(() {});
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
                model!.delete(widget.deptId,id).whenComplete(() {
                  list = [];
                  model!.read(list, widget.deptId).whenComplete(() {
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
      BuildContext context, Programs model) async {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    TextEditingController controller = TextEditingController();
    controller.text = model.programName!;
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit Programs'),
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
                model.programName = controller.text;
                model.update(model).whenComplete(() {
                  list = [];
                  model.read(list, widget.deptId).whenComplete(() {
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
          title: const Text('Add Programs'),
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
                    .create(Programs(programName: controller.text, departmentId: widget.deptId))
                    .whenComplete(() {
                  list = [];
                  model!.read(list, widget.deptId).whenComplete(() {
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


  List<Widget> rows1(List<Programs> list, BuildContext context) {
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
          "Programs Name",
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
                  list[i].programName!,
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
                        _showMyDialogDelete(context, list[i].programId!);
                      },
                      icon: Icon(
                        Icons.delete,
                      )),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) => ProgramCourseView(
                              programId: list[i].programId!,
                              title: "${list[i].programName}",
                            ),
                          ),
                        );
                      },
                      child: Text("Courses"))
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
        title: "${widget.title}/Programs",
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
