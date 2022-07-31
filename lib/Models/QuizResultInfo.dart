import 'package:firebase_database/firebase_database.dart';

import '../services/DataBaseHelper.dart';

class QuizResultInfo {
  String? startTime;
  String? endTime;
  int? questionNumber;
  int? score;
  QuizResultInfo({
    this.startTime,
    this.endTime,
    this.score,
    this.questionNumber,
  });

  QuizResultInfo.fromJson(Map<String, dynamic> json) {
    startTime = json['startTime'];
    endTime = json['endTime'];
    score = json['score'];
    questionNumber = json['questionNumber'];
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'startTime': startTime,
        'endTime': endTime,
        'score': score,
        'questionNumber': questionNumber,
      };
  DatabaseReference ref =
      FirebaseDatabase.instance.ref(DataBaseHelper.studentDbName);
  Future create(
      QuizResultInfo quizResultInfo, int lectureNoteId, String uid) async {
    try {
      await ref
          .child(uid)
          .child("SelfQuiz")
          .child(lectureNoteId.toString())
          .child("info")
          .child(quizResultInfo.startTime!.toString())
          .set(quizResultInfo.toJson());
    } catch (e) {
      print(e);
    }
  }

  Future<List<QuizResultInfo>> read(
      int lectureNoteId, String uid) async {
    List<QuizResultInfo> list = [];
    try {
      var result = await ref
          .child(uid)
          .child("SelfQuiz")
          .child(lectureNoteId.toString())
          .child("info")
          .once();
      if (result.snapshot.value == null) return list;
      try {
        List<dynamic> values = result.snapshot.value as List<dynamic>;
        values.forEach((values) {
          if (values != null) list.add(QuizResultInfo.fromJson(values));
        });
      } catch (e) {
        try {
          var values = result.snapshot.value as Map<String, dynamic>;
          values.forEach((key, value) {
            list.add(QuizResultInfo.fromJson(value));
          });
        } catch (d) {}
      }
    } catch (e) {
      print(e);
    }
    return list;
  }
}
