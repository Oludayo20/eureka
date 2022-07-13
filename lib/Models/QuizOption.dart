class QuizOptions {
  String? quizOptionA;
  String? quizOptionB;
  String? quizOptionC;
  String? quizOptionD;
  String? quizOptionE;
  QuizOptions({ this.quizOptionA, this.quizOptionB, this.quizOptionC, this.quizOptionD, this.quizOptionE});

  QuizOptions.fromJson(Map<String, dynamic> json) {
    quizOptionA = json['quizOptionA'];
    quizOptionB = json['quizOptionB'];
    quizOptionC = json['quizOptionC'];
    quizOptionD = json['quizOptionD'];
    quizOptionE = json['quizOptionE'];
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'quizOptionA': quizOptionA,
    'quizOptionB': quizOptionB,
    'quizOptionC': quizOptionC,
    'quizOptionD': quizOptionD,
    'quizOptionE': quizOptionE,
  };
}
