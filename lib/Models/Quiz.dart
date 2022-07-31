import 'package:firebase_database/firebase_database.dart';

import '../services/DataBaseHelper.dart';
import 'QuizOption.dart';

class Quiz {
  int? quizId;
  int? lectureNoteId;
  String? question;
  int? answer;
  QuizOptions? options;
  Quiz({this.quizId, this.lectureNoteId,this.answer, this.question, this.options});

  Quiz.fromJson(Map<String, dynamic> json) {
    quizId = json['quizId'];
    lectureNoteId = json['lectureNoteId'];
    question = json['question'];
    answer = json['answer'];
    try{
      var values = json['options'] as Map<String, dynamic>;
      options = QuizOptions.fromJson(values);
    }catch(ex)
    {
     print(ex);
    }
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'quizId': quizId,
    'lectureNoteId': lectureNoteId,
    'question': question,
    'answer': answer,
    'options': options!.toJson(),
  };
  Future read(List<Quiz> list, int id) async {
    DatabaseReference ref = FirebaseDatabase.instance.ref(DataBaseHelper.quizDbName);
    var x = await ref.child(id.toString()).once();
    if (x.snapshot.value == null) return;
    try {
      List<dynamic> values = x.snapshot.value as List<dynamic>;
      values.forEach((values) {
        if (values != null) list.add(Quiz.fromJson(values));
      });
    } catch (e) {
      try {
        var values = x.snapshot.value as Map<String, dynamic>;
        values.forEach((key, value) {
          list.add(Quiz.fromJson(value));
        });
      } catch (d) {}
    }
  }

  Future delete(int lectureNoteId, int id) async {
    DatabaseReference ref = FirebaseDatabase.instance.ref(DataBaseHelper.quizDbName);
    await ref.child(lectureNoteId.toString()).child(id.toString()).remove();
  }

  Future create(Quiz data) async {
    try {
      DatabaseReference ref = FirebaseDatabase.instance.ref(DataBaseHelper.quizDbName);
      await ref
          .child(data.lectureNoteId.toString())
          .limitToLast(1)
          .once()
          .then((value) async {
        int count = 1;
        if (value.snapshot.value == null) {
          data.quizId = 1;
          await ref
              .child(data.lectureNoteId.toString())
              .child(data.quizId.toString())
              .set(data.toJson());
        } else {
          try {
            var val = value.snapshot.value as Map<dynamic, dynamic>;

            val.forEach((key, value) {
              if (key != null) {
                try {
                  count = int.parse(key);
                } catch (e) {}
              }
            });
          } catch (u) {}
          data.quizId = 1 + count;
          await ref
              .child(data.lectureNoteId.toString())
              .child(data.quizId.toString())
              .set(data.toJson());
        }
      });
    } catch (e) {
      print(e);
    }
  }

  Future update(Quiz quiz) async {
    DatabaseReference ref = FirebaseDatabase.instance.ref(DataBaseHelper.quizDbName);
    await ref
        .child(quiz.lectureNoteId.toString())
        .child(quiz.quizId.toString())
        .set(quiz.toJson());
  }
}
