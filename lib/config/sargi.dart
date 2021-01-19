import 'package:flutter/material.dart';

class Sargi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Opacity(
          opacity: 0.3,
          child: Center(
            child: Image.asset(
              'assets/img/fire.gif',
              fit: BoxFit.fill,
            ),
          )),
    );
  }
}
