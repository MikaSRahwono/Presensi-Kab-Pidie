part of '_provider.dart';

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

  String? getRefreshToken() {
    return refreshToken;
  }


  bool? getFirstLogin() {
    return firstLogin;
  }


  Future<http.Response> attemptLogIn(String nip, String password) async {
    var res = await http.post(
      Uri.parse(
          'https://presensi-service-data-production.up.railway.app/account/login'),
      headers: <String, String>{
        "Content-Type": "application/json; charset=UTF-8",
        "Accept": "application/json",
      },
      body: jsonEncode(
          <String, String>{'nip': nip, 'password': password}),
    );
    JwtResponse response = jwtResponseFromJson(res.body);
    jwtToken = response.tokens.access;
    refreshToken = response.tokens.refresh;
    firstLogin = response.firstLogin;
    print(jwtToken);
    print(refreshToken);
    print(firstLogin);
    await setAccessToken(jwtToken);
    await setFirstLogin(firstLogin);
    await setRefreshToken(refreshToken);
    notifyListeners();
    return res;
  }

  Future<String> fetchToken(nip, pass) async {
    var request = http.MultipartRequest('POST', Uri.parse(
        'https://presensi-service-data-production.up.railway.app/account/login'),
    );
    request.fields.addAll({
      'nip': nip,
      'password': pass
    },
    );
    http.StreamedResponse response = await request.send();

    var response_ = await response.stream.bytesToString();
    Map resMap = json.decode(response_);

    if (resMap['message'] != "Invalid NIP or password") {
      jwtToken = resMap['tokens']['access'];
      refreshToken = resMap['tokens']['refresh'];
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

  Future<String> forceChangePass (pass, confPass) async {
    var token = getAccessToken() ?? "";
    var headers = {
      'Authorization': 'Bearer ' + token
    };
    var request = http.MultipartRequest(
        'POST', Uri.parse('https://presensi-service-data-production.up.railway.app/account/force-change-pass'));
    request.fields.addAll({
      'password': pass,
      'confirm_password': confPass
    });

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    String stringResponse = await response.stream.bytesToString();
    Map resMap = json.decode(stringResponse);

    print(response.statusCode);

    if (resMap['status'] == "Success") {
      return(await stringResponse);
    }
    else if (resMap['detail'] == "Authentication credentials were not provided."){
      return("Authentication credentials were not provided.");
    } else {
      return("Password tidak sama");
    }
  }
}