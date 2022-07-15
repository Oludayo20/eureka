import 'dart:async';

import 'package:flutter/material.dart';

import '../Util/ImagePath.dart';
import 'Template/HomeTop.dart';
import 'Template/OtherMenu.dart';

StreamController<int> streamControllerHome = StreamController();

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selected = 0;
  int other = 0;
  String otherTitle = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    streamControllerHome = StreamController();
    streamControllerHome.stream.listen((event) {
      if (event == 0) {
        selected = 0;
      } else if (event < 3) {
        if (event == 1) {
          other = 0;
          otherTitle = "Team";
        } else if (event == 2) {
          otherTitle = "About Us";
          other = 1;
        }
        selected = 1;
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    List<Widget> currWidget = [
      HomeTop(),
      OtherMenu(
        title: otherTitle,
        showing: other,
      )
    ];
    return Scaffold(
        bottomSheet: Container(
          width: width,
          height: height * 0.12,
          color: Colors.black,
          child: Image(
              image: NetworkImage(ImagePath.awRap),
              fit: BoxFit.cover),
        ),
          body:Container(
            width: width,
            height:width > 600? height * 1.3:height * 1.5,
            child:
            currWidget[selected],

        ));


  }
}
