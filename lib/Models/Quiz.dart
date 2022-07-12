import 'QuizOption.dart';

class Quiz {
  int? quizId;
  String? lectureNoteId;
  String? question;
  String? answer;
  QuizOptions? options;
  Quiz({this.quizId, this.lectureNoteId,this.answer, this.question, this.options});

  Quiz.fromJson(Map<String, dynamic> json) {
    quizId = json['quizId'];
    lectureNoteId = json['lectureNoteId'];
    question = json['question'];
    answer = json['answer'];
    options = QuizOptions.fromJson(json['question']);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'quizId': quizId,
    'lectureNoteId': lectureNoteId,
    'question': question,
    'answer': answer,
    'options': options!.toJson(),
  };
}
