import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage();
  static final String pathName = 'WelcomePage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xff333333),
              Color(0xff232323),
            ],
          ),
        ),
      ),
    );
  }
}
