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
  // final String _lockedDinas = "";
  String? jwtToken;
  String? refreshToken;
  String? flagAbsensi;
  String? clockIn;
  String? clockOut;
  String? flagDinas;
  bool firstLogin = true;
  bool isLockedDinas = false;
  bool tokenIsValid = true;
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
  // Future<String?> setLockedDinas(String? isLockedDinas) async {
  //   await _storage.write(key: _lockedDinas, value: isLockedDinas);
  //   this.isLockedDinas = isLockedDinas == 'true';
  //   return isLockedDinas;
  // }

  bool setLockedDinas(bool Locked) {
    this.isLockedDinas = Locked;
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
    }
    return jwtToken;
  }

  bool getLockedDinas()  {
    return isLockedDinas;
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
  bool? getTokenIsValid(){
    return tokenIsValid;
  }

  User? getUser(){
    return pegawaiModel;
  }

  /// ----------------------------------------
  /// Methods
  /// ----------------------------------------

  void logout() {
    jwtToken = null;
    refreshToken = null;
    firstLogin = true;
  }

  Future<bool> isLoggedIn() async {
    await getAccessTokenStorage();
    return jwtToken == null ? false : true;
  }

  Future<http.Response> absenMasuk(Map<String, String> encodeBody, BuildContext context) async {
    try {
      var res = await http.post(
        Uri.parse("http://127.0.0.1:8000/presensi/"),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8",
          "Accept": "application/json",
          "Authorization": "Bearer $jwtToken",
        },
        body: jsonEncode(encodeBody),
      );
      switch (res.statusCode) {
        case 200:
          return res;
        case 403:
          await refreshTokenUser();
          if (tokenIsValid) {
            if (!context.mounted){
            }
            return absenMasuk(encodeBody, context);
          }
          else {
            if (context.mounted){
              logout();
              sessionTimeout(context);
            }
            return res;
          }
        case 500:
          throw HttpException("Server Error");
        default:
          var stringRes = jsonDecode(res.body);
          throw HttpException(stringRes['message']);
      }
    }
    catch (e){
      throw HttpException(e.toString());
    }
  }

  Future<http.Response> absenKeluar(Map<String, String> encodeBody, BuildContext context) async {
    try{
      var res = await http.put(
        Uri.parse("http://127.0.0.1:8000/presensi/"),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8",
          "Accept": "application/json",
          "Authorization": "Bearer $jwtToken",
        },
        body: jsonEncode(encodeBody),
      );
      switch (res.statusCode) {
        case 200:
          return res;
        case 403:
          await refreshTokenUser();
          if (tokenIsValid) {
            if (!context.mounted){
            }
            return absenMasuk(encodeBody, context);
          }
          else {
            if (context.mounted){
              logout();
              sessionTimeout(context);
            }
            return res;
          }
        case 500:
          throw HttpException("Server Error");
        default:
          var stringRes = jsonDecode(res.body);
          throw HttpException(stringRes['message']);
      }
    }
    catch(e) {
      throw HttpException(e.toString());
    }
  }

  Future<bool> refreshTokenUser() async {
    var res = await http.post(
        Uri.parse("http://127.0.0.1:8000/api/token/refresh/"),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8",
          "Accept": "application/json",
        },
        body:jsonEncode(<String, String>{'refresh': "$refreshToken"})
    );
    if (res.statusCode == 200){
      final jsonData = json.decode(res.body);
      setAccessToken(jsonData['access']);
      jwtToken = jsonData['access'];
      tokenIsValid = true;

      return tokenIsValid;
    }else {
      tokenIsValid = false;
      return tokenIsValid;
    }
  }

  Future<User?> getDataUser() async {
    try {
      var res = await http.get(
          Uri.parse('http://127.0.0.1:8000/pegawai/info-pegawai'),
          headers: <String, String>{"Content-Type": "application/json",
            "Accept": "application/json",
            "Authorization": "Bearer $jwtToken",
          });
      switch (res.statusCode) {
        case 200:
          pegawaiModel = User.fromJson(jsonDecode(res.body));
          notifyListeners();
          return pegawaiModel;
        case 403:
          await refreshTokenUser();
          if (tokenIsValid){
            return getDataUser();
          }
          else{
            return pegawaiModel;
          }
        case 500:
          throw HttpException("Server Error");
        default:
          var stringRes = jsonDecode(res.body);
          throw HttpException(stringRes['message']);
      }
    }
    catch(e) {
      throw HttpException(e.toString());
    }
  }

  Future<http.Response> attemptLogIn(String nip, String password) async {
    try{
      var res = await http.post(
        Uri.parse(
            'http://127.0.0.1:8000/account/login'),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8",
          "Accept": "application/json",
        },
        body: jsonEncode(<String, String>{'nip': nip, 'password': password}),
      );
      switch (res.statusCode) {
        case 200:
          JwtResponse response = jwtResponseFromJson(res.body);
          jwtToken = response.tokens.access;
          refreshToken = response.tokens.refresh;
          firstLogin = response.firstLogin;
          await setAccessToken(jwtToken);
          await setFirstLogin(firstLogin);
          await setRefreshToken(refreshToken);
          tokenIsValid = true;
          await getDataPresensi();
          await getDataUser();

          notifyListeners();
          return res;
        case 500:
          throw HttpException("Server Error");
        default:
          var stringRes = jsonDecode(res.body);
          throw HttpException(stringRes['message']);
      }
    }
    catch(e) {
      throw HttpException(e.toString());
    }
  }

  Future<Presensi?> getDataPresensi() async {
    try {
      var res = await http.get(
        Uri.parse("http://127.0.0.1:8000/presensi/"),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8",
          "Accept": "application/json",
          "Authorization": "Bearer $jwtToken",
        },
      );
      switch (res.statusCode) {
        case 200:
          var stringRes = jsonDecode(res.body);
          if(stringRes['status'] == null){
            setFlagDinas("");
            setLockedDinas(false);
            stringRes['data'] = null;
          } else {
            setLockedDinas(true);
          }
          presensiModel = Presensi.fromJson(stringRes);
          notifyListeners();
          return presensiModel;
        case 403:
          await refreshTokenUser();
          if (tokenIsValid){
            return getDataPresensi();
          }
          else{
            return presensiModel;
          }
        case 500:
          throw HttpException("Server Error");
        default:
          var stringRes = jsonDecode(res.body);
          throw HttpException(stringRes['message']);
      }
    }
    catch(e) {
      throw HttpException(e.toString());
    }
}

  Future<http.Response?> forceChangePass(pass, confPass, BuildContext context) async {
    try{
      var res = await http.post(
        Uri.parse("http://127.0.0.1:8000/account/force-change-pass"),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8",
          "Accept": "application/json",
          "Authorization": "Bearer $jwtToken",
        },
        body: jsonEncode(<String, String>{'password': pass, 'confirm_password': confPass}),
      );

      switch (res.statusCode) {
        case 200:
          return res;
        case 403:
          await refreshTokenUser();
          if (tokenIsValid) {
            if (!context.mounted){
            }
            return forceChangePass(pass, confPass, context);
          }
          else {
            if (context.mounted){
              logout();
              sessionTimeout(context);
            }
          }
          break;
        case 500:
          throw HttpException("Server Error");
        default:
          var stringRes = jsonDecode(res.body);
          throw HttpException(stringRes['message']);
      }
    }
    catch(e) {
      throw HttpException(e.toString());
    }
  }

  Future<http.Response?> changePassword(prevPass, pass, confPass, BuildContext context) async {
    try {
      var res = await http.post(
        Uri.parse("http://127.0.0.1:8000/account/change-pass"),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8",
          "Accept": "application/json",
          "Authorization": "Bearer $jwtToken",
        },
        body: jsonEncode(<String, String>{'old_password':prevPass, 'password': pass, 'confirm_password': confPass}),
      );

      switch (res.statusCode) {
        case 200:
          return res;
        case 403:
          await refreshTokenUser();
          if (tokenIsValid) {
            if (!context.mounted){
            }
            return changePassword(prevPass, pass, confPass, context);
          }
          else {
            if (context.mounted){
              logout();
              sessionTimeout(context);
            }
          }
          break;
        case 500:
          throw HttpException("Server Error");
        default:
          var stringRes = jsonDecode(res.body);
          throw HttpException(stringRes['message']);
      }
    }
    catch(e) {
      throw HttpException(e.toString());
    }
  }

  /// ----------------------------------------
  /// Widgets
  /// ----------------------------------------
  void sessionTimeout(context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) =>
            CupertinoAlertDialog(
              title: Text("Sesi telah habis",
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize:  18.sp,
                  fontWeight: FontWeight.w500,
                ),),
              content:  Text("Maaf sesi anda telah habis, mohon untuk login kembali!",
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize:  12.sp,
                ),),
              actions: <CupertinoDialogAction>[
                CupertinoDialogAction(
                  child: Text("Oke"),
                  onPressed: (){
                    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                        LoginPage()), (Route<dynamic> route) => false);
                  },
                ),
              ],
            ));
  }
}

class HttpException implements Exception {
  final String message;

  HttpException(this.message);  // Pass your message in constructor.

  @override
  String toString() {
    return message;
  }
}