import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:presensi_mobileapp/splash_screen.dart';
import 'package:async/async.dart';
import 'package:provider/provider.dart';

import 'features/authentication/presentation/pages/_pages.dart';
import 'features/authentication/presentation/provider/_provider.dart';
import 'features/home/presentation/page/_pages.dart';

class CheckAuth extends StatefulWidget {
  @override
  _CheckAuthState createState() => _CheckAuthState();
}

class _CheckAuthState extends State<CheckAuth> {
  bool isAuth = false;
  final _myFuture = AsyncMemoizer<bool>();

  Future<bool> loginCheckFuture(UserProvider dataUser) async {
    return _myFuture.runOnce(() async {
      if (await dataUser.isLoggedIn()) {
        await dataUser.getDataPresensi();
        if (dataUser.getTokenIsValid()! == false) {
          if (mounted) {
            dataUser.logout();
            showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) =>
                    CupertinoAlertDialog(
                      title: Text("Sesi telah habis",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w500,
                        ),),
                      content: Text(
                        "Maaf sesi anda telah habis, mohon untuk login kembali!",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 12.sp,
                        ),),
                      actions: <CupertinoDialogAction>[
                        CupertinoDialogAction(
                          child: Text("Oke"),
                          onPressed: () {
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(builder: (context) =>
                                    LoginPage()), (Route<
                                dynamic> route) => false);
                          },
                        ),
                      ],
                    ));
          }
        }
        await dataUser.getDataUser();
          if (dataUser.getTokenIsValid()! == false) {
            if (mounted) {
              dataUser.logout();
              showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) =>
                      CupertinoAlertDialog(
                        title: Text("Sesi telah habis",
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w500,
                          ),),
                        content: Text(
                          "Maaf sesi anda telah habis, mohon untuk login kembali!",
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 12.sp,
                          ),),
                        actions: <CupertinoDialogAction>[
                          CupertinoDialogAction(
                            child: Text("Oke"),
                            onPressed: () {
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(builder: (context) =>
                                      LoginPage()), (
                                  Route<dynamic> route) => false);
                            },
                          ),
                        ],
                      ));
            }
          }
        return true;
      }
      return false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final UserProvider dataUser = Provider.of<UserProvider>(context);

    Widget child;
    return FutureBuilder(
        future: loginCheckFuture(dataUser),
        builder: (context, snapshot){

          if(snapshot.hasData){
            if(snapshot.data == true){
              child = HomePage();
            } else {
              child = LoginPage();
            }
          } else{
            // future hasnt completed yet
            child = SplashScreen();
          }

          return Scaffold(
            body: child,
          );
        }
    );
  }
}