import 'package:flutter/material.dart';
import 'package:school_management/Models/LectureNote.dart';
import '../../../../Models/QuizResultInfo.dart';
import '../../../../services/authentication_helper.dart';
import '../Exams/Exam_Rseult.dart';
import 'NoteView.dart';

class NoteCard extends StatelessWidget {
  NoteCard({
    Key? key,
    this.lectureNote, required this.num,
  }) : super(key: key);
  final LectureNote? lectureNote;
  final int num;
  @override
  Widget build(BuildContext context) {
    void onDisplayNoteClick(BuildContext context) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) =>
              NoteView(lectureNote: lectureNote!),
        ),
      );
    }

    void onSelfQuizClick(BuildContext context) {
      var uid = AuthenticationHelper().getUser()!.uid!;
      print(uid);
      QuizResultInfo().read(lectureNote!.lectureNoteId!, uid).then((value) {
        Navigator.pushNamed(
          context,
          ExamResult.routeName,
          arguments: ExamResultArguments(
              lectureNote: lectureNote!, quizResultInfo: value),
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
                    color: Colors.redAccent,
                  ),
                  height: height * 0.1,
                ),
                SizedBox(
                  width: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 100,
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text(
                        "${lectureNote!.title}",
                        overflow: TextOverflow.fade,
                        maxLines: 1,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () => onDisplayNoteClick(context),
                      child: Text(
                        "View",
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
                    "Note $num",
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: TextButton(
                      child: Text(
                        "Self Quiz",
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      onPressed: () => onSelfQuizClick(context),
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      "",
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
