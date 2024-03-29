import 'package:flutter/material.dart';
import '../Authentication/Authentication.dart';
import '../constants/constants.dart';
import '../routes/routes.dart';

class CommonAppBar extends StatelessWidget with PreferredSizeWidget {
  final String? title;
  final bool? menuenabled;
  final bool? notificationenabled;
  final Function()? ontap;
  const CommonAppBar({
    Key? key,
    this.title,
    this.menuenabled,
    this.notificationenabled,
    this.ontap,
  }) : super(key: key);
  Future<void> _showMyDialogProfileAction(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Logout'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Card(
                  color: Colors.white30,
                  child: ListTile(
                    trailing: Icon(
                      Icons.logout,
                      color: Colors.red,
                    ),
                    leading: Text("Logout"),
                    onTap: () {
                      AuthenticationHelper().signOut().whenComplete(() {
                        Navigator.popUntil(context,
                            (Route<dynamic> predicate) => predicate.isFirst);
                        Navigator.pop(context);
                        Navigator.pushNamed(
                          context,
                          GenerateRootNames.generateRouteName(PageName.homePage),
                        );
                      });
                    },
                  ),
                )
              ],
            ),
          ),
          actionsAlignment: MainAxisAlignment.spaceBetween,
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        "$title",
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
      leading: menuenabled == true
          ? IconButton(
              color: Colors.black,
              onPressed: ontap,
              icon: Icon(
                Icons.menu,
              ),
            )
          : null,
      actions: [
        notificationenabled == true
            ? InkWell(
                onTap: () {},
                child: Image.asset(
                  "assets/notification.png",
                  width: 35,
                ),
              )
            : SizedBox(
                width: 1,
              ),
        Padding(
          padding: EdgeInsets.only(
            right: 5,
          ),
          child: InkWell(
            onTap: () => _showMyDialogProfileAction(context),
            child: Icon(
              Icons.settings,
              size: 30,
              color: Colors.grey,
            ),
          ),
        )
      ],
      centerTitle: true,
      backgroundColor: Colors.transparent,
      elevation: 0.0,
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(50);
}
