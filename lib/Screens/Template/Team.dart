import 'package:flutter/material.dart';
import 'package:school_management/Screens/SignUp.dart';

import '../../Util/ImagePath.dart';

class Team extends StatelessWidget {
  const Team({Key? key}) : super(key: key);
  Widget _teamInfoBox(
    double width,
    double height,
    String image,
    String name,
    String role,
  ) {
    return Container(
      width: width < 600? width * 0.4:width * 0.2,
      height: width < 600 ? height * 0.4 : height * 0.6,
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width:width < 600? width * 0.4:width * 0.2,
            height: width < 600 ? height * 0.2 : height * 0.4,
            child: Image(
                image: NetworkImage(ImagePath.aboutUs),
                //image: AssetImage(ImagePath().aboutUsImage),
                fit: BoxFit.fill),
          ),
          Center(
            child: Text(
              name,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: height * 0.025,
                  fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: height * 0.02,
          ),
          Center(
            child: Text(
              role,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: height * 0.02,
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    bool isAndroid = false;
    if (width < 650) isAndroid = true;
    return Container(
      width: width,
      height:isAndroid?height * 1.2: height * 1.1,
      child: Scaffold(
          extendBodyBehindAppBar: true,
          body: Container(
            color: Color.fromARGB(40, 173, 181, 189),
            child: Container(
              //color: Color.fromARGB(255, 173, 181, 189),

              child: Column(
                children: [
                  SizedBox(
                    height: height * 0.2,
                  ),
                 width > 600? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _teamInfoBox(width, height, ImagePath.aboutUs, "Ph.D Adrian Molises",
                          "DEVELOPER AND LEAD INSTRUCTOR"),
                      _teamInfoBox(width, height, ImagePath.aboutUs, "Ph.D Adrian Molises",
                          "DEVELOPER AND LEAD INSTRUCTOR"),
                      _teamInfoBox(width, height, ImagePath.aboutUs, "Ph.D Adrian Molises",
                          "DEVELOPER AND LEAD INSTRUCTOR"),
                      _teamInfoBox(width, height, ImagePath.aboutUs, "Ph.D Adrian Molises",
                          "DEVELOPER AND LEAD INSTRUCTOR"),
                    ],
                  )
                     :Column(
                   children: [
                     Row(
                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                       children: [
                         _teamInfoBox(width, height, ImagePath.aboutUs, "Ph.D Adrian Molises",
                             "DEVELOPER AND LEAD INSTRUCTOR"),
                         _teamInfoBox(width, height, ImagePath.aboutUs, "Ph.D Adrian Molises",
                             "DEVELOPER AND LEAD INSTRUCTOR"),
                       ],
                     ),
                     SizedBox(
                       height: height * 0.01,
                     ),
                     Row(
                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                       children: [
                         _teamInfoBox(width, height, ImagePath.aboutUs, "Ph.D Adrian Molises",
                             "DEVELOPER AND LEAD INSTRUCTOR"),
                         _teamInfoBox(width, height, ImagePath.aboutUs, "Ph.D Adrian Molises",
                             "DEVELOPER AND LEAD INSTRUCTOR"),
                       ],
                     )
                   ],
                 )
                ],
              ),
            ),
          )),
    );
  }
}
