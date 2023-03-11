import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';

import '../provider/user_provider.dart';

class ComingSoon extends StatefulWidget {
  const ComingSoon({Key? key}) : super(key: key);

  @override
  State<ComingSoon> createState() => _ComingSoonState();
}

class _ComingSoonState extends State<ComingSoon> {

  // Cara manggil token
  String _token = '';
  String _refreshToken = '';
  String _flag = '';

  @override
  void initState() {
    super.initState();
    readToken();
    readRefreshToken();
    readFlag();

  }

  Future<String?> readToken() async {
    String? token = await FlutterSecureStorage().read(key: 'token');
    if (token != null){
      return _token = token;
    }
    else{
      return token = '';
    }
  }

  Future<String?> readRefreshToken() async {
    String? refreshToken = await FlutterSecureStorage().read(key: 'refresh_token');
    if (refreshToken != null){
      return _refreshToken = refreshToken;
    }
    else{
      return refreshToken = '';
    }
  }

  Future<String?> readFlag() async {
    String? flagFirstLogin = await FlutterSecureStorage().read(key: 'flag_first_login');
    if (flagFirstLogin != null){
      return _flag = flagFirstLogin;
    }
    else{
      return flagFirstLogin = '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final dataUser = Provider.of<UserProvider>(context,listen: false);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(80.0),
        child: Center(
          child: Column(
            children: [
             Padding(
               padding: const EdgeInsets.all(16.0),
               child: SingleChildScrollView(
                 scrollDirection: Axis.horizontal,
                 child: Row(
                   children: [
                     Text("Access Token:"),
                     SizedBox(width: 20,),
                     Text(_token, style: TextStyle(fontSize: 20, color: Colors.black), ),
                   ],
                 ),
               ),
             ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Text("Refresh Token:"),
                      SizedBox(width: 20,),
                      Text(_refreshToken, style: TextStyle(fontSize: 20, color: Colors.black), ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Text("flag:"),
                      SizedBox(width: 20,),
                      Text(_flag, style: TextStyle(fontSize: 20, color: Colors.black), ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
