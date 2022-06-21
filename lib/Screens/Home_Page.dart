import 'package:flutter/material.dart';
import 'Home_C/Header.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Header(),
    );
  }
}
