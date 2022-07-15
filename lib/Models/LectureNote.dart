import 'package:firebase_database/firebase_database.dart';

class LectureNote {
  int? lectureNoteId;
  String? title;
  String? note;
  int? courseId;
  LectureNote({this.lectureNoteId, this.title, this.note, this.courseId});

  LectureNote.fromJson(Map<String, dynamic> json) {
    lectureNoteId = json['lectureNoteId'];
    title = json['title'];
    note = json['note'];
    courseId = json['courseId'];
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'lectureNoteId': lectureNoteId,
    'title': title,
    'note': note,
    'courseId': courseId,
  };

  Future read(List<LectureNote> list, int courseId) async {
    DatabaseReference ref = FirebaseDatabase.instance.ref("LectureNote");
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

  Future delete(int courseId, int id) async {
    DatabaseReference ref = FirebaseDatabase.instance.ref("LectureNote");
    await ref.child(courseId.toString()).child(id.toString()).remove();
  }

  Future update(LectureNote data) async {
    DatabaseReference ref = FirebaseDatabase.instance.ref("LectureNote");
    await ref
        .child(data.courseId.toString())
        .child(data.lectureNoteId.toString())
        .set(data.toJson());
  }


  Future create(LectureNote data) async {
    try {
      DatabaseReference ref = FirebaseDatabase.instance.ref("LectureNote");
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
