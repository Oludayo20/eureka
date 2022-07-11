class QuizOptions {
  int? quizOptionId;
  String? quizOption;
  int? quizId;
  QuizOptions({this.quizOptionId, this.quizId, this.quizOption});

  QuizOptions.fromJson(Map<String, dynamic> json) {
    quizOptionId = json['quizOptionId'];
    quizOption = json['quizOption'];
    quizId = json['quizId'];
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'quizOptionId': quizOptionId,
    'quizOption': quizOption,
    'quizId': quizId,
  };
}
