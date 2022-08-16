import 'package:flutter/material.dart';
import 'package:school_management/Models/LectureNote.dart';

import '../../../../Models/Quiz.dart';
import '../../../../Models/QuizResult.dart';
import '../../../../Util/Notify.dart';
import '../../../../services/authentication_helper.dart';
import '../../../Courses/QuizView/Quiz.dart';

class SubjectCard extends StatelessWidget {
  final String? subjectname;
  final String? date;
  final String? timeTaken;
  final String? startTime;
  final String? grade;
  final String? mark;
  final String? total;
  final LectureNote lectureNote;
  SubjectCard(
      {Key? key,
      this.subjectname,
      this.date,
      this.timeTaken,
      this.grade,
      this.mark,
      required this.lectureNote,
      this.startTime, this.total})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    Future<void> reviewQuiz() async {
      Notify.loading(context, "");
      var uid = AuthenticationHelper().getUser()!.uid!;
      await QuizResult()
          .read(lectureNote.lectureNoteId!, uid, startTime!)
          .then((value) async {
        List<Quiz> quizList =
            await Quiz.read(lectureNote.courseId!, lectureNote.lectureNoteId!);
        Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => QuizView(
                quizViewArgument: QuizViewArgument(
              isReviewing: true,
              selectedOption: value,
              lectureNote: lectureNote,
              title: "",
              quizList: quizList,
            )),
          ),
        );
      });
    }

    final double height = MediaQuery.of(context).size.height;
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black38,
              offset: Offset(0, 2),
              spreadRadius: 1,
            ),
          ]),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 13,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  width: 5,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.amberAccent,
                  ),
                  height: height * 0.1,
                ),
                SizedBox(
                  width: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text(
                        "$subjectname",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () => reviewQuiz(),
                      child: Text(
                        "Review",
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    "$date",
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    "Time T: $timeTaken",
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Marks:$mark/$total",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      "Grade:$grade",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
