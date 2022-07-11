import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/cupertino.dart';

import '../LoginPage.dart';
import 'WebMenu.dart';

class Header extends StatelessWidget {
  const Header({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    return Container(
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
                "Far far away, behind the word mountains\n far from the countries",
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
                child: Text("Register"),
              ),
            ],
          ),
          Spacer(),
        ],
      ),
    );
  }

}
