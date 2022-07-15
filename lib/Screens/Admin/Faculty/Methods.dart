import 'dart:async';

import 'package:school_management/Screens/Home_Page.dart';

import '../../../Models/Faculty.dart';
import '../../../Util/Notify.dart';
import 'package:flutter/material.dart';

class FacultyMethods {
  StreamController<int> facultyStreamController = StreamController<int>();
  bool showAddScreen = false;
  List<FacultyModel> facultyList = [];
  FacultyModel? facultyModel;
  Set<String> facultyNames = {};
  Future initState() async {
    // TODO: implement initState
    //facultyStreamController = StreamController();
    showAddScreen = false;
    facultyList = [];
    facultyModel = FacultyModel();
    await facultyModel!.read(facultyList).whenComplete(() {
      facultyList.forEach((element) {
        facultyNames.add(element.facultyName!.toLowerCase());
      });
    });
  }

  void setState() => facultyStreamController.add(0);
  bool _checkIfFacultyExists(String facultyName) {
    return facultyNames.contains(facultyName.toLowerCase());
  }

  Future facultyDeleteOnApprove(int id) async {
    facultyStreamController.add(3);
    await facultyModel!.delete(id).whenComplete(() async {
      facultyList = [];
      await facultyModel!.read(facultyList).whenComplete(() {
        facultyStreamController.add(2);
        setState();
      });
    });
  }

  Future facultyCreateOnApprove(
      String facultyName, BuildContext context) async {
    if (_checkIfFacultyExists(facultyName)) {
      facultyStreamController.add(1);
      return;
    }
    facultyStreamController.add(3);
    await facultyModel!
        .create(FacultyModel(facultyName: facultyName))
        .whenComplete(() async {
      facultyList = [];
      await facultyModel!.read(facultyList).whenComplete(() {
        facultyStreamController.add(2);
      });
    });
  }

  Future facultyEditOnApprove(String facultyName, BuildContext context) async {
    if (_checkIfFacultyExists(facultyName)) {
      facultyStreamController.add(1);
      return;
    }
    facultyStreamController.add(3);

    await facultyModel!
        .update(FacultyModel(facultyName: facultyName))
        .whenComplete(() async {
      facultyList = [];
      await facultyModel!.read(facultyList).whenComplete(() {
        facultyStreamController.add(2);
        facultyStreamController.add(0);
      });
    });
  }
}
