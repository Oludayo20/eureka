import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:school_management/Widgets/TextFieldCard.dart';
import 'package:school_management/firebase_options.dart';
import 'package:school_management/routes/routes.dart';
void main() {
  Future<bool> init() async {
    try {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      return true;
    } on FirebaseOptions catch (e) {
      print(e);
      return false;
    }
  }
  //TODO: Implement the checking of isLogin better
   init().then((val) {
    if (val) {
      FirebaseAuth.instance.authStateChanges().listen((User? user) {
       runApp(MyApp());
      });
    } else {
      runApp(ErrorMain());
    }
  });
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Eureka',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: initialRoute(),
      //initialRoute: 'test',
      onGenerateRoute: RouteGenerator.generateRoute,
      onUnknownRoute: RouteGenerator.generateRoute,
    );
  }
}

class Test extends StatelessWidget {
  const Test({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    return Scaffold(
      body: ListView(
        children: [
          TextFieldCard(
            controller: controller,
            originalHeight: 30,
            headerText: "Karo",
            width: 170,
          ),

        ],
      ),
    );
  }
}

class ErrorMain extends StatelessWidget {
  const ErrorMain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("NetWork error"),
    );
  }
}
