part of '_provider.dart';

class UserProvider with ChangeNotifier {
  // Create storage
  final _storage = const FlutterSecureStorage();

  bool isLoading = false;
  final String _tokenKey = 'token';
  final String _refreshTokenKey = 'refresh_token';
  final String _flagFirstLoginKey = 'flag_first_login';
  final String _flagAbsensi = 'flag_absensi';
  final String _clockIn = "clock_in";
  final String _clockOut = "clock_Out";
  final String _flagDinas = "flag_dinas";
  String? jwtToken;
  String? refreshToken;
  String? flagAbsensi;
  String? clockIn;
  String? clockOut;
  String? flagDinas;
  bool firstLogin = true;
  Presensi? presensiModel;
  User? pegawaiModel;

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

  Future<String?> setFlagAbsensi(String? flagAbsensi) async {
    await _storage.write(key: _flagAbsensi, value: flagAbsensi.toString());
    flagAbsensi = _flagAbsensi;
    return flagAbsensi;
  }

  Future<String?> setClockIn(String? clock_in) async {
    await _storage.write(key: _clockIn, value: clock_in.toString());
    clockIn = clock_in;
    return clock_in;
  }

  Future<String?> setClockOut(String? clock_out) async {
    await _storage.write(key: _clockOut, value: clock_out.toString());
    clockOut = clock_out;
    return clock_out;
  }
  Future<String?> setFlagDinas(String? dinas) async {
    await _storage.write(key: _flagDinas, value: dinas.toString());
    flagDinas = dinas;
    return dinas;
  }
  String? getAccessToken() {
    return jwtToken;
  }

  String? getRefreshToken() {
    return refreshToken;
  }

  bool? getFirstLogin() {
    return firstLogin;
  }
  String? getFlagAbsensi() {
    return flagAbsensi;
  }
  String? getClockIn() {
    return clockIn;
  }
  String? getClockOut() {
    return clockOut;
  }
  String? getFlagDinas() {
    return flagDinas;
  }
  Presensi? getPresensi(){
    return presensiModel;
  }


  void logout() {
    jwtToken = null;
    refreshToken = null;
    firstLogin = true;
  }



