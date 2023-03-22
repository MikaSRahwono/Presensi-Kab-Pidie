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
  String? jwtToken;
  String? refreshToken;
  bool firstLogin = true;

  Future<String?> setToken(String? token) async {
    await _storage.write(key: _tokenKey, value: token);
    return token;
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

  Future<http.Response> postRequestWithJWT(String url,Map<String, String> encodeBody) async {
    var res = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        "Content-Type": "application/json; charset=UTF-8",
        "Accept": "application/json",
        "Authorization": "Bearer $jwtToken",
      },
      body: jsonEncode(encodeBody),
    );
    return res;
  }

  Future<http.Response> getRequestWithJWT(String url) async {
    var res = await http.get(
      Uri.parse(url),
      headers: <String, String>{
        "Content-Type": "application/json; charset=UTF-8",
        "Accept": "application/json",
        "Authorization": "Bearer $jwtToken",
      },
    );
    return res;
  }

  Future<http.Response> deleteRequestWithJWT(String url,Map<String, String> encodeBody) async {
    var res = await http.delete(
      Uri.parse(url),
      headers: <String, String>{
        "Content-Type": "application/json; charset=UTF-8",
        "Accept": "application/json",
        "Authorization": "Bearer $jwtToken",
      },
    );
    return res;
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
      await setToken(resMap['tokens']['access']);
      // refreshToken = response.tokens.refresh;
      notifyListeners();


      return ("Berhasil");
    }
    else {
      return ("Error");
    }
  }

}
