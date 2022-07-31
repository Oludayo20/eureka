import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../../Widgets/AppBar.dart';
import '../../../Widgets/MainDrawer.dart';

class DisplayNote extends StatelessWidget {
  const DisplayNote({Key? key, required this.link}) : super(key: key);
  final String link;
  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey =
    new GlobalKey<ScaffoldState>();
    return Scaffold(
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
        title: "Dashboard",
      ),
      body: SfPdfViewer.network(
        link,
        enableTextSelection: false,
        enableDoubleTapZooming: true,
      ),
    );
  }
}