  User? getUser(){
    return pegawaiModel;
  }
  Future<http.Response> postRequestWithJWT(
      String url, Map<String, String> encodeBody) async {
    var res = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        "Content-Type": "application/json; charset=UTF-8",
        "Accept": "application/json",
        "Authorization": "Bearer $jwtToken",
      },
      body: jsonEncode(encodeBody),
    );
    print("masuk post request with  jwt");
    print(res.body);
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
    // print("masuk get request with  jwt");
    // if (res.statusCode == 200) {
    //       print("masuk");
    //       presensiModel = Presensi.fromJson(jsonDecode(res.body));
    //
    //       notifyListeners();
    //       print(presensiModel?.status);
    //       return presensiModel;
    //     } else {
    //       print("gamasik");
    //       // If the server did not return a 200 OK response,
    //       // then throw an exception.
    //       throw Exception('Failed to get user detail');
    //     }
    return res;
  }
  // Future<User?> getDataUser() async {
  //   print("abcd");
  //   print(jwtToken);
  //   http.Response res = await http.post(
  //       Uri.parse('http://127.0.0.1:2020/api/auth/pasien'),
  //       headers: <String, String>{"Content-Type": "application/json",
  //         "Accept": "application/json",
  //         "Authorization": "Bearer $jwtToken",
  //       });
  //   print(res.statusCode);
  //   if (res.statusCode == 200) {
  //     print("masuk");
  //     pasienModel = User.fromJson(jsonDecode(res.body));
  //
  //     notifyListeners();
  //     return pasienModel;
  //   } else {
  //     print("gamasik");
  //     // If the server did not return a 200 OK response,
  //     // then throw an exception.
  //     throw Exception('Failed to get user detail');
  //   }

  Future<http.Response> deleteRequestWithJWT(
      String url, Map<String, String> encodeBody) async {
    var res = await http.delete(
      Uri.parse(url),
      headers: <String, String>{
        "Content-Type": "application/json; charset=UTF-8",
        "Accept": "application/json",
        "Authorization": "Bearer $jwtToken",
      },
    );
    print("masuk delete request with  jwt");
    return res;
  }

  Future<http.Response> putRequestWithJWT(
      String url, Map<String, String> encodeBody) async {
    var res = await http.put(
      Uri.parse(url),
      headers: <String, String>{
        "Content-Type": "application/json; charset=UTF-8",
        "Accept": "application/json",
        "Authorization": "Bearer $jwtToken",
      },
      body: jsonEncode(encodeBody),
    );
    print("masuk put request with  jwt");
    return res;
  }

  Future<User?> getDataUser() async {
    print(jwtToken);
    var res = await http.get(
        Uri.parse('http://10.0.2.2:8000/pegawai/info-pegawai'),
        headers: <String, String>{"Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "Bearer $jwtToken",
        });
    if (res.statusCode == 200) {
      print("masuk");
      pegawaiModel = User.fromJson(jsonDecode(res.body));

      notifyListeners();
      return pegawaiModel;
    } else {
      print("gamasik");
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to get user detail');
    }
  }


  Future<http.Response> attemptLogIn(String nip, String password) async {
    var res = await http.post(
      Uri.parse(
          'http://127.0.0.1:8000/account/login'),
      headers: <String, String>{
        "Content-Type": "application/json; charset=UTF-8",
        "Accept": "application/json",
      },
      body: jsonEncode(<String, String>{'nip': nip, 'password': password}),
    );
    if (res.statusCode == 200){
      JwtResponse response = jwtResponseFromJson(res.body);
      jwtToken = response.tokens.access;
      refreshToken = response.tokens.refresh;
      firstLogin = response.firstLogin;
      await setAccessToken(jwtToken);
      await setFirstLogin(firstLogin);
      await setRefreshToken(refreshToken);
      notifyListeners();
      return res;
    }
    else {
      return res;
    }
  }

  Future<Presensi?> getData(url) async {
  var res = await http.get(
    Uri.parse(url),
    headers: <String, String>{
    "Content-Type": "application/json; charset=UTF-8",
    "Accept": "application/json",
    "Authorization": "Bearer $jwtToken",
    },
  );
  if (res.statusCode == 200) {
    presensiModel = Presensi.fromJson(jsonDecode(res.body));

    notifyListeners();
    return presensiModel;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to get user detail');
  }
}

  Future<String> forceChangePass(pass, confPass) async {
    var token = getAccessToken() ?? "";
    var headers = {'Authorization': 'Bearer $token'};
    var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            'http://127.0.0.1:8000/account/force-change-pass'));
    request.fields.addAll({'password': pass, 'confirm_password': confPass});

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    String stringResponse = await response.stream.bytesToString();
    Map resMap = json.decode(stringResponse);

    if (resMap['status'] == "Success") {
      return (await stringResponse);
    } else if (resMap['detail'] ==
        "Authentication credentials were not provided.") {
      return ("Authentication credentials were not provided.");
    } else {
      return ("Password tidak sama");
    }
  }

  Future<String> changePassword(prevPass, pass, confPass) async {
    var token = getAccessToken() ?? "";
    var headers = {'Authorization': 'Bearer ' + token};
    var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            'http://127.0.0.1:8000/account/change-pass'));
    request.fields.addAll({'old_password':prevPass, 'password': pass, 'confirm_password': confPass});

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    String stringResponse = await response.stream.bytesToString();
    Map resMap = json.decode(stringResponse);

    print(resMap);

    if (resMap['status'] == "Success") {
      return (await stringResponse);
    } else if (resMap['detail'] ==
        "Authentication credentials were not provided.") {
      return ("Authentication credentials were not provided.");
    } else if (resMap["message"] == "Password lama tidak sesuai") {
      return ("Password lama tidak sesuai");
    } else {
      return ("Password tidak sama");
    }
  }
}
