class CourseController {
  int? courseControllerId;
  String? email;
  int? courseId;
  CourseController({this.courseControllerId, this.email, this.courseId});

  CourseController.fromJson(Map<String, dynamic> json) {
    courseControllerId = json['courseControllerId'];
    email = json['email'];
    courseId = json['courseId'];
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'courseControllerId': courseControllerId,
        'email': email,
        'courseId': courseId,
      };
}
