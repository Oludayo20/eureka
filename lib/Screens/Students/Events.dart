

import 'package:flutter/material.dart';

import '../../Util/screen_layout.dart';

class EurekaEvents extends StatelessWidget {
  const EurekaEvents({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Layout layout = Layout(size: MediaQuery.of(context).size);
    List<Widget> eventsList(){
      List<Widget> events = [];
      events.add(Text("Hello, welcome to Eureka online platform."));
      events.add(Text("New lecture note would be released every week."));
      events.add(Text("Stay tuned."));
      return events;
    }
    return Container(
      padding: const EdgeInsets.only(top: 20.0),
      width: layout.isAndroid ? layout.width : layout.width * 0.45,
      color: Colors.white24,
      child: Column(
        children: [
          Container(
            height: layout.height * 0.1,
            width:layout.isAndroid ? layout.width : layout.width * 0.45,
            child: Card(
              child: Center(
                child: Text(
                  "Events",
                  style: TextStyle(fontSize: 30),
                ),
              ),
            ),
          ),
          Container(
              padding: EdgeInsets.all(10),
              height: layout.height * 0.2,
              width:layout.isAndroid ? layout.width : layout.width * 0.45,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: eventsList(),
              )
          ),

        ],
      ),
    );
  }
}
