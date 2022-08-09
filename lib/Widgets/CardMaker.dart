import 'package:flutter/material.dart';

import '../Util/screen_layout.dart';

class CardHeader extends StatelessWidget {
  const CardHeader({Key? key, required this.cardTitle}) : super(key: key);
  final String cardTitle;
  @override
  Widget build(BuildContext context) {
    Layout layout = Layout(size: MediaQuery.of(context).size);
    return Container(
      height: layout.height * 0.1,
      color: Colors.white,
      width: layout.isAndroid ? layout.width * 0.8 : layout.width * 0.5,
      child: Card(
        child: Center(
          child: Text(
            cardTitle,
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}

class CardFooter extends StatelessWidget {
  const CardFooter(
      {Key? key,
      required this.footerActionLeft,
      required this.footerActionRight})
      : super(key: key);
  final Widget footerActionLeft;
  final Widget footerActionRight;
  @override
  Widget build(BuildContext context) {
    Layout layout = Layout(size: MediaQuery.of(context).size);
    return Container(
      height: layout.height * 0.1,
      color: Colors.white,
      width: layout.isAndroid ? layout.width * 0.8 : layout.width * 0.5,
      child: Card(
        child: Center(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            footerActionLeft,
            footerActionRight,
          ],
        )),
      ),
    );
  }
}

class CardMaker extends StatelessWidget {
  const CardMaker(
      {Key? key,
      required this.body,
      required this.title,
      required this.footerActionLeft,
      required this.footerActionRight})
      : super(key: key);
  final Widget body;
  final Widget footerActionLeft;
  final Widget footerActionRight;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CardHeader(
                cardTitle: title,
              ),
              CardBody(body: body),
              CardFooter(
                  footerActionLeft: footerActionLeft,
                  footerActionRight: footerActionRight)
            ]));
  }
}

class CardBody extends StatelessWidget {
  const CardBody({Key? key, required this.body}) : super(key: key);
  final Widget body;
  @override
  Widget build(BuildContext context) {
    Layout layout = Layout(size: MediaQuery.of(context).size);
    return Container(
      height: layout.height * 0.7,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            color: Colors.white,
            width: layout.isAndroid ? layout.width * 0.8 : layout.width * 0.5,
            child: Padding(
              padding: EdgeInsets.all(4),
              child: body,
            ),
          )
        ],
      ),
    );
  }
}
