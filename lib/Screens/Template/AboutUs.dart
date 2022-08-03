import 'package:flutter/material.dart';
import '../../Util/ImagePath.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({Key? key}) : super(key: key);
  Widget _aboutUsInfoBox(
    double width,
    double height,
    String image,
    String heading,
    String body,
  ) {
    return width < 600
        ? Column(
            children: [
              Container(
                // margin: EdgeInsets.only(left:width * 0.07, ),
                color: Colors.white,
                height: height * 0.3,
                width: width * 0.35,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                    Container(
                      width: height * 0.07,
                      height: height * 0.1,
                      child:
                          Image(image: NetworkImage(image), fit: BoxFit.fill),
                    ),
                    Column(
                      children: [
                        Text(
                          heading,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: width * 0.03,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: width * 0.05,
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          )
        : Row(
            children: [
              SizedBox(
                width: width * 0.05,
              ),
              Container(
                // margin: EdgeInsets.only(left:width * 0.07, ),
                color: Colors.white,
                height: height * 0.3,
                width: width * 0.35,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: width * 0.07,
                      height: height * 0.1,
                      child:
                          Image(image: NetworkImage(image), fit: BoxFit.fill),
                    ),
                    Column(
                      children: [
                        Text(
                          heading,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: width * 0.03,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: width * 0.05,
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
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
      height: isAndroid ? height * 1.3 : height * 1.1,
      child: Scaffold(
          extendBodyBehindAppBar: true,
          body: Container(
            color: Color.fromARGB(40, 173, 181, 189),
            child: Container(
              //color: Color.fromARGB(255, 173, 181, 189),

              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  !isAndroid
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: width * 0.6,
                              height: isAndroid ? height * 0.6 : height * 1.1,
                              child: Image(
                                  image: NetworkImage(ImagePath.aboutUs),

                                  //image: AssetImage(ImagePath().aboutUsImage),
                                  fit: BoxFit.fill),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: height * 0.1,
                                ),
                                Row(
                                  children: [
                                    Padding(padding: EdgeInsets.all(20)),
                                    Text(
                                      "LEARN ANYTHING",
                                      style: TextStyle(
                                          color: Colors.teal[200],
                                          fontSize: width * 0.02,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Padding(padding: EdgeInsets.all(20)),
                                    Text(
                                      "Benefits About Online\nLearning Expertise",
                                      style: TextStyle(
                                        fontSize: width * 0.03,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: height * 0.05,
                                ),
                                _aboutUsInfoBox(
                                    width,
                                    height,
                                    ImagePath.storyTel,
                                    "Online Course",
                                    "Far far away, behind the word mountains, far from the countries Vokalia and Consonantia, there live the blind texts."),
                                SizedBox(
                                  height: height * 0.05,
                                ),
                                _aboutUsInfoBox(
                                    width,
                                    height,
                                    ImagePath.storyTel,
                                    "Self Quiz",
                                    "Far far away, behind the word mountains, far from the countries Vokalia and Consonantia, there live the blind texts."),
                              ],
                            )
                          ],
                        )
                      : Column(
                          children: [
                            Row(
                              children: [
                                Padding(padding: EdgeInsets.all(20)),
                                Text(
                                  "LEARN ANYTHING",
                                  style: TextStyle(
                                      color: Colors.teal[200],
                                      fontSize: height * 0.02,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Padding(padding: EdgeInsets.all(20)),
                                Text(
                                  "Benefits About Online\nLearning Expertise",
                                  style: TextStyle(
                                    fontSize: height * 0.03,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: height * 0.05,
                            ),
                            Container(
                                width: width,
                                height: height * 0.6,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      //image: NetworkImage(ImagePath().homePageImage),
                                      image: NetworkImage(ImagePath.aboutUs),
                                      fit: BoxFit.fill),
                                )),
                            SizedBox(
                              height: height * 0.1,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                _aboutUsInfoBox(
                                    width,
                                    height,
                                    ImagePath.storyTel,
                                    "Online Course",
                                    "Far far away, behind the word mountains, far from the countries Vokalia and Consonantia, there live the blind texts."),
                                _aboutUsInfoBox(
                                    width,
                                    height,
                                    ImagePath.storyTel,
                                    "Self Quiz",
                                    "Far far away, behind the word mountains, far from the countries Vokalia and Consonantia, there live the blind texts."),
                              ],
                            ),
                            SizedBox(
                              height: height * 0.05,
                            ),
                          ],
                        ),
                ],
              ),
            ),
          )),
    );
  }
}
