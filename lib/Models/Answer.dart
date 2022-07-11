class Answer {
  int? answerId;
  String? answer;
  String? quizId;
  Answer({this.answer, this.answerId, this.quizId});

  Answer.fromJson(Map<String, dynamic> json) {
    answerId = json['answerId'];
    answer = json['answer'];
    quizId = json['quizId'];
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'answerId': answerId,
    'answer': answer,
    'quizId': quizId,
  };
}
