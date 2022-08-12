import 'package:flutter/material.dart';
import '../../Widgets/CardMaker.dart';

Future<void> showAuthDialog(BuildContext context, Widget widget) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: true, // user must tap button!
    builder: (BuildContext context) {
      return CardMaker(
          body: widget,
          title: "",
          footerActionLeft: TextButton(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          footerActionRight: Container());
    },
  );
}

