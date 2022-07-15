class Student {
  int? studentId;
  int? programId;
  String? fullName;
  bool? isActivated;
  int? level;
  int? semester;
  Student(
      {this.studentId,
      this.programId,
      this.isActivated,
      this.level,
      this.semester,
      this.fullName});

  Student.fromJson(Map<String, dynamic> json) {
    studentId = json['studentId'];
    programId = json['programId'];
    isActivated = json['isActivated'];
    level = json['level'];
    semester = json['semester'];
    fullName = json['fullName'];
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'studentId': studentId,
        'programId': programId,
        'isActivated': isActivated,
        'level': level,
        'semester': semester,
        'fullName': fullName,
      };
}
