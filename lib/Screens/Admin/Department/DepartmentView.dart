import 'package:flutter/material.dart';
import 'package:school_management/Widgets/AppBar.dart';
import '../../../Util/Notify.dart';
import '../AdminMainDrawer.dart';
import 'Methods.dart';
import 'Widgets.dart';

class DepartmentView extends StatefulWidget {
  const DepartmentView({Key? key, required this.facultyId, required this.title}) : super(key: key);
  final int facultyId;
  final String title;
  @override
  State<DepartmentView> createState() => _DepartmentViewState();
}

class _DepartmentViewState extends State<DepartmentView> {
  DepartmentMethods? _departmentMethods;
  void notify(int num) {
    switch (num) {
      case 1:
        Notify.error(context, "Department already Exist");
        break;
      case 2:
        Notify.success(context, "Success");
        break;
      case 3:
        Notify.loading(context, "");
        break;
      case 4:
        Notify.error(context, "Department name cannot be empty");
        break;
      case 5:
        Navigator.pop(context);
        break;
    }
  }

  @override
  void initState() {
    super.initState();
    _departmentMethods = DepartmentMethods(facultyId: widget.facultyId);
    _departmentMethods!.streamController.stream.listen((event) {
      if (event != 0)
        notify(event);
      else
        setState(() {});
    });
    _departmentMethods!.initState().whenComplete(() => setState(() {}));
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
        children: departmentByRow(context, _departmentMethods!),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showMyDialogCreateDepartment(context, _departmentMethods!);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
