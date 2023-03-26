import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:presensi_mobileapp/splash_screen.dart';
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

  Future<bool> loginCheckFuture(dataUser) async {
    var token = dataUser.jwtToken;
    if (token != null) {
      dataUser.getDataPresensi();
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final dataUser = Provider.of<UserProvider>(context);
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