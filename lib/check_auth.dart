import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
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

  Future<bool> loginCheckFuture(UserProvider dataUser, BuildContext context) async {
    return _myFuture.runOnce(() async {
      if (await dataUser.isLoggedIn()) {
        if (context.mounted) {
          await dataUser.getDataPresensi(context);
        }else{
          throw Exception('Failed to get user detail');
        }
        if (context.mounted) {
          await dataUser.getDataUser(context);
        }else{
          throw Exception('Failed to get user detail');
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
        future: loginCheckFuture(dataUser, context),
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