class Grade {
  int? gradeId;
  String? studentId;
  int? lectureNoteId;
  int? fullScore;
  int? score;
  String? typeOfQuiz;
  Grade(
      {this.gradeId,
      this.studentId,
      this.lectureNoteId,
      this.fullScore,
      this.score,
      this.typeOfQuiz});

  Grade.fromJson(Map<String, dynamic> json) {
    gradeId = json['gradeId'];
    studentId = json['studentId'];
    lectureNoteId = json['lectureNoteId'];
    fullScore = json['fullScore'];
    score = json['score'];
    typeOfQuiz = json['typeOfQuiz'];
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'gradeId': gradeId,
        'studentId': studentId,
        'lectureNoteId': lectureNoteId,
        'fullScore': fullScore,
        'score': score,
        'typeOfQuiz': typeOfQuiz,
      };
}
