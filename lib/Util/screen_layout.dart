import 'dart:ui';

class Layout {
  late double width;
  late double height;
  late Size size;
  bool isAndroid = false;
  Layout({
    required this.size,
  }) {
    width = size.width;
    height = size.height;
    isAndroid = width < 600 ? true : false;
  }
}
