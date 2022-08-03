import 'package:flutter/material.dart';

class SendEmail extends StatefulWidget {
  SendEmail({Key? key}) : super(key: key);

  @override
  State<SendEmail> createState() => _SendEmailState();
}

class _SendEmailState extends State<SendEmail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Container(
        height: 1000.0,
        width: 1000.0,
        decoration: BoxDecoration(
            // color: Colors.teal[200],
            border: Border.all(
          color: Color.fromARGB(77, 115, 113, 113),
          width: 200.0,
        )),
        child: ListView(
          children: [
            Card(
              clipBehavior: Clip.antiAlias,
              child: Column(children: [
                Container(
                  height: 100.0,
                  // width: 500.0,
                  color: Colors.teal[200],
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment
                        .center, //Center Row contents horizontally,
                    crossAxisAlignment: CrossAxisAlignment
                        .center, //Center Row contents vertically,
                    children: [
                      Text(
                        'Welcome to',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        ' EUREKA😀',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.0),
                Padding(
                  padding: const EdgeInsets.fromLTRB(50.0, 50, 50, 15),
                  child: Column(
                    children: [
                      Text(
                        'Thanks For Signing Up,',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 25.0,
                        ),
                      ),
                      Text(
                        'Oludayo!',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 30.0,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.mail,
                  size: 100,
                  color: Colors.teal[200],
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(50.0, 15, 50, 20),
                  child: Column(
                    children: [
                      Text(
                        'Please verify your email address to get access to thousands of materials, And get to chat with our experts too.',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15.0,
                        ),
                      ),
                      Text(
                        'Thank You!',
                        style: TextStyle(
                          color: Colors.teal[200],
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                // SizedBox(height: 11.0),
                Padding(
                  padding: const EdgeInsets.fromLTRB(50.0, 5, 50, 20),
                  child: MaterialButton(
                    onPressed: () {},
                    elevation: 0.0,
                    minWidth: MediaQuery.of(context).size.width,
                    color: Colors.teal[200],
                    child: Text(
                      "Verify Email",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                )
              ]),
            ),
          ],
        ),
      ),
    ));
  }
}
