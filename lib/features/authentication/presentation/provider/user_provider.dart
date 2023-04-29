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

  Future<http.Response> absenMasuk(Map<String, String> encodeBody, BuildContext context, HelperMethod helperMethod, UserProvider dataUser) async {
    try {
      var res = await helperMethod.absenMasukApi(encodeBody, jwtToken ?? '');
      switch (res.statusCode) {
        case 200:
          return res;
        case 403:
          await refreshTokenUser(helperMethod);
          if (tokenIsValid) {
            if (!context.mounted){
            }
            return absenMasuk(encodeBody, context, helperMethod, dataUser);
          }
          else {
            if (context.mounted){
              helperMethod.logout(dataUser);
            }
          }
          throw HttpException("Session Habis");
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

  Future<http.Response> absenKeluar(Map<String, String> encodeBody, BuildContext context, HelperMethod helperMethod, UserProvider dataUser) async {
    try{
      var res = await helperMethod.absenKeluarApi(encodeBody, jwtToken ?? '');
      switch (res.statusCode) {
        case 200:
          return res;
        case 403:
          await refreshTokenUser(helperMethod);
          if (tokenIsValid) {
            if (!context.mounted){
            }
            return absenMasuk(encodeBody, context, helperMethod, dataUser);
          }
          else {
            if (context.mounted){
              helperMethod.logout(dataUser);
            }
          }
          throw HttpException("Session Habis");
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

  Future<bool> refreshTokenUser(HelperMethod helperMethod) async {
    var res = await helperMethod.refreshTokenUserApi(refreshToken ?? '');
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

  Future<User?> getDataUser(HelperMethod helperMethod) async {
    try {
      var res = await helperMethod.getDataUserApi(jwtToken ?? '');
      switch (res.statusCode) {
        case 200:
          pegawaiModel = User.fromJson(jsonDecode(res.body));
          notifyListeners();
          return pegawaiModel;
        case 403:
          await refreshTokenUser(helperMethod);
          if (tokenIsValid){
            return getDataUser(helperMethod);
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

  Future<http.Response> attemptLogIn(String nip, String password, HelperMethod helperMethod) async {
    try{
      var res = await helperMethod.attemptLogInApi(nip, password);
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
          await getDataPresensi(helperMethod);
          await getDataUser(helperMethod);

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

  Future<Presensi?> getDataPresensi(HelperMethod helperMethod) async {
    try {
      var res = await helperMethod.getDataPresensiApi(jwtToken ?? '');
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
          await refreshTokenUser(helperMethod);
          if (tokenIsValid){
            return getDataPresensi(helperMethod);
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

  Future<http.Response?> forceChangePass(pass, confPass, BuildContext context, HelperMethod helperMethod, UserProvider dataUser) async {
    try{
      var res = await helperMethod.forceChangePassApi(pass, confPass, jwtToken ?? '');
      switch (res.statusCode) {
        case 200:
          return res;
        case 403:
          await refreshTokenUser(helperMethod);
          if (tokenIsValid) {
            if (!context.mounted){
            }
            return forceChangePass(pass, confPass, context, helperMethod, dataUser);
          }
          else {
            if (context.mounted){
              helperMethod.logout(dataUser);
            }
          }
          throw HttpException("Session Habis");
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

  Future<http.Response?> changePassword(prevPass, pass, confPass, BuildContext context, HelperMethod helperMethod, UserProvider dataUser) async {
    try {
      var res = await helperMethod.changePasswordApi(prevPass ,pass, confPass, jwtToken ?? '');
      switch (res.statusCode) {
        case 200:
          return res;
        case 403:
          await refreshTokenUser(helperMethod);
          if (tokenIsValid) {
            if (!context.mounted){
            }
            return changePassword(prevPass, pass, confPass, context, helperMethod, dataUser);
          }
          else {
            if (context.mounted){
              helperMethod.logout(dataUser);
            }
          }
          throw HttpException("Session Habis");
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
}