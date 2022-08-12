import 'package:flutter/material.dart';
import 'package:school_management/Widgets/AppBar.dart';
import '../../../Util/Notify.dart';
import '../AdminMainDrawer.dart';
import 'Methods.dart';
import 'Widgets.dart';

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
      case 4:
        Notify.error(context, "Faculty name cannot be empty");
        break;
      case 5:
        Navigator.pop(context);
        break;
    }
  }

  @override
  void initState() {
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

  @override
  Widget build(BuildContext context) {
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
            color: Colors.white,
            /*image: DecorationImage(
                  image: NetworkImage(ImagePath.home),
                  //image: AssetImage(ImagePath().homePageImageAssert),
                  fit: isAndroid ? BoxFit.cover : BoxFit.fill)),*/
          ),
          child: ListView(
            children: facultyByRow(
                _facultyMethods!.facultyList, context, _facultyMethods!),
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
