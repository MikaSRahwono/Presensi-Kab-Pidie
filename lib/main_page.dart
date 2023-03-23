
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'features/home/presentation/page/_pages.dart';
import 'features/profile/presentation/profile.dart';



class MainPage extends StatefulWidget {
  final int startIndex;

  const MainPage({Key? key, this.startIndex = 0}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final _children = <Widget>[
    const HomePage(),
    // // ComingSoonPage(),
    ProfilePage(),
  ];
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.startIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBody: true,
        backgroundColor: Colors.transparent,
        resizeToAvoidBottomInset: false,
        body: _children[_currentIndex],

    );
  }

  void onTabTapped(int index) {
    if (mounted) setState(() {
      _currentIndex = index;
    });
  }
}
