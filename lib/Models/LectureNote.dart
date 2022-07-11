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
}
