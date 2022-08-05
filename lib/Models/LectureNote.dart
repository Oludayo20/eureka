import 'package:firebase_database/firebase_database.dart';

import '../services/DataBaseHelper.dart';

class LectureNote {
  int? lectureNoteId;
  String? title;
  String? link;
  String? pdfName;
  int? courseId;
  String? noteWriteUp;
  bool? isActive;
  LectureNote(
      {this.lectureNoteId,
      this.title,
      this.link,
      this.courseId,
      this.noteWriteUp,
      this.pdfName,
      this.isActive});
  static DatabaseReference ref =
      FirebaseDatabase.instance.ref(DataBaseHelper.lectureNoteDbName);
  LectureNote.fromJson(Map<String, dynamic> json) {
    lectureNoteId = json['lectureNoteId'];
    title = json['title'];
    link = json['link'];
    courseId = json['courseId'];
    noteWriteUp = json['noteWriteUp'];
    pdfName = json['pdfName'];
    isActive = json['isActive'];
  }
  Map<String, dynamic> toJson() => <String, dynamic>{
        'lectureNoteId': lectureNoteId,
        'title': title,
        'link': link,
        'courseId': courseId,
        'noteWriteUp': noteWriteUp,
        'pdfName': pdfName,
        'isActive': isActive,
      };
  static Future read(List<LectureNote> list, int courseId) async {
    var x = await ref.child(courseId.toString()).once();
    if (x.snapshot.value == null) return;
    try {
      List<dynamic> values = x.snapshot.value as List<dynamic>;
      values.forEach((values) {
        if (values != null) list.add(LectureNote.fromJson(values));
      });
    } catch (e) {
      try {
        var values = x.snapshot.value as Map<String, dynamic>;
        values.forEach((key, value) {
          list.add(LectureNote.fromJson(value));
        });
      } catch (d) {}
    }
  }
  static Future<List<LectureNote>> getLectureNote(courseId) async {
    List<LectureNote> list = [];
    await read(list, courseId);
    return list;
  }
  Future delete(int courseId, int id) async {
    await ref.child(courseId.toString()).child(id.toString()).remove();
  }

  Future update(LectureNote data) async {
    await ref
        .child(data.courseId.toString())
        .child(data.lectureNoteId.toString())
        .set(data.toJson());
  }

  Future create(LectureNote data) async {
    try {
      await ref
          .child(data.courseId.toString())
          .limitToLast(1)
          .once()
          .then((value) async {
        int count = 1;
        if (value.snapshot.value == null) {
          data.lectureNoteId = 1;
          await ref
              .child(data.courseId.toString())
              .child(data.lectureNoteId.toString())
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
          data.lectureNoteId = count + 1;
          await ref
              .child(data.courseId.toString())
              .child(data.lectureNoteId.toString())
              .set(data.toJson());
        }
      });
    } catch (e) {
      print(e);
    }
  }
}
