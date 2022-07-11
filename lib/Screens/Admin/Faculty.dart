import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:school_management/Models/Department.dart';
import 'package:school_management/Widgets/AppBar.dart';
import '../../Models/Faculty.dart';
import '../../Widgets/DashboardCards.dart';
import 'AdminMainDrawer.dart';
import 'HomePage/DepartmentView.dart';

class Faculty extends StatefulWidget {
  const Faculty({Key? key}) : super(key: key);

  @override
  State<Faculty> createState() => _FacultyState();
}

class _FacultyState extends State<Faculty> {
  bool showAddScreen = false;
  List<FacultyModel> facultyList = [];
  FacultyModel? facultyModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    showAddScreen = false;
    facultyList = [];
    facultyModel = FacultyModel();
    facultyModel!.read(facultyList).whenComplete(() {
      setState(() {});
    });
  }

  Future<void> _showMyDialogDelete(BuildContext context, int id) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Faculty'),
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
                facultyModel!.delete(id).whenComplete(() {
                  facultyList = [];
                  facultyModel!.read(facultyList).whenComplete(() {
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
      BuildContext context, FacultyModel facultyModel) async {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    TextEditingController controller = TextEditingController();
    controller.text = facultyModel.facultyName!;
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit Faculty'),
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
                facultyModel.facultyName = controller.text;
                facultyModel.update(facultyModel).whenComplete(() {
                  facultyList = [];
                  facultyModel.read(facultyList).whenComplete(() {
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
          title: const Text('Create Faculty'),
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
                facultyModel!
                    .create(FacultyModel(facultyName: controller.text))
                    .whenComplete(() {
                  facultyList = [];
                  facultyModel!.read(facultyList).whenComplete(() {
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

  List<Widget> rows1(List<FacultyModel> facultyList, BuildContext context) {
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
          "Faculty Name",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
      ),
    ));
    for (var i = 0; i < facultyList.length; i += 1) {
      items.add(Card(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: EdgeInsets.only(left: 20),
            child: Text(
              facultyList[i].facultyName!,
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
                    _showMyDialogEdit(context, facultyList[i]);
                  },
                  icon: Icon(
                    Icons.edit,
                  )),
              IconButton(
                  color: Colors.red,
                  onPressed: () {
                    _showMyDialogDelete(context, facultyList[i].facultyId!);
                  },
                  icon: Icon(
                    Icons.delete,
                  )),

              TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => DepartmentView(
                          facultyId: facultyList[i].facultyId!,
                          title: facultyList[i].facultyName!,
                        ),
                      ),
                    );
                  },
                  child: Text("Departments"))
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
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

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
        title: "Faculty",
      ),
      body: ListView(
        children: rows1(facultyList, context),
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
