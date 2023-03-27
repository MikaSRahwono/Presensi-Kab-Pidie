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
  final String _lockedDinas = "";
  String? jwtToken;
  String? refreshToken;
  String? flagAbsensi;
  String? clockIn;
  String? clockOut;
  String? flagDinas;
  bool firstLogin = true;
  bool isLockedDinas = false;
  Presensi? presensiModel;
  User? pegawaiModel;

  /// -------------------------------------
  /// Setter and Getter
  /// -------------------------------------
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
  Future<String?> setLockedDinas(String? isLockedDinas) async {
    await _storage.write(key: _lockedDinas, value: isLockedDinas);
    this.isLockedDinas = isLockedDinas == 'true';
    return isLockedDinas;
  }

  Future<Presensi> setPresensiModel(Presensi presensiModel) async {
    this.presensiModel = presensiModel;
    return presensiModel;
  }

  Future<String?> getAccessTokenStorage() async {
    if (jwtToken == null){
      final token = await _storage.read(key: _tokenKey);
      jwtToken = token;
      print(token);
    }
    return jwtToken;
  }

  bool getLockedDinas()  {
    return isLockedDinas;
  }

  String? getAccessToken() {
    print(jwtToken);
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

  User? getUser(){
    return pegawaiModel;
  }

  /// ----------------------------------------
  /// Methods
  /// ----------------------------------------

  void logout() {
    print(jwtToken);
    jwtToken = null;
    refreshToken = null;
    firstLogin = true;
  }

  Future<bool> isLoggedIn() async {
    await getAccessTokenStorage();
    return jwtToken == null ? false : true;
  }

  Future<http.Response> absenMasuk(Map<String, String> encodeBody) async {
    var res = await http.post(
      Uri.parse("http://127.0.0.1:8000/presensi/"),
      headers: <String, String>{
        "Content-Type": "application/json; charset=UTF-8",
        "Accept": "application/json",
        "Authorization": "Bearer $jwtToken",
      },
      body: jsonEncode(encodeBody),
    );
    return res;
  }

  Future<http.Response> absenKeluar(Map<String, String> encodeBody) async {
    var res = await http.put(
      Uri.parse("http://127.0.0.1:8000/presensi/"),
      headers: <String, String>{
        "Content-Type": "application/json; charset=UTF-8",
        "Accept": "application/json",
        "Authorization": "Bearer $jwtToken",
      },
      body: jsonEncode(encodeBody),
    );
    return res;
  }

  Future<User?> getDataUser() async {
    var res = await http.get(
        Uri.parse('http://127.0.0.1:8000/pegawai/info-pegawai'),
        headers: <String, String>{"Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "Bearer $jwtToken",
        });
    if (res.statusCode == 200) {
      print(res.body);
      pegawaiModel = User.fromJson(jsonDecode(res.body));
      notifyListeners();
      return pegawaiModel;
    } else {
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
      await getDataPresensi();
      await getDataUser();
      print(getAccessToken());
      print(getAccessTokenStorage());
      print(jwtToken);
      notifyListeners();
      return res;
    }
    else {
      return res;
    }
  }

  Future<Presensi?> getDataPresensi() async {
  var res = await http.get(
    Uri.parse("http://127.0.0.1:8000/presensi/"),
    headers: <String, String>{
    "Content-Type": "application/json; charset=UTF-8",
    "Accept": "application/json",
    "Authorization": "Bearer $jwtToken",
    },
  );
  print(res.body);
  if (res.statusCode == 200) {
    var stringRes = jsonDecode(res.body);
    if(stringRes['status'] == null){
      setLockedDinas('false');
      stringRes['data'] = null;
    }
    setLockedDinas('true');
    presensiModel = Presensi.fromJson(stringRes);
    notifyListeners();
    return presensiModel;
  } else {
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
