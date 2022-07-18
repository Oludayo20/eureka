// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:school_management/Screens/Admin/HomePage/HomePage.dart';
import 'package:school_management/firebase_options.dart';

import 'Util/Notify.dart';


void main() {
  Future init() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }
  init().whenComplete(() {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Eureka',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
     home: AdminHome()
    );
  }
}
class Test extends StatelessWidget {
  const Test({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: TextButton(
        onPressed: (){
          Notify.success(context, "Success");
        },
        child: Text("Text"),
      ),),
    );
  }
}

