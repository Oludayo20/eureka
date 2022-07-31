import 'package:firebase_database/firebase_database.dart';

import '../services/DataBaseHelper.dart';
import 'QuizResultInfo.dart';

class QuizResult {
  QuizResultInfo? quizResultInfo;
  Map<int, int>? selectedOption;
  QuizResult({this.quizResultInfo, this.selectedOption});

  QuizResult.fromJson(Map<String, dynamic> json) {
    selectedOption = json['selectedOption'];
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'selectedOption': selectedOption,
      };
  DatabaseReference ref =
      FirebaseDatabase.instance.ref(DataBaseHelper.studentDbName);
  Future create(QuizResult quizResult, int lectureNoteId, String uid) async {
    try {
      print(quizResult.quizResultInfo!.startTime!);
      await QuizResultInfo().create(quizResult.quizResultInfo!, lectureNoteId, uid);
      await ref
          .child(uid)
          .child("SelfQuiz")
          .child(lectureNoteId.toString())
          .child("result")
          .child(quizResult.quizResultInfo!.startTime!)
          .set(quizResult.toJson());
    } catch (e) {
      print(e);
    }
  }

  Future<Map<int, int>> read(
      int lectureNoteId, String uid, String startTime) async {
    Map<int, int> resultOut = {};
    try {
      var result = await ref
          .child(uid)
          .child("SelfQuiz")
          .child(lectureNoteId.toString())
          .child("result")
          .child(startTime)
          .child("selectedOption")
          .once();
      if (result.snapshot.value == null) return resultOut;
      try {
        var values = result.snapshot.value as List<dynamic>;

        for(var i = 0 ; i<values.length; i++){
          if (values[i] != null){
            var x = values[i] as int;
            resultOut.addAll({i: x});
          }
        }
      } catch (e) {
      }
    } catch (e) {
      print(e);
    }
    return resultOut;
  }

}
