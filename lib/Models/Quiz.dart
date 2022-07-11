class Quiz {
  int? quizId;
  String? lectureNoteId;
  Quiz({this.quizId, this.lectureNoteId});

  Quiz.fromJson(Map<String, dynamic> json) {
    quizId = json['quizId'];
    lectureNoteId = json['lectureNoteId'];
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'quizId': quizId,
    'lectureNoteId': lectureNoteId,
  };
}
