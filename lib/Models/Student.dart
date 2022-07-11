class Student {
  int? studentId;
  String? phone;
  String? profilePicture;
  int? programId;
  String? email;
  bool? isActivated;
  int? level;
  int? semester;
  Student(
      {this.studentId,
      this.phone,
      this.profilePicture,
      this.programId,
      this.email,
      this.isActivated,
      this.level,
      this.semester});

  Student.fromJson(Map<String, dynamic> json) {
    studentId = json['studentId'];
    phone = json['phone'];
    profilePicture = json['profilePicture'];
    programId = json['programId'];
    email = json['email'];
    isActivated = json['isActivated'];
    level = json['level'];
    semester = json['semester'];
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'studentId': studentId,
        'phone': phone,
        'profilePicture': profilePicture,
        'programId': programId,
        'email': email,
        'isActivated': isActivated,
        'level': level,
        'semester': semester,
      };
}
