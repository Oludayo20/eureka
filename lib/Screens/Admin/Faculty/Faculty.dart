import 'package:flutter/material.dart';
import 'package:school_management/Widgets/AppBar.dart';
import '../../../Models/Faculty.dart';
import '../../../Util/ImagePath.dart';
import '../../../Util/Notify.dart';
import '../AdminMainDrawer.dart';
import 'Methods.dart';
import 'Widgets.dart';
import '../HomePage/DepartmentView.dart';

class Faculty extends StatefulWidget {
  const Faculty({Key? key}) : super(key: key);

  @override
  State<Faculty> createState() => _FacultyState();
}

class _FacultyState extends State<Faculty> {
  FacultyMethods? _facultyMethods;
  void notify(int num) {
    switch (num) {
      case 1:
        Notify.error(context, "Faculty already Exist");
        break;
      case 2:
        Notify.success(context, "Success");
        break;
      case 3:
        Notify.loading(context, "");
        break;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _facultyMethods = FacultyMethods();
    _facultyMethods!.facultyStreamController.stream.listen((event) {
      if (event != 0)
        notify(event);
      else
        setState(() {});
    });
    _facultyMethods!.initState().whenComplete(() => setState(() {}));
  }

  List<Widget> facultyByRow(
      List<FacultyModel> facultyList, BuildContext context) {
    List<Widget> items = [];

    items.add(Card(
      color: Colors.white12,
      child: ListTile(
        trailing: Text(
          "Action",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        title: Text(
          "Faculty Name",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
    ));
    for (var i = 0; i < facultyList.length; i += 1) {
      items.add(Card(
          color: Colors.transparent,
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
                        showMyDialogEdit(
                            context, facultyList[i], _facultyMethods!);
                      },
                      icon: Icon(
                        Icons.edit,
                      )),
                  IconButton(
                      color: Colors.red,
                      onPressed: () {
                        showMyDialogDelete(context, facultyList[i].facultyId!,
                            _facultyMethods!);
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
                    child: Text(
                      "Departments",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                        fontSize: 15,
                      ),
                    ),
                  )
                ],
              )
            ],
          )));
    }

    return items;
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    bool isAndroid = false;
    if (width < 600) isAndroid = true;
    final GlobalKey<ScaffoldState> _scaffoldKey =
        new GlobalKey<ScaffoldState>();
    return Container(
      child: Scaffold(
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
        body: Container(
          decoration: BoxDecoration(
              color: Colors.black,
              image: DecorationImage(
                  image: NetworkImage(ImagePath.home),
                  //image: AssetImage(ImagePath().homePageImageAssert),
                  fit: isAndroid ? BoxFit.cover : BoxFit.fill)),
          child: ListView(
            children: facultyByRow(_facultyMethods!.facultyList, context),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showMyDialogCreate(context, _facultyMethods!);
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
