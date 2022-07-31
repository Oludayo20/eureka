import 'package:flutter/material.dart';

import '../../../Models/Department.dart';
import '../HomePage/ProgramsView.dart';
import 'Methods.dart';

Future<void> _showMyDialogDelete(
    BuildContext context, int id, DepartmentMethods departmentMethods) async {
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
              departmentMethods.deleteOnApprove(id).whenComplete(() {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              });
            },
          ),
        ],
      );
    },
  );
}

Future<void> _showMyDialogEdit(BuildContext context, Department model,
    DepartmentMethods departmentMethods) async {
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
              if (controller.text.isNotEmpty) {
                model.departmentName = controller.text;
                departmentMethods.editOnApprove(model, context).then((val) {});
              } else {
                departmentMethods.streamController.add(4);
              }
            },
          ),
        ],
      );
    },
  );
}

Future<void> showMyDialogCreateDepartment(
    BuildContext context, DepartmentMethods departmentMethods) async {
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
              if (controller.text.isNotEmpty) {
                departmentMethods
                    .createOnApprove(
                        Department(
                            departmentName: controller.text, facultyId: 0),
                        context)
                    .then((value) {
                  if (value) {
                    departmentMethods.setState();
                  }
                });
              } else {
                departmentMethods.streamController.add(4); // notify is empty
              }
            },
          ),
        ],
      );
    },
  );
}

List<Widget> departmentByRow(
    BuildContext context, DepartmentMethods departmentMethods) {
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
  for (var i = 0; i < departmentMethods.departmentList.length; i += 1) {
    items.add(Card(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          margin: EdgeInsets.only(left: 20),
          child: Text(
            departmentMethods.departmentList[i].departmentName!,
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
                  _showMyDialogEdit(context,
                      departmentMethods.departmentList[i], departmentMethods);
                },
                icon: Icon(
                  Icons.edit,
                )),
            IconButton(
                color: Colors.red,
                onPressed: () {
                  _showMyDialogDelete(
                      context,
                      departmentMethods.departmentList[i].departmentId!,
                      departmentMethods);
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
                        deptId:
                            departmentMethods.departmentList[i].departmentId!,
                        title:
                            "${departmentMethods.departmentList[i].departmentName!}",
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
