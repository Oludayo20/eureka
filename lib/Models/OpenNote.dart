

import 'package:firebase_database/firebase_database.dart';

import '../services/DataBaseHelper.dart';

class OpenNote {
  int? openLectureNote;
  OpenNote({this.openLectureNote});

  OpenNote.fromJson(Map<String, dynamic> json) {
    openLectureNote = json['openLectureNote'];
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'selectedOption': openLectureNote,
  };
  static DatabaseReference ref =
  FirebaseDatabase.instance.ref(DataBaseHelper.studentDbName);
  static Future create(String uid, int courseId, int lectureNoteId) async {
    try {
      await ref
          .child(uid)
          .child("OpenNote")
          .child(courseId.toString()).set(lectureNoteId.toString());
    } catch (e) {
      print(e);
    }
  }

  Future<Set<int>> read(
      int courseId, String uid) async {
    Set<int> resultOut = {};
    try {
      var result = await ref
          .child(uid)
          .child("OpenNote")
          .child(courseId.toString())
          .once();
      if (result.snapshot.value == null) return resultOut;
      try {
        var values = result.snapshot.value as List<dynamic>;

        for(var i = 0 ; i<values.length; i++){
          if (values[i] != null){
            var x = values[i] as int;
            resultOut.add(x);
          }
        }
      } catch (e) {
      }
    } catch (e) {
      print(e);
    }
    return resultOut;
  }

}
