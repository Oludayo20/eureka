import 'package:firebase_database/firebase_database.dart';

class Department {
  int? departmentId;
  String? departmentName;
  int? facultyId;
  Department({this.departmentId, this.departmentName, this.facultyId});

  Department.fromJson(Map<String, dynamic> json) {
    departmentId = json['departmentId'];
    departmentName = json['departmentName'];
    facultyId = json['facultyId'];
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'departmentId': departmentId,
        'departmentName': departmentName,
        'facultyId': facultyId,
      };

  Future read(List<Department> deptList, int facultyId) async {
    DatabaseReference ref = FirebaseDatabase.instance.ref("Department");
    var x = await ref.child(facultyId.toString()).once();
    //orderByChild("facultyId").equalTo(facultyId.toString())
    if (x.snapshot.value == null) return;
    try {
      List<dynamic> values = x.snapshot.value as List<dynamic>;
      values.forEach((values) {
        if (values != null) deptList.add(Department.fromJson(values));
      });
    } catch (e) {
      try {
        var values = x.snapshot.value as Map<String, dynamic>;
        values.forEach((key, value) {
          deptList.add(Department.fromJson(value));
        });
      } catch (d) {}
    }
  }

  Future update(Department department) async {
    DatabaseReference ref = FirebaseDatabase.instance.ref("Department");
    await ref
        .child(facultyId.toString())
        .child(department.departmentId.toString())
        .set(department.toJson());
  }

  Future delete(int facultyId, int id) async {
    DatabaseReference ref = FirebaseDatabase.instance.ref("Department");
    await ref.child(facultyId.toString()).child(id.toString()).remove();
  }

  Future create(Department department) async {
    try {
      DatabaseReference ref = FirebaseDatabase.instance.ref("Department");
      await ref
          .child(department.facultyId.toString())
          .limitToLast(1)
          .once()
          .then((value) async {
        int count = 1;
        if (value.snapshot.value == null) {
          department.departmentId = 1;
          await ref
              .child(department.facultyId.toString())
              .child(department.departmentId.toString())
              .set(department.toJson());
        } else {
          try {
            var val = value.snapshot.value as Map<dynamic, dynamic>;

            val.forEach((key, value) {
              if (key != null) {
                try {
                  var x = key as String;
                  count = int.parse(key);
                } catch (e) {}
              }
            });
          } catch (u) {}
          department.departmentId = count + 1;
          await ref
              .child(department.facultyId.toString())
              .child(department.departmentId.toString())
              .set(department.toJson());
        }
      });
    } catch (e) {
      print(e);
    }
  }
}
