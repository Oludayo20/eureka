import 'package:flutter/material.dart';
import 'package:school_management/Screens/Home_C/WebMenu.dart';
import 'package:school_management/Screens/LoginPage.dart';
import 'package:school_management/Screens/RequestLogin.dart';

AppBar homePageAppBar(BuildContext context, bool isAndroid) {
  return AppBar(
    leading: !isAndroid
        ? Center(
            child: Text(
              "eureka",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          )
        : null,
    leadingWidth: 100,
    backgroundColor: Color.fromARGB(255, 224, 222, 222).withOpacity(0.2),
    actions: [
      !isAndroid
          ? WebMenu(
              isAndroid: false,
            )
          : Container(),
      //Spacer(),

      Center(
        child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => RequestLogin(),
                  ));
            },
            style: TextButton.styleFrom(
              padding: EdgeInsets.symmetric(
                horizontal: 20 * 1.2,
                // vertical: 20,
              ),
              backgroundColor: Colors.teal[200],
            ),
            child: Text("Register")),
      ),
      Container(width: 10,),
      Center(
        child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => MyHomePage(),
                  ));
            },
            style: TextButton.styleFrom(
              padding: EdgeInsets.symmetric(
                horizontal: 20 * 1.2,
                // vertical: 20,
              ),
              backgroundColor: Colors.teal[200],
            ),
            child: Text("Login")),
      ),
    ],
  );
}
