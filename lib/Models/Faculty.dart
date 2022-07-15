import 'package:firebase_database/firebase_database.dart';

class FacultyModel {
  int? facultyId;
  String? facultyName;
  FacultyModel({this.facultyId, this.facultyName});

  FacultyModel.fromJson(Map<String, dynamic> json) {
    facultyId = json['facultyId'];
    facultyName = json['facultyName'];
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'facultyId': facultyId,
        'facultyName': facultyName,
      };
  Future read(List<FacultyModel> facultyList) async {
    DatabaseReference ref = FirebaseDatabase.instance.ref("Faculty");
    var x =await  ref.once();
    try{
      List<dynamic> values = x.snapshot.value as List<dynamic>;
      values.forEach((values) {
        if (values != null) facultyList.add(FacultyModel.fromJson(values));
      });
    }catch(e){
      try{
        var values = x.snapshot.value as Map<String, dynamic>;
        values.forEach((key, value) {
          facultyList.add(FacultyModel.fromJson(value));
        });
      }catch(d){

      }

    }

  }
  Future update(FacultyModel faculty) async {
    DatabaseReference ref = FirebaseDatabase.instance.ref("Faculty");
    await ref.child(faculty.facultyId.toString()).set(faculty.toJson());
  }

  Future delete(int id) async {
    DatabaseReference ref = FirebaseDatabase.instance.ref("Faculty");
    await ref.child(id.toString()).remove();
  }

  Future create(FacultyModel faculty) async {
    try {
      DatabaseReference ref = FirebaseDatabase.instance.ref("Faculty");
      await ref.limitToLast(1).once().then((value) async {
        int count = 1;
        if(value.snapshot.value == null){
          faculty.facultyId = 1;
          await ref.child((count + 1).toString()).set(faculty.toJson());
        }else{
          try{
            Map<dynamic, dynamic> val =
            value.snapshot.value as Map<dynamic, dynamic>;
            val.forEach((key, values) {
              try {
                var x = key as String;
                count = int.parse(x);
              } catch (e) {}
            });
          }catch(ex){

          }
          faculty.facultyId = count + 1;
          await ref.child((count + 1).toString()).set(faculty.toJson());
        }

      });
    } catch (e) {
      print(e);
    }
  }
}
