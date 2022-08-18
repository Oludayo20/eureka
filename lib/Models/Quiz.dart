import 'package:firebase_database/firebase_database.dart';

import '../services/DataBaseHelper.dart';
import 'QuizOption.dart';

class Quiz {
  int? quizId;
  int? lectureNoteId;
  int? courseId;
  String? question;
  int? answer;
  QuizOptions? options;
  Quiz(
      {this.quizId,
      this.courseId,
      this.lectureNoteId,
      this.answer,
      this.question,
      this.options});

  Quiz.fromJson(Map<String, dynamic> json) {
    quizId = json['quizId'];
    lectureNoteId = json['lectureNoteId'];
    question = json['question'];
    answer = json['answer'];
    courseId = json['courseId'];
    try {
      var values = json['options'] as Map<String, dynamic>;
      options = QuizOptions.fromJson(values);
    } catch (ex) {
      print(ex);
    }
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'quizId': quizId,
        'lectureNoteId': lectureNoteId,
        'question': question,
        'answer': answer,
        'courseId': courseId,
        'options': options!.toJson(),
      };
  static DatabaseReference ref =
  FirebaseDatabase.instance.ref(DataBaseHelper.quizDbName);

  static Future<List<Quiz>> read(int courseId, int lectureNoteId) async {
    List<Quiz> quizList = [];
    var x = await ref.child(courseId.toString()).child(lectureNoteId.toString()).once().catchError((error) {
      Exception("Something went wrong: ${error.message}");
    });
    if (x.snapshot.value == null) return quizList;
    try {
      List<dynamic> values = x.snapshot.value as List<dynamic>;
      values.forEach((values) {
        if (values != null) quizList.add(Quiz.fromJson(values));
      });
    } catch (e) {
      try {
        var values = x.snapshot.value as Map<String, dynamic>;
        values.forEach((key, value) {
          quizList.add(Quiz.fromJson(value));
        });
      } catch (d) {}
    }
    return quizList;
  }

  static Future delete(int courseId, int lectureNoteId, int id) async {
    await ref
        .child(courseId.toString())
        .child(lectureNoteId.toString())
        .child(id.toString())
        .remove();
  }

  static Future create(Quiz quiz) async {
    try {
      await ref
          .child(quiz.courseId.toString())
          .child(quiz.lectureNoteId.toString())
          .child(quiz.quizId.toString())
          .set(quiz.toJson());
    } catch (e) {
      print(e);
    }
  }

  static Future update(Quiz quiz) async {
    await ref
        .child(quiz.courseId.toString())
        .child(quiz.lectureNoteId.toString())
        .child(quiz.quizId.toString())
        .set(quiz.toJson());
  }
}
