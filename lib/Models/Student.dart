import 'package:firebase_database/firebase_database.dart';

import '../services/DataBaseHelper.dart';

class Student {
  int? programId;
  String? fullName;
  bool? isActivated;
  int? level;
  int? semester;
  Student(
      {this.programId,
      this.isActivated,
      this.level,
      this.semester,
      this.fullName});

  Student.fromJson(Map<String, dynamic> json) {
    programId = json['programId'];
    isActivated = json['isActivated'];
    level = json['level'];
    semester = json['semester'];
    fullName = json['fullName'];
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'programId': programId,
        'isActivated': isActivated,
        'level': level,
        'semester': semester,
        'fullName': fullName,
      };
  DatabaseReference ref =
  FirebaseDatabase.instance.ref(DataBaseHelper.studentDbName);
  Future create(Student student, String uid) async {
    try {
      await ref.child(uid).set(student.toJson());
    } catch (e) {
      print(e);
    }
  }
  Future<Student?> read(String uid) async {
    var x = await ref.child(uid).once();
    Student? student;
    if (x.snapshot.value == null) return null;
    try {
      var values = x.snapshot.value as Map<String, dynamic>;
      student = Student.fromJson(values);
    } catch (e) {
      print(e);
    }
    return student;
  }
  Future update(Student student, String uid) async {
    await ref.child(uid).set(student.toJson());
  }
  Future delete(String uid) async {
    await ref.child(uid).remove();
  }
}
