import 'dart:async';

import 'package:flutter/cupertino.dart';

import '../../../Models/Department.dart';

class DepartmentMethods {
  StreamController<int> streamController = StreamController<int>();
  bool showAddScreen = false;
  List<Department> departmentList = [];
  Department? departmentModel;
  Set<String> departmentNames = {};
  int facultyId;
  DepartmentMethods({required this.facultyId});
  Future initState() async {
    showAddScreen = false;
    departmentList = [];
    departmentModel = Department();
    await departmentModel!.read(departmentList, facultyId).whenComplete(() {
      fillCheckList();
    });
  }

  void fillCheckList() {
    departmentNames.clear();
    departmentList.forEach((element) {
      departmentNames.add(element.departmentName!.toLowerCase());
    });
  }

  void setState() => streamController.add(0);

  bool _checkIfFacultyExists(String facultyName) {
    return departmentNames.contains(facultyName.toLowerCase());
  }

  Future deleteOnApprove(int id) async {
    streamController.add(3);
    await departmentModel!.delete(facultyId, id).whenComplete(() async {
      departmentList.clear();
      await departmentModel!.read(departmentList, facultyId).whenComplete(() {
        streamController.add(2);
        setState();
        fillCheckList();
      });
    });
  }

  Future<bool> createOnApprove(
      Department department, BuildContext context) async {
    if (_checkIfFacultyExists(department.departmentName!)) {
      streamController.add(1);
      return false;
    }
    streamController.add(3);
    department.facultyId = facultyId;
    await departmentModel!.create(department).whenComplete(() async {
      departmentList.clear();
      await departmentModel!.read(departmentList, facultyId).whenComplete(() {
        streamController.add(5); // notify pop
        streamController.add(2); // notify success
        fillCheckList();
      });
    });
    return true;
  }

  Future<bool> editOnApprove(
      Department department, BuildContext context) async {
    if (_checkIfFacultyExists(department.departmentName!)) {
      streamController.add(1);
      return false;
    }
    streamController.add(3);
    await departmentModel!.update(department).whenComplete(() async {
      departmentList.clear();
      await departmentModel!.read(departmentList, facultyId).whenComplete(() {
        streamController.add(5); // notify pop
        streamController.add(5); // notify pop
        streamController.add(2); // notify success
        setState();
        departmentNames.add(departmentList.last.departmentName!.toLowerCase());
      });
    });
    return true;
  }
}
