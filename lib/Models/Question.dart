class Questions {
  int? questionId;
  String? question;
  int? quizId;
  Questions({this.questionId, this.quizId, this.question});

  Questions.fromJson(Map<String, dynamic> json) {
    questionId = json['questionId'];
    question = json['question'];
    quizId = json['quizId'];
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'questionId': questionId,
    'question': question,
    'quizId': quizId,
  };
}
