import 'package:flutter/material.dart';
import 'package:school_management/Models/LectureNote.dart';
import '../../../../Models/QuizResultInfo.dart';
import '../../../../Util/screen_layout.dart';
import '../../../../Widgets/AppBar.dart';
import '../../../../Widgets/MainDrawer.dart';
import '../../../../Authentication/authentication_helper.dart';
import '../../../../constants/const.enum.pagesName.dart';
import '../../../../routes/routes_to_name.dart';
import '../DisplayNote.dart';
import '../Exams/Exam_Rseult.dart';

class NoteView extends StatelessWidget {
  const NoteView({Key? key, required this.lectureNote}) : super(key: key);
  final LectureNote lectureNote;
  @override
  Widget build(BuildContext context) {
    void onSelfQuizClick() {
      var uid = AuthenticationHelper.getUser()!.uid!;
      QuizResultInfo().read(lectureNote.lectureNoteId!, uid).then((value) {
        Navigator.pushNamed(
          context,
          GenerateRootNames.generateRouteName(PageName.viewPastQuizAndTakeQuiz),
          arguments: ExamResultArguments(
              lectureNote:lectureNote, quizResultInfo: value),
        );
      });
    }
    Layout layout = Layout(size: MediaQuery.of(context).size);

    final GlobalKey<ScaffoldState> _scaffoldKey =
        new GlobalKey<ScaffoldState>();
    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        elevation: 0,
        child: MainDrawer(),
      ),
      appBar: CommonAppBar(
        menuenabled: true,
        notificationenabled: false,
        ontap: () {
          _scaffoldKey.currentState!.openDrawer();
        },
        title: "Student Dashboard",
      ),
      bottomSheet: Padding(
        padding: EdgeInsets.all(10),
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    "Back",
                    style: TextStyle(fontSize: 20),
                  )),
              lectureNote.link! != "not available"
                  ? TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) => DisplayNote(
                              link: lectureNote.link!,
                            ),
                          ),
                        );
                      },
                      child: Text(
                        "View PDF",
                        style: TextStyle(fontSize: 20),
                      ))
                  : Text(
                      "No PDF available",
                      style: TextStyle(fontSize: 20),
                    ),
              TextButton(
                  onPressed: () => onSelfQuizClick(),
                  child: Text("SelfQuiz", style: TextStyle(fontSize: 20))),
            ],
          ),
        ),
      ),
      body:Container(
          padding: EdgeInsets.only(left: 20,right: 20),
          child: ListView(
            children: [
              SizedBox(height: layout.height * 0.02,),
              Text(lectureNote.noteWriteUp!,style: TextStyle(fontSize: 17),),
              SizedBox(height: layout.height * 0.3,),
            ],
          ))
    );
  }
}
