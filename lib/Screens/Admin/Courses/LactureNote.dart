import 'dart:typed_data';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:school_management/Models/Department.dart';
import 'package:school_management/Models/LectureNote.dart';
import 'package:school_management/Widgets/AppBar.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../AdminMainDrawer.dart';

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
    list = [];
    model = LectureNote();
    model!.read(list, widget.courseId).whenComplete(() {
      setState(() {});
    });
  }

  Future getPdf() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      return result;
    } else {
      // User canceled the picker
    }
  }

  Future uploadToCloudinary(ByteData byteData, String pdfName) async {
    final cloudinary = CloudinaryPublic('richkazz', 'eene8be4', cache: false);

    try {
      CloudinaryResponse response = await cloudinary.uploadFile(
        CloudinaryFile.fromByteData(byteData,
            identifier: pdfName, resourceType: CloudinaryResourceType.Auto),
      );
      return response.secureUrl;
    } on CloudinaryException catch (e) {
      print(e.message);
      print(e.request);
    }
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
                  list = [];
                  model!.read(list, widget.courseId).whenComplete(() {
                    Navigator.of(context).pop();
                    setState(() {});
                  });
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
    FilePickerResult? pickerResult;
    controller.text = model.title!;
    noteController.text = model.note!;
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
                  width: width * 0.75,
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
                          var result = await getPdf();

                          if (result != null) {
                            pickerResult = result as FilePickerResult;
                            noteController.text = result.files.single.name;
                          }
                        },
                        icon: Icon(Icons.upload_file))
                  ],
                ),
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
                model.title = controller.text;
                if(model.note==noteController.text){
                  await model.update(model).whenComplete(() {
                    list = [];
                    model.read(list, widget.courseId).whenComplete(() {
                      Navigator.of(context).pop();
                      setState(() {});
                    });
                  });
                }else{
                  await uploadToCloudinary(
                      ByteData.sublistView(pickerResult!.files.single.bytes!),
                      pickerResult!.files.single.name).then((value) async {
                    model.note = value as String;
                    await model.update(model).whenComplete(() {
                      list = [];
                      model.read(list, widget.courseId).whenComplete(() {
                        Navigator.of(context).pop();
                        setState(() {});
                      });
                    });
                  });
                }


              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _showMyDialogCreate(BuildContext context) async {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    TextEditingController controller = TextEditingController();
    TextEditingController noteController = TextEditingController();
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

                width: width * 0.75,
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
                        var result = await getPdf();

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
                await uploadToCloudinary(
                        ByteData.sublistView(pickerResult!.files.single.bytes!),
                        pickerResult!.files.single.name)
                    .then((value){
                  model!
                      .create(LectureNote(
                          title: controller.text,
                          courseId: widget.courseId,
                          note: value as String))
                      .whenComplete(() {
                    list = [];
                    model!.read(list, widget.courseId).whenComplete(() {
                      Navigator.of(context).pop();
                      setState(() {});
                    });
                  });
                });
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
      items.add(Card(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: EdgeInsets.only(left: 20),
            child: Text(
              list[i].title!,
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
                  onPressed: () {
                    _showMyDialogEdit(context, list[i]);
                  },
                  icon: Icon(
                    Icons.edit,
                  )),
              IconButton(
                  color: Colors.red,
                  onPressed: () {
                    _showMyDialogDelete(context, list[i].lectureNoteId!);
                  },
                  icon: Icon(
                    Icons.delete,
                  )),
              IconButton(
                  color: Colors.green,
                  onPressed: () {
                    _showMyDialogPreview(context, list[i].note!);
                  },
                  icon: Icon(
                    Icons.preview,
                  )),
              TextButton(onPressed: () {}, child: Text("Quiz"))
            ],
          )
        ],
      )));
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
      body: ListView(
        children: rows1(list, context),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showMyDialogCreate(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
