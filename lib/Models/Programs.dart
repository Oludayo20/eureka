import 'package:firebase_database/firebase_database.dart';

class Programs {
  int? programId;
  String? programName;
  int? departmentId;
  Programs({this.programName, this.departmentId, this.programId});

  Programs.fromJson(Map<String, dynamic> json) {
    programId = json['programId'];
    programName = json['programName'];
    departmentId = json['departmentId'];
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'programId': programId,
    'programName': programName,
    'departmentId': departmentId,
  };

  Future read(List<Programs> list, int id) async {
    DatabaseReference ref = FirebaseDatabase.instance.ref("Programs");
    var x = await ref.child(id.toString()).once();
    if (x.snapshot.value == null) return;
    try {
      List<dynamic> values = x.snapshot.value as List<dynamic>;
      values.forEach((values) {
        if (values != null) list.add(Programs.fromJson(values));
      });
    } catch (e) {
      try {
        var values = x.snapshot.value as Map<String, dynamic>;
        values.forEach((key, value) {
          list.add(Programs.fromJson(value));
        });
      } catch (d) {}
    }
  }

  Future update(Programs data) async {
    DatabaseReference ref = FirebaseDatabase.instance.ref("Programs");
    await ref
        .child(data.departmentId.toString())
        .child(data.programId.toString())
        .set(data.toJson());
  }

  Future delete(int deptId, int id) async {
    DatabaseReference ref = FirebaseDatabase.instance.ref("Programs");
    await ref.child(deptId.toString()).child(id.toString()).remove();
  }

  Future create(Programs data) async {
    try {
      DatabaseReference ref = FirebaseDatabase.instance.ref("Programs");
      await ref
          .child(data.departmentId.toString())
          .limitToLast(1)
          .once()
          .then((value) async {
        int count = 1;
        if (value.snapshot.value == null) {
          data.programId = 1;
          await ref
              .child(data.departmentId.toString())
              .child(data.programId.toString())
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
          data.programId = count + 1;
          await ref
              .child(data.departmentId.toString())
              .child(data.programId.toString())
              .set(data.toJson());
        }
      });
    } catch (e) {
      print(e);
    }
  }
}