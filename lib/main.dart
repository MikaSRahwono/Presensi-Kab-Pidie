import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:presensi_mobileapp/main_page.dart';

void main() {
  runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder:(context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Presensi',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MainPage(startIndex: 0),
      ),
      designSize: const Size(390, 844),
    );
  }
}

