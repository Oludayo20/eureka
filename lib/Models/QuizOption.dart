class QuizOptions {
  int? quizOptionId;
  String? quizOptionA;
  String? quizOptionB;
  String? quizOptionC;
  String? quizOptionD;
  String? quizOptionE;
  QuizOptions({this.quizOptionId, this.quizOptionA, this.quizOptionB, this.quizOptionC, this.quizOptionD, this.quizOptionE});

  QuizOptions.fromJson(Map<String, dynamic> json) {
    quizOptionId = json['quizOptionId'];
    quizOptionA = json['quizOptionA'];
    quizOptionB = json['quizOptionB'];
    quizOptionC = json['quizOptionC'];
    quizOptionD = json['quizOptionD'];
    quizOptionE = json['quizOptionE'];
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'quizOptionId': quizOptionId,
    'quizOptionA': quizOptionA,
    'quizOptionB': quizOptionB,
    'quizOptionC': quizOptionC,
    'quizOptionD': quizOptionD,
    'quizOptionE': quizOptionE,
  };
}
