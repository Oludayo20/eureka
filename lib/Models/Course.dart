import 'dart:core';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

import '../services/DataBaseHelper.dart';

class Course {
  int? courseId;
  String? courseTitle;
  String? courseCode;
  int? semester;
  int? level;

  Course(
      {this.courseId,
      this.courseTitle,
      this.courseCode,
      this.level,
      this.semester});

  Course.fromJson(Map<String, dynamic> json) {
    courseId = json['courseId'];
    courseTitle = json['courseTitle'];
    courseCode = json['courseCode'];
    level = json['level'];
    semester = json['semester'];
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'courseId': courseId,
        'courseTitle': courseTitle,
        'courseCode': courseCode,
        'level': level,
        'semester': semester,
      };

  static DatabaseReference ref = FirebaseDatabase.instance.ref(DataBaseHelper.coursesNoteDbName);
  Future read(List<Course> list) async {
    var x = await ref.once().catchError((error) {
      Exception("Something went wrong: ${error.message}");
    });
    if (x.snapshot.value == null) return;
    try {
      List<dynamic> values = x.snapshot.value as List<dynamic>;
      values.forEach((values) {
        if (values != null) list.add(Course.fromJson(values));
      });
    } catch (e) {
      try {
        var values = x.snapshot.value as Map<String, dynamic>;
        values.forEach((key, value) {
          list.add(Course.fromJson(value));
        });
      } on FirebaseAuthException catch (e)  {
        print(e);
      }
    }
  }
  Future update(Course data) async {
    await ref
        .child(data.courseId.toString())
        .set(data.toJson());
  }
  Future readById(List<Course> list, int id) async {
    await ref
        .child(id.toString()).once().then((value){
          try{
            list.add(Course.fromJson(value.snapshot.value as Map<String, dynamic>));
          }catch(e){

          }
    });
  }
  static Future delete(int id) async {
    await ref.child(id.toString()).remove();
  }
  static Future<List<Course>> getCourse() async {
    List<Course> courseList = [];
    if (courseList.isEmpty) {
      await Course().read(courseList);
    }
    return courseList;
  }
  static Future create(Course data) async {
    try {
      await ref
          .limitToLast(1)
          .once()
          .then((value) async {
        int count = 1;
        if (value.snapshot.value == null) {
          data.courseId = 1;
          await ref
              .child(data.courseId.toString())
              .set(data.toJson());
        } else {
          try {
            var val = value.snapshot.value as Map<dynamic, dynamic>;

            val.forEach((key, value) {
              if (key != null) {
                try {
                  count = int.parse(key);
                } catch (e) {}
              }
            });
          } catch (u) {}
          data.courseId = count + 1;
          await ref
              .child(data.courseId.toString())
              .set(data.toJson());
        }
      });
    } catch (e) {
      print(e);
    }
  }
}
