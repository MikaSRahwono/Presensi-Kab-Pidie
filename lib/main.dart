import 'package:flutter/material.dart';
import 'package:presensi_mobileapp/main_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'features/authentication/presentation/provider/_provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => UserProvider()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Presensi',
        theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'poppins'),
        home: const MainPage(startIndex: 0),
      ),
      designSize: const Size(390, 844),
    );
  }
}
