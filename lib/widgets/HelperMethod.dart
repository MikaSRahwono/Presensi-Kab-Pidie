part of '_widgets.dart';

class HelperMethod {
  final _myFuture = AsyncMemoizer<bool>();

  /// ----------------------------------------
  /// Reusable Method
  /// ----------------------------------------

  Future<Position> getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location service are disabled');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request location'
      );
    }
    return await Geolocator.getCurrentPosition();
  }

  Future<String> forgetPass(email) async {
    var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            'http://35.223.12.163/account/req-change-pass'));
    request.fields.addAll({'email': email});
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      return (await response.stream.bytesToString());
    } else {
      return ("Error");
    }
  }

  Future<String> otpCheck(String email, String kode) async {
    var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            'http://35.223.12.163/account/check-otp'));
    request.fields.addAll({'email': email, 'unique_code': kode});
    http.StreamedResponse response = await request.send();
    String stringResponse = await response.stream.bytesToString();
    if (response.statusCode == 200) {
      return (stringResponse);
    } else {
      return ('Error');
    }
  }

  Future<String> changeForgetPassword(
      String email, String pass, String confPass) async {
    var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            'http://35.223.12.163/account/change-forget-pass'));
    request.fields
        .addAll({'email': email, 'password': pass, 'confirm_password': confPass});

    http.StreamedResponse response = await request.send();
    String stringResponse = await response.stream.bytesToString();
    Map resMap = jsonDecode(stringResponse);

    if (resMap['status'] == "Success") {
      return (await stringResponse);
    } else if (resMap['detail'] ==
        "Authentication credentials were not provided.") {
      return ("Authentication credentials were not provided.");
    } else {
      return ("Password tidak sama");
    }
  }

  Future<bool> loginCheckFuture(BuildContext context, UserProvider dataUser, HelperDialog helperDialog) async {
    return _myFuture.runOnce(() async {
      if (await isLoggedIn(dataUser)) {
        await dataUser.getDataPresensi(this);
        if (dataUser.getTokenIsValid()! == false) {
          if (context.mounted) {
            logout(dataUser);
            helperDialog.checkAuthDialog(context);
          }
        }
        await dataUser.getDataUser(this);

        if (dataUser.getTokenIsValid()! == false) {
          if (context.mounted) {
            logout(dataUser);
            helperDialog.checkAuthDialog(context);
          }
        }

        await dataUser.getAllHistory(this);

        return true;
      }
      return false;
    });
  }

  void logout(UserProvider dataUser) {
    dataUser.setAccessToken(null);
    dataUser.setRefreshToken(null);
    dataUser.setFirstLogin(true);
    dataUser.jwtToken = null;
    dataUser.refreshToken = null;
    dataUser.firstLogin = true;
  }

  Future<bool> isLoggedIn(UserProvider dataUser) async {
    await dataUser.getAccessTokenStorage();
    return dataUser.jwtToken == null ? false : true;
  }

  /// ----------------------------------------
  /// API Service
  /// ----------------------------------------

  Future<http.Response> absenMasukApi(Map<String, String> encodeBody, String jwtToken) async {
    var res = await http.post(
      Uri.parse("http://35.223.12.163/presensi/"),
      headers: <String, String>{
        "Content-Type": "application/json; charset=UTF-8",
        "Accept": "application/json",
        "Authorization": "Bearer $jwtToken",
      },
      body: jsonEncode(encodeBody),
    );
    return res;
  }

  Future<http.Response> absenKeluarApi(Map<String, String> encodeBody, String jwtToken) async {
      var res = await http.put(
        Uri.parse("http://35.223.12.163/presensi/"),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8",
          "Accept": "application/json",
          "Authorization": "Bearer $jwtToken",
        },
        body: jsonEncode(encodeBody),
      );
      return res;
    }

  Future<http.Response> refreshTokenUserApi(String refreshToken) async {
    var res = await http.post(
        Uri.parse("http://35.223.12.163/api/token/refresh/"),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8",
          "Accept": "application/json",
        },
        body:jsonEncode(<String, String>{'refresh': refreshToken})
    );
    return res;

  }

  Future<http.Response> getDataUserApi(String jwtToken) async {
      var res = await http.get(
          Uri.parse('http://35.223.12.163/pegawai/info-pegawai'),
          headers: <String, String>{"Content-Type": "application/json",
            "Accept": "application/json",
            "Authorization": "Bearer $jwtToken",
          });
      return res;
    }

  Future<http.Response> attemptLogInApi(String nip, String password) async {
      var res = await http.post(
        Uri.parse(
            'http://35.223.12.163/account/login'),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8",
          "Accept": "application/json",
        },
        body: jsonEncode(<String, String>{'nip': nip, 'password': password}),
      );
      return res;
    }

  Future<http.Response> getDataPresensiApi(String jwtToken) async {
      var res = await http.get(
        Uri.parse("http://35.223.12.163/presensi/"),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8",
          "Accept": "application/json",
          "Authorization": "Bearer $jwtToken",
        },
      );
      return res;
  }

  Future<http.Response> forceChangePassApi(pass, confPass, String jwtToken) async {
      var res = await http.post(
        Uri.parse("http://35.223.12.163/account/force-change-pass"),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8",
          "Accept": "application/json",
          "Authorization": "Bearer $jwtToken",
        },
        body: jsonEncode(<String, String>{'password': pass, 'confirm_password': confPass}),
      );
      return res;
  }

  Future<http.Response> changePasswordApi(prevPass, pass, confPass, String jwtToken) async {
      var res = await http.post(
        Uri.parse("http://35.223.12.163/account/change-pass"),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8",
          "Accept": "application/json",
          "Authorization": "Bearer $jwtToken",
        },
        body: jsonEncode(<String, String>{'old_password':prevPass, 'password': pass, 'confirm_password': confPass}),
      );
      return res;
  }

  Future<http.Response> getHistoryPresensi(int bulan, String jwtToken) async {
    var url = "http://35.223.12.163/presensi/history?bulan=$bulan";
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

}