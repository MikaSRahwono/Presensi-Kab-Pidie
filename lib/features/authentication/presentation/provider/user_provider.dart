import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;


import '../../data/model/jwt_response.dart';
import '../../data/model/user_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserProvider with ChangeNotifier {
  // Create storage
  final _storage = const FlutterSecureStorage();

  bool isLoading = false;
  final String _tokenKey = 'token';
  final String _refreshTokenKey = 'refresh_token';
  final String _flagFirstLoginKey = 'flag_first_login';
  String? jwtToken;
  String? refreshToken;
  bool firstLogin = true;

  Future<String?> setAccessToken(String? token) async {
    await _storage.write(key: _tokenKey, value: token);
    return token;
  }

  Future<String?> setRefreshToken(String? refreshToken) async {
    await _storage.write(key: _refreshTokenKey, value: refreshToken);
    return refreshToken;
  }
  Future<bool?> setFirstLogin(bool? flag) async {
    await _storage.write(key: _flagFirstLoginKey, value: flag.toString());

    return flag;
  }


  String? getAccessToken() {
    return jwtToken;
  }

  String? getRefreshToken(){
    return refreshToken;
  }


  bool? getFirstLogin(){
    return firstLogin;
  }


  // Future<http.Response> attemptLogIn(String nip, String password) async {
  //   var res = await http.post(
  //     Uri.parse('https://presensi-service-data-production.up.railway.app/account/login'),
  //     headers: <String, String>{
  //       "Content-Type": "application/json; charset=UTF-8",
  //       "Accept": "application/json",
  //     },
  //     body: jsonEncode(
  //         <String, String>{'nip': nip, 'password': password}),
  //   );
  //   JwtResponse response = jwtResponseFromJson(res.body);
  //   jwtToken = response.tokens.access;
  //   refreshToken = response.tokens.refresh;
  //   firstLogin = response.firstLogin;
  //   await setToken(response.tokens.access);
  //   notifyListeners();
  //   return res;
  // }

  Future<String> fetchToken(nip, pass) async {
    var request = http.MultipartRequest('POST', Uri.parse('https://presensi-service-data-production.up.railway.app/account/login'),

    );
    request.fields.addAll({
      'nip': nip,
      'password': pass
    },
    );

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var response_ = await response.stream.bytesToString();
      Map resMap = json.decode(response_);

      jwtToken = resMap['tokens']['access'];
      refreshToken =  resMap['tokens']['refresh'];
      firstLogin = resMap['first_login'];
      await setAccessToken(resMap['tokens']['access']);
      await setRefreshToken(resMap['tokens']['refresh']);
      await setFirstLogin(resMap['first_login']);
      // refreshToken = response.tokens.refresh;
      notifyListeners();


      return ("Berhasil");
    }
    else {
      return ("Error");
    }
  }

}
