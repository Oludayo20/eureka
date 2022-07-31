import 'dart:async';
import '../../../Models/Faculty.dart';
import 'package:flutter/material.dart';

class FacultyMethods {
  StreamController<int> facultyStreamController = StreamController<int>();
  bool showAddScreen = false;
  List<FacultyModel> facultyList = [];
  FacultyModel? facultyModel;
  Set<String> facultyNames = {};
  Future initState() async {
    showAddScreen = false;
    facultyList = [];
    facultyModel = FacultyModel();
    await facultyModel!.read(facultyList).whenComplete(() {
      fillCheckList();
    });
  }

  void fillCheckList() {
    facultyNames.clear();
    facultyList.forEach((element) {
      facultyNames.add(element.facultyName!.toLowerCase());
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
        fillCheckList();
      });
    });
  }

  Future<bool> facultyCreateOnApprove(
      String facultyName, BuildContext context) async {
    if (_checkIfFacultyExists(facultyName)) {
      facultyStreamController.add(1);
      return false;
    }
    facultyStreamController.add(3);
    await facultyModel!
        .create(FacultyModel(facultyName: facultyName))
        .whenComplete(() async {
      facultyList = [];
      await facultyModel!.read(facultyList).whenComplete(() {
        facultyStreamController.add(5); // notify pop
        facultyStreamController.add(2); // notify success
        fillCheckList();
      });
    });
    return true;
  }

  Future<bool> facultyEditOnApprove(
      FacultyModel facultyModel, BuildContext context) async {
    if (_checkIfFacultyExists(facultyModel.facultyName!)) {
      facultyStreamController.add(1);
      return false;
    }
    facultyStreamController.add(3);
    await facultyModel.update(facultyModel).whenComplete(() async {
      facultyList = [];
      await facultyModel.read(facultyList).whenComplete(() {
        facultyStreamController.add(5); // notify pop
        facultyStreamController.add(5); // notify pop
        facultyStreamController.add(2); // notify success
        setState();
        facultyNames.add(facultyList.last.facultyName!.toLowerCase());
      });
    });
    return true;
  }
}
