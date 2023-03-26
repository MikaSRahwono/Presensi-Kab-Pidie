part of '../_pages.dart';

Future<String> forgetPass(email) async {
  var request = http.MultipartRequest(
      'POST',
      Uri.parse(
          'http://127.0.0.1:8000//account/req-change-pass'));
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
          'http://127.0.0.1:8000/account/check-otp'));
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
          'http://127.0.0.1:8000/account/change-forget-pass'));
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
