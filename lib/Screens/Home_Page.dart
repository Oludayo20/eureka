import 'package:flutter/material.dart';
import 'package:school_management/Screens/RequestLogin.dart';
import 'package:school_management/Widgets/Home_C_AppBar.dart';
import '../Util/ImagePath.dart';
import 'Home_C/WebMenu.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    bool isAndroid = false;
    if (width < 650) isAndroid = true;
    return Container(
      width: width,
      height: height,
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
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(ImagePath().homePageImage),
                    fit: BoxFit.fill)),
            child: Container(
              width: width,
              height: height,
              child: Column(
                children: [
                  Spacer(),
                  SizedBox(
                    height: 40,
                  ),
                  Row(
                    children: [
                      Padding(padding: EdgeInsets.all(20)),
                      Text(
                        "Welcome to EUREKA",
                        style: TextStyle(
                          fontSize: 32,
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
                        style: TextStyle(color: Colors.white, height: 1.0),
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
                                    RequestLogin(),
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
                  Spacer(),
                ],
              ),
            ),
          )),
    );
  }
}
