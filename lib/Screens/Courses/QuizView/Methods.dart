import 'dart:async';

import 'QuestionView.dart';

class QuizMethods{
  final StreamController<int> streamController;
  final Map<int, QuestionView> questionMap;
  QuizMethods({required this.questionMap, required this.streamController}){
    streamController.stream.listen((event) {
      changeQuestion(event);
    });
  }
  int currentQuestion = 1;
  void changeQuestion(int number) {
    currentQuestion = number;
  }

  void nextQuestion(){
    if(currentQuestion % 2 == 0){
      if(questionMap.containsKey(currentQuestion+1)){
        streamController.add(currentQuestion+1);
      }

    }else{
      if(questionMap.containsKey(currentQuestion+2)){
        streamController.add(currentQuestion+2);
      }
    }
  }
  void previousQuestion(){
    if(currentQuestion % 2 == 0){
      if(questionMap.containsKey(currentQuestion-2)){
        streamController.add(currentQuestion-2);
      }

    }else{
      if(questionMap.containsKey(currentQuestion-1)){
        streamController.add(currentQuestion-1);
      }
    }
  }
}