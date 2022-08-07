import 'package:flutter/material.dart';

class TextFieldCard extends StatefulWidget {
  const TextFieldCard(
      {Key? key,
      required this.controller,
      required this.originalHeight,
      required this.headerText, required this.width})
      : super(key: key);
  final TextEditingController controller;
  final double originalHeight;
  final String headerText;
  final double width;
  @override
  State<TextFieldCard> createState() => _TextFieldCardState();
}

class _TextFieldCardState extends State<TextFieldCard> {
  double width = 200;
  double? orgHeight;
  double height = 0;
  Color iconColor = Colors.black;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    orgHeight = widget.originalHeight;
    width = widget.width;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: width,
            child: Text(
              widget.headerText,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
            ),
          ),
          Container(
            width: width,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Column(
              children: [
                Container(
                  width: width,
                  height: height + orgHeight!,
                  child: TextField(
                    controller: widget.controller,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    minLines: 1000,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(5),
                      enabledBorder: InputBorder.none,
                      border: InputBorder.none,
                    ),
                  ),
                ),
                Container(
                  width: width,
                  height: 17,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        child: Icon(
                          Icons.align_horizontal_right_rounded,
                          color: iconColor,
                          size: 15,
                        ),
                        onLongPressMoveUpdate: (val) {
                          height = val.offsetFromOrigin.dy;
                          if (height + orgHeight! < widget.originalHeight) {
                            height = 0;
                            orgHeight = widget.originalHeight;
                          }
                          setState(() {});
                        },
                        onLongPressStart: (val) {
                          iconColor = Colors.blue;
                        },
                        onLongPressEnd: (val) {
                          iconColor = Colors.black;
                          orgHeight = height + orgHeight!;
                          height = 0;
                          setState(() {});
                        },
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
