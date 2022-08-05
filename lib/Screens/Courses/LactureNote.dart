import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:school_management/Models/LectureNote.dart';
import 'package:school_management/Widgets/AppBar.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../Util/Notify.dart';
import '../../services/CloudinaryService.dart';
import '../Admin/AdminMainDrawer.dart';
import 'QuizView/Quiz.dart';

class LectureNoteView extends StatefulWidget {
  const LectureNoteView({Key? key, required this.courseId, required this.title})
      : super(key: key);
  final int courseId;
  final String title;
  @override
  State<LectureNoteView> createState() => _LectureNoteViewState();
}

class _LectureNoteViewState extends State<LectureNoteView> {
  bool showAddScreen = false;
  List<LectureNote> list = [];
  LectureNote? model;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    showAddScreen = false;
    model = LectureNote();
  }

  Future<void> _showMyDialogDelete(BuildContext context, int id) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Lecture Note'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Are you sure you want to delete '),
              ],
            ),
          ),
          actionsAlignment: MainAxisAlignment.spaceBetween,
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Approve'),
              onPressed: () {
                model!.delete(widget.courseId, id).whenComplete(() {
                  Navigator.of(context).pop();
                  setState(() {});
                });
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _showMyDialogPreview(BuildContext context, String link) async {
    final double width = MediaQuery.of(context).size.width;
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Preview'),
          content: Container(
            width: width * 0.7,
            child: Scaffold(
              body: SfPdfViewer.network(
                link,
                enableDoubleTapZooming: true,
              ),
            ),
          ),
          actionsAlignment: MainAxisAlignment.spaceBetween,
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _showMyDialogEdit(
      BuildContext context, LectureNote model) async {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    TextEditingController controller = TextEditingController();
    TextEditingController noteController = TextEditingController();
    TextEditingController noteWriteUpController = TextEditingController();
    FilePickerResult? pickerResult;
    controller.text = model.title!;
    noteController.text = model.pdfName!;
    noteWriteUpController.text = model.noteWriteUp!;

    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit Lecture Note'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 5),
                      child: Text("Note title"),
                    ),
                  ],
                ),
                Container(
                  // height: height * 0.06,
                  height: height * 0.07,
                  width: width,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: TextFormField(
                    controller: controller,
                    //autofocus: true,
                    minLines: 1,
                    maxLines: 10,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(7),
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 5),
                      child: Text("Note Write Up"),
                    ),
                  ],
                ),
                Container(
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: 1,
                    ),
                    child: Container(
                      // height: height * 0.06,
                      height: height * 0.25,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: TextFormField(
                        //autofocus: true,
                        minLines: 1,
                        maxLines: 10,
                        controller: noteWriteUpController,
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(7),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 5),
                      child: Text("Note PDF Link"),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      // height: height * 0.06,
                      height: height * 0.07,
                      width: width * 0.5,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: TextFormField(
                        enabled: false,
                        controller: noteController,
                        //autofocus: true,
                        minLines: 1,
                        maxLines: 10,
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(7),
                        ),
                      ),
                    ),
                    IconButton(
                        onPressed: () async {
                          var result = await CloudinaryService().getPdf();

                          if (result != null) {
                            pickerResult = result as FilePickerResult;
                            noteController.text = result.files.single.name;
                          }
                        },
                        icon: Icon(Icons.upload_file))
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                EditLectureNoteCheckBox(
                  model: model,
                )
              ],
            ),
          ),
          actionsAlignment: MainAxisAlignment.spaceBetween,
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Approve'),
              onPressed: () async {
                if (controller.text.isEmpty) {
                  Notify.error(context, "Title cannot be empty");
                  return;
                } else if (noteWriteUpController.text.isEmpty) {
                  Notify.error(context, "Note write up cannot be empty");
                  return;
                }
                Notify.loading(context, "");
                model.title = controller.text;
                model.noteWriteUp = noteWriteUpController.text;
                model.pdfName = noteController.text;
                model.link = noteController.text;
                if (pickerResult != null) {
                  uploadAsPdf(model, pickerResult!);
                } else {
                  await model.update(model).whenComplete(() {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                    setState(() {});
                  });
                }
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> uploadAsPdf(
      LectureNote lectureNote, FilePickerResult pickerResult) async {
    await CloudinaryService()
        .uploadToCloudinary(
            ByteData.sublistView(pickerResult.files.single.bytes!),
            pickerResult.files.single.name)
        .then((value) async {
      lectureNote.link = value as String;
      await lectureNote.update(lectureNote).whenComplete(() {
        Navigator.of(context).pop();
        Navigator.of(context).pop();
        setState(() {});
      });
    });
  }

  Future<void> _showMyDialogCreate(BuildContext context) async {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    TextEditingController controller = TextEditingController();
    TextEditingController noteController = TextEditingController();
    TextEditingController noteWriteUpController = TextEditingController();
    FilePickerResult? pickerResult;
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add Lecture Note'),
          content: SingleChildScrollView(
              child: Column(
            children: [
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 5),
                    child: Text("Note title"),
                  ),
                ],
              ),
              Container(
                // height: height * 0.06,

                width: width,
                height: height * 0.07,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: TextFormField(
                  controller: controller,
                  //autofocus: true,
                  minLines: 1,
                  maxLines: 10,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(7),
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 5),
                    child: Text("Note Write Up"),
                  ),
                ],
              ),
              Container(
                child: Padding(
                  padding: EdgeInsets.only(
                    top: 1,
                  ),
                  child: Container(
                    // height: height * 0.06,
                    height: height * 0.25,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: TextFormField(
                      //autofocus: true,
                      minLines: 1,
                      maxLines: 10,
                      keyboardType: TextInputType.multiline,
                      controller: noteWriteUpController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(7),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 5),
                    child: Text("Select Pdf"),
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    // height: height * 0.06,

                    width: width * 0.5,
                    height: height * 0.07,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: TextFormField(
                      enabled: false,
                      controller: noteController,
                      //autofocus: true,
                      minLines: 1,
                      maxLines: 10,
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(7),
                      ),
                    ),
                  ),
                  IconButton(
                      onPressed: () async {
                        var result = await CloudinaryService().getPdf();

                        if (result != null) {
                          pickerResult = result as FilePickerResult;
                          noteController.text = result.files.single.name;
                        }
                      },
                      icon: Icon(Icons.upload_file))
                ],
              ),
            ],
          )),
          actionsAlignment: MainAxisAlignment.spaceBetween,
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Approve'),
              onPressed: () async {
                if (controller.text.isEmpty) {
                  Notify.error(context, "Title cannot be empty");
                  return;
                } else if (noteWriteUpController.text.isEmpty) {
                  Notify.error(context, "Note write up cannot be empty");
                  return;
                }
                Notify.loading(context, "");
                if (pickerResult != null) {
                  await CloudinaryService()
                      .uploadToCloudinary(
                          ByteData.sublistView(
                              pickerResult!.files.single.bytes!),
                          pickerResult!.files.single.name)
                      .then((value) {
                    model!
                        .create(LectureNote(
                            title: controller.text,
                            courseId: widget.courseId,
                            link: value as String,
                            pdfName: pickerResult!.files.single.name,
                            noteWriteUp: noteWriteUpController.text))
                        .whenComplete(() {
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                      setState(() {});
                    });
                  });
                } else {
                  model!
                      .create(LectureNote(
                          title: controller.text,
                          courseId: widget.courseId,
                          link: "not available",
                          pdfName: "not available",
                          isActive: false,
                          noteWriteUp: noteWriteUpController.text))
                      .whenComplete(() {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                    setState(() {});
                  });
                }
              },
            ),
          ],
        );
      },
    );
  }

  List<Widget> rows1(List<LectureNote> list, BuildContext context) {
    List<Widget> items = [];
    items.add(Card(
      color: Colors.white10,
      child: ListTile(
        trailing: Text(
          "Action",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
        title: Text(
          "Lecture Note Title",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
      ),
    ));
    for (var i = 0; i < list.length; i += 1) {
      items.add(LectureNoteCard(
        lectureNote: list[i],
        showMyDialogDelete: _showMyDialogDelete,
        showMyDialogEdit: _showMyDialogEdit,
        showMyDialogPreview: _showMyDialogPreview,
      ));
    }

    return items;
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey =
        new GlobalKey<ScaffoldState>();

    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        elevation: 0,
        child: AdminMainDrawer(),
      ),
      appBar: CommonAppBar(
        menuenabled: true,
        notificationenabled: false,
        ontap: () {
          _scaffoldKey.currentState!.openDrawer();
        },
        title: "${widget.title}/Lecture Note",
      ),
      body: FutureBuilder<List<LectureNote>>(
        future: LectureNote.getLectureNote(
            widget.courseId), // a previously-obtained Future<String> or null
        builder:
            (BuildContext context, AsyncSnapshot<List<LectureNote>> snapshot) {
          Widget children;
          if (snapshot.hasData) {
            children = ListView(
              children: rows1(snapshot.data!, context),
            );
          } else if (snapshot.hasError) {
            children = Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            children = Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 60,
                      height: 60,
                      child: CircularProgressIndicator(
                        color: Colors.lime,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 16),
                      child: Text('Getting Course...'),
                    )
                  ]),
            );
          }
          return Center(
            child: children,
          );
        },
      ),
      /* ListView(
        children: rows1(list, context),
      ),*/
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showMyDialogCreate(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class EditLectureNoteCheckBox extends StatefulWidget {
  const EditLectureNoteCheckBox({Key? key, required this.model})
      : super(key: key);
  final LectureNote model;
  @override
  State<EditLectureNoteCheckBox> createState() =>
      _EditLectureNoteCheckBoxState();
}

class _EditLectureNoteCheckBoxState extends State<EditLectureNoteCheckBox> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Row(
          children: [
            Container(
              margin: EdgeInsets.only(left: 5),
              child: Text("Make visible to students"),
            ),
          ],
        ),
        Checkbox(
            value: widget.model.isActive,
            onChanged: (isActive) {
              setState(() {
                widget.model.isActive = isActive;
              });
            })
      ],
    );
  }
}

