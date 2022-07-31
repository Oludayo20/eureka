import '../../../Models/Course.dart';
import '../../../Models/LectureNote.dart';

class EachCourseMethod {
  List<LectureNote> list = [];
  Future getLectureNote(int courseId) async {
    await LectureNote().read(list, courseId);
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
