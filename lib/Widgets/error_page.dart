
import 'package:flutter/material.dart';
import 'package:school_management/Authentication/authentication_helper.dart';

import '../constants/const.enum.pagesName.dart';
import '../routes/routes_to_name.dart';


class ErrorPage extends StatelessWidget {
  const ErrorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "An error occurred",
            style: TextStyle(fontSize: 30),
          ),
          TextButton(
              onPressed: () {
                Navigator.popUntil(
                    context,
                    ModalRoute.withName(GenerateRootNames.generateRouteName(
                        PageName.homePage)));
                Navigator.pushNamed(
                  context,
                  GenerateRootNames.generateRouteName(
                      PageName.unknown),
                );
                //Navigator.popAndPushNamed(context, ModalRoute.withName("/"), );
              },
              child: Text("Home"))
        ],
      ),
    );
  }
}
