import 'package:flutter/material.dart';
import 'package:school_management/Models/LectureNote.dart';

import '../../../../Util/screen_layout.dart';
import '../../../../Widgets/AppBar.dart';
import '../../../../Widgets/MainDrawer.dart';

class NoteView extends StatelessWidget {
  const NoteView({Key? key, required this.lectureNote}) : super(key: key);
  final LectureNote lectureNote;
  @override
  Widget build(BuildContext context) {
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
        notificationenabled: true,
        ontap: () {
          _scaffoldKey.currentState!.openDrawer();
        },
        title: "Student Dashboard",
      ),
      body: Container(child: ListView()),
    );
  }
}
