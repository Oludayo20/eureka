import 'dart:async';
import 'package:flutter/material.dart';
import '../Util/ImagePath.dart';
import '../Util/Notify.dart';
import 'Template/HomeTop.dart';
import 'Template/OtherMenu.dart';

import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';

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

  Future<void> _launchInBrowser(Uri url, BuildContext context) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      Notify.error(context, 'Could not launch $url');
    }
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
      body: Stack(
        children: [
          Container(
            width: width,
            height: width > 600 ? height * 1.3 : height * 1.5,
            child: currWidget[selected],
          ),
          Positioned(
              left: width < 400 ? width * 0.8 : width * 0.9,
              top: height * 0.9,
              child: InkWell(
                onTap: () async {
                  await _launchInBrowser(
                      Uri.parse('https://wa.me/+2349034579816'), context);
                },
                child: Image(
                  image: NetworkImage(ImagePath.whatsAppImage),
                  width: 35,
                ),
              ))
        ],
      ),
    );
  }
}
