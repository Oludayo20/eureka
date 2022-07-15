import 'package:firebase_database/firebase_database.dart';
class ProgramCourse {
  int? courseProgramId;
  int? programId;
  int? courseId;
  ProgramCourse({this.courseId, this.courseProgramId, this.programId});

  ProgramCourse.fromJson(Map<String, dynamic> json) {
    courseProgramId = json['courseProgramId'];
    programId = json['programId'];
    courseId = json['courseId'];
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'courseProgramId': courseProgramId,
    'programId': programId,
    'courseId': courseId,
  };
  Future delete(int id, int programId) async {
    DatabaseReference ref = FirebaseDatabase.instance.ref("ProgramCourse");
    await ref.child(programId.toString()).child(id.toString()).remove();
  }
  Future read(List<ProgramCourse> list, int facultyId) async {

    DatabaseReference ref = FirebaseDatabase.instance.ref("ProgramCourse");
    var x = await ref.child(facultyId.toString()).once();
    if (x.snapshot.value == null) return;
    try {
      List<dynamic> values = x.snapshot.value as List<dynamic>;
      values.forEach((values) {
        if (values != null) list.add(ProgramCourse.fromJson(values));
      });
    } catch (e) {
      try {
        var values = x.snapshot.value as Map<String, dynamic>;
        values.forEach((key, value) {
          list.add(ProgramCourse.fromJson(value));
        });
      } catch (d) {}
    }

  }

  Future create(ProgramCourse data) async {
    try {
      DatabaseReference ref = FirebaseDatabase.instance.ref("ProgramCourse");
      await ref
          .child(data.programId.toString())
          .limitToLast(1)
          .once()
          .then((value) async {
        int count = 1;
        if (value.snapshot.value == null) {
          data.courseProgramId = 1;
          await ref
              .child(data.programId.toString())
              .child(data.courseProgramId.toString())
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
          data.courseProgramId = count+1;
          await ref
              .child(data.programId.toString())
              .child(data.courseProgramId.toString())
              .set(data.toJson());
        }
      });
    } catch (e) {
      print(e);
    }
  }
}
