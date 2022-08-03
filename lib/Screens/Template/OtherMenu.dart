import 'package:flutter/material.dart';
import '../../Util/ImagePath.dart';
import '../../Widgets/Home_C_AppBar.dart';
import '../Home_C/WebMenu.dart';
import 'AboutUs.dart';
import 'Team.dart';

class OtherMenu extends StatelessWidget {
  const OtherMenu({Key? key, required this.title, required this.showing})
      : super(key: key);
  final String title;
  final int showing;
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    List<Widget> show = [
      Team(),
      AboutUs(),
    ];
    bool isAndroid = false;
    if (width < 650) isAndroid = true;
    return Container(
      width: width,
      height: isAndroid ? height * 0.5 : height,
      child: Scaffold(
          drawer: isAndroid
              ? Drawer(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  child: WebMenu(
                    isAndroid: true,
                  ),
                )
              : null,
          appBar: homePageAppBar(context, isAndroid),
          extendBodyBehindAppBar: true,
          body: Container(
            height: height,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(ImagePath.team),
                    //image: AssetImage(ImagePath().homePageImageAssert),
                    fit: isAndroid ? BoxFit.cover : BoxFit.fill)),
            child: Container(
              width: width,
              height: height,
              child: ListView(
                children: [
                  SizedBox(
                    height: height * 0.4,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(padding: EdgeInsets.all(20)),
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: width * 0.09,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height * 0.2,
                  ),
                  show[showing],
                ],
              ),
            ),
          )),
    );
  }
}
