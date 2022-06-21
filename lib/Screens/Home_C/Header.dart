import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/cupertino.dart';

import '../LoginPage.dart';
import 'WebMenu.dart';

class Header extends StatelessWidget {
  const Header({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
        image: AssetImage("assets/bg.webp"),
        fit: BoxFit.cover
      )),
      child: Column(
        children: [
          Container(
              width: double.infinity,
              color: Color.fromARGB(255, 224, 222, 222).withOpacity(0.2),
              child: SafeArea(
                child: Column(
                  children: [
                    Container(
                        constraints: BoxConstraints(maxWidth: 1323.0),
                        padding: EdgeInsets.all(20.0),
                        child: Column(children: [
                          Row(
                            children: [
                              Text(
                                "eureka",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                              Spacer(),
                              WebMenu(),
                              Spacer(),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        MyHomePage(),
                                  ));
                                },
                                  style: 
                                  TextButton.styleFrom(
                                    padding: 
                                    EdgeInsets.symmetric(
                                      horizontal: 20 * 1.2,
                                      // vertical: 20,
                                      ),
                                      backgroundColor: Colors.teal[200],
                                    ),
                                child: 
                                Text(
                                  "Register"
                                  )
                                ),
                          ],
                          ),
                        ])
                        ),
                        
                  ],
                ),
                
              )
              ),
              Spacer(),
              SizedBox(
                                  height: 40,
                                ),
                                
                                Row(
                                  children: [
                                    Padding(padding: EdgeInsets.all(20)),
                                    Text("Welcome to EUREKA", 
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
                                      "Far far away, behind the word mountains far from the countries",
                                      style: TextStyle(color: Colors.white,
                                      height: 1.0),
                                    ),
                                  ],
                                ),
                                
                                Row(
                                  children: [
                                    Padding(padding: EdgeInsets.all(20)),
                                    ElevatedButton(
                                    onPressed: () {},
                                      style: 
                                      TextButton.styleFrom(
                                        padding: 
                                        EdgeInsets.symmetric(
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
                                        MyHomePage(),
                                  ));
                                    },
                                      style: 
                                      TextButton.styleFrom(
                                        padding: 
                                        EdgeInsets.symmetric(
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