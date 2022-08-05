import 'package:flutter/material.dart';

class Notify {
  static Future<void> error(BuildContext context, String message) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      barrierColor: Colors.transparent, // user must tap button!
      builder: (BuildContext context) {
        return Container(
          child: AlertDialog(
              backgroundColor: Colors.red,
              alignment: Alignment.topRight,
              elevation: 0,
              content: Container(
                color: Colors.red,
                height: 30,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      Icons.error_outline,
                      size: 30,
                      color: Colors.black,
                    ),
                    Text(
                      message,
                      style: TextStyle(color: Colors.black),
                    )
                  ],
                ),
              )),
        );
      },
    );
  }
  static Future<void> success(BuildContext context, String message) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      barrierColor: Colors.transparent, // user must tap button!
      builder: (BuildContext context) {
        return Container(
          child: AlertDialog(
              backgroundColor: Colors.green,
              alignment: Alignment.topRight,
              elevation: 0,
              content: Container(
                color: Colors.green,
                height: 30,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      Icons.check,
                      size: 30,
                      color: Colors.white,
                    ),
                    Text(
                      message,
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                ),
              )),
        );
      },
    );
  }
  static Future<void> loading(BuildContext context, String message) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.transparent, // user must tap button!
      builder: (BuildContext context) {
        return Container(
          child: AlertDialog(
              backgroundColor: Colors.transparent,
              alignment: Alignment.center,
              elevation: 0,
              content: Container(
                color: Colors.transparent,
                height: 70,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 60,
                      height: 60,
                      child: CircularProgressIndicator(
                        color: Colors.lime,
                      ),
                    ),
                  ],
                ),
              )),
        );
      },
    );
  }
}
