import 'package:flutter/material.dart';
import 'package:school_management/Screens/Students/Home/home.dart';
import 'package:school_management/Widgets/DrawerListTile.dart';

import '../constants/const.enum.pagesName.dart';
import '../routes/routes_to_name.dart';

class MainDrawer extends StatefulWidget {
  @override
  _MainDrawerState createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        DrawerListTile(
            imgpath: "home.png",
            name: "Home",
            ontap: () {
              Navigator.pop(context);
              Navigator.pushNamed(
                context,
                GenerateRootNames.generateRouteName(
                    PageName.studentDashBord),
              );
            }),
      ],
    );
  }
}