class LectureNoteCard extends StatelessWidget {
  const LectureNoteCard(
      {Key? key,
      required this.lectureNote,
      required this.showMyDialogEdit,
      required this.showMyDialogDelete,
      required this.showMyDialogPreview})
      : super(key: key);
  final LectureNote lectureNote;
  final Function showMyDialogEdit;
  final Function showMyDialogDelete;
  final Function showMyDialogPreview;
  @override
  Widget build(BuildContext context) {
    return Card(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: 100,
          margin: EdgeInsets.only(left: 20),
          child: Text(
            lectureNote.title!,
            overflow: TextOverflow.fade,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
        ),
        Row(
          children: [
            IconButton(
                color: Colors.blue,
                onPressed: () => showMyDialogEdit(context, lectureNote),
                icon: Icon(
                  Icons.edit,
                )),
            IconButton(
                color: Colors.red,
                onPressed: () {
                  showMyDialogDelete(context, lectureNote.lectureNoteId!);
                },
                icon: Icon(
                  Icons.delete,
                )),
            IconButton(
                color: Colors.green,
                onPressed: () {
                  if (lectureNote.link == "not available") {
                    Notify.error(context, "No PDF available");
                  } else {
                    showMyDialogPreview(context, lectureNote.link!);
                  }
                },
                icon: Icon(
                  Icons.preview,
                )),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => QuizView(
                          quizViewArgument: QuizViewArgument(
                        isReviewing: false,
                        selectedOption: {},
                        lectureNote: lectureNote,
                        title: " ",
                        quizList: [],
                      )),
                    ),
                  );
                },
                child: Text("Quiz")),
            Icon(lectureNote.isActive!
                ? Icons.check_box
                : Icons.check_box_outline_blank)
          ],
        )
      ],
    ));
  }
}
