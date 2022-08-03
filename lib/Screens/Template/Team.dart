import 'package:flutter/material.dart';
import '../../Util/ImagePath.dart';
import '../../Util/screen_layout.dart';

class Team extends StatelessWidget {
  const Team({Key? key}) : super(key: key);

  Widget _teamInfoBox(
    String image,
    String name,
    String role,
      Layout layout
  ) {

    return Container(
      width: layout.isAndroid ? layout.width * 0.4 : layout.width * 0.2,
      height: layout.isAndroid? layout.height * 0.4 : layout.height * 0.6,
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: layout.isAndroid ? layout.width * 0.4 : layout.width * 0.2,
            height: layout.isAndroid ? layout.height * 0.2 : layout.height * 0.4,
            child: Image(
                image: NetworkImage(image),
                //image: AssetImage(ImagePath().aboutUsImage),
                fit: BoxFit.cover),
          ),
          SizedBox(
            height: layout.height * 0.02,
          ),
         Container(
            width: layout.isAndroid ? layout.width * 0.4 : layout.width * 0.2,
            height: layout.isAndroid ? layout.height * 0.15 : layout.height * 0.15,
            child:   Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Center(
                  child: Text(
                    name,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: layout.height * 0.025,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Center(
                  child: Text(
                    role,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: layout.height * 0.02,
                    ),
                  ),
                )
              ],
            ),
          ),


        ],
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    Layout layout = Layout(size: MediaQuery.of(context).size);
    bool isAndroid = false;
    if (width < 650) isAndroid = true;
    return Container(
      width: width,
      height: isAndroid ? height * 1.2 : height * 1.1,
      child: Scaffold(
          extendBodyBehindAppBar: true,
          body: Container(
            color: Color.fromARGB(40, 173, 181, 189),
            child: Container(
              //color: Color.fromARGB(255, 173, 181, 189),

              child: Column(
                children: [
                  SizedBox(
                    height: height * 0.1,
                  ),
                  width > 600
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _teamInfoBox(
                                ImagePath.davidProfilePic,
                                "Muraina David",
                                "DEVELOPER AND LEAD INSTRUCTOR",
                            layout),
                            _teamInfoBox(
                                ImagePath.karoProfilePic,
                                "Edaware Richard",
                                "DEVELOPER AND LEAD INSTRUCTOR",layout),
                            _teamInfoBox(
                                ImagePath.dipoProfilePic,
                                "Dipo",
                                "DEVELOPER AND LEAD INSTRUCTOR",layout),
                            _teamInfoBox(
                                ImagePath.dayoProfilePic,
                                "A.Dayo",
                                "DEVELOPER AND LEAD INSTRUCTOR",layout),
                          ],
                        )
                      : Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                _teamInfoBox(
                                    ImagePath.davidProfilePic,
                                    "Muraina David",
                                    "DEVELOPER AND LEAD INSTRUCTOR",layout),
                                _teamInfoBox(
                                    ImagePath.karoProfilePic,
                                    "Edaware Richard",
                                    "DEVELOPER AND LEAD INSTRUCTOR",layout),
                              ],
                            ),
                            SizedBox(
                              height: height * 0.1,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                _teamInfoBox(
                                    ImagePath.dipoProfilePic,
                                    "Dipo",
                                    "DEVELOPER AND LEAD INSTRUCTOR",layout),
                                _teamInfoBox(
                                    ImagePath.dayoProfilePic,
                                    "A. Dayo",
                                    "DEVELOPER AND LEAD INSTRUCTOR",layout),
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
