import '../../../Models/LectureNote.dart';

class EachCourseMethod {
  List<LectureNote> list = [];
  Future getLectureNote(int courseId) async {
    list = await LectureNote.getLectureNote(list);
  }
  void passOnlyActiveLectureNote(){
    List<LectureNote> lectureNoteList = [];
    list.forEach((element) {
      if(element.isActive!){
        lectureNoteList.add(element);
      }
    });
    list = lectureNoteList;
  }
}
