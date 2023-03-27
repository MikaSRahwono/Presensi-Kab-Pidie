import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final logo = FittedBox(
      fit: BoxFit.fitWidth,
      child: Padding(
        padding: const EdgeInsets.only(left: 22.0, right: 22.0),
        child: Hero(
          tag: 'hero',
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            child: Image.asset('resources/images/png/logo.png'),
          ),
        ),
      ),
    );
    return Scaffold(
      backgroundColor: Color(0xFFF6F2FF),
      body: Center(
        child: ListView(
          padding: const EdgeInsets.only(left: 18.0, right: 18.0),
          shrinkWrap: true,
          children: [
            logo,
          ],
        )
      ),
    );
  }
}
