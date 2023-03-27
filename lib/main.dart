
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:presensi_mobileapp/check_auth.dart';
import 'package:presensi_mobileapp/features/home/presentation/page/_pages.dart';
import 'package:presensi_mobileapp/main_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:presensi_mobileapp/features/authentication/presentation/pages/_pages.dart';
import 'package:presensi_mobileapp/main_page.dart';

import 'package:presensi_mobileapp/splash_screen.dart';
import 'package:provider/provider.dart';

import 'features/authentication/presentation/provider/_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.removeAfter(initialization);
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => UserProvider()),
    ],
    child: MyApp(),
  ));
}

Future initialization(BuildContext? context) async {
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
        theme: ThemeData(
            appBarTheme: AppBarTheme(
              color: Colors.white,
              foregroundColor: Colors.black,
              iconTheme: IconThemeData(color: Color.fromRGBO(130, 83, 240, 1)),
            ),
            primaryColor: Colors.black,
            fontFamily: 'poppins'),

        home: CheckAuth(),
      ),
      designSize: const Size(390, 844),
    );
  }
}