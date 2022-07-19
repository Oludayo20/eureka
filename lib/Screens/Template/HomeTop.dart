import 'package:flutter/material.dart';
import 'package:school_management/Screens/SignUp.dart';

import '../../Util/ImagePath.dart';
import '../../Widgets/Home_C_AppBar.dart';
import '../Home_C/WebMenu.dart';
import 'AboutUs.dart';

class HomeTop extends StatelessWidget {
  const HomeTop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
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
                    image: NetworkImage(ImagePath.home),
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
                    children: [
                      Padding(padding: EdgeInsets.all(20)),
                      Text(
                        "Welcome to EUREKA",
                        style: TextStyle(
                          fontSize: width * 0.05,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Padding(padding: EdgeInsets.all(20)),
                      Text(
                        "Best Online Education",
                        style: TextStyle(
                          fontSize: width * 0.07,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Padding(padding: EdgeInsets.all(20)),
                      Text(
                        isAndroid
                            ? "Far far away, behind the word mountains\nFar from the countries"
                            : "Far far away, behind the word mountains far from the countries",
                        style: TextStyle(
                            color: Colors.white, fontSize: width * 0.03),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Padding(padding: EdgeInsets.all(20)),
                      ElevatedButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                            horizontal: 20 * 1.2,
                            // vertical: 20,
                          ),
                          backgroundColor: Colors.teal[200],
                        ),
                        child: Text("View Courses"),
                      ),
                      // Icon(
                      //   Icons.arrow_forward,
                      //   color: Colors.white,
                      // ),
                      Padding(padding: EdgeInsets.all(20)),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    SignUp(),
                              ));
                        },
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                            horizontal: 20 * 1.2,
                            // vertical: 20,
                          ),
                          backgroundColor: Colors.teal[200],
                        ),
                        child: Text("Register"),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height * 0.2,
                  ),
                  AboutUs(),
                ],
              ),
            ),
          )),
    );
  }
}
