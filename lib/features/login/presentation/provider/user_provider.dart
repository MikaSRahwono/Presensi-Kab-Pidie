//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
//
// class UserProvider with ChangeNotifier {
//   // Create storage
//   final _storage = const FlutterSecureStorage();
//
//   bool isLoading = false;
//   final String _tokenKey = 'token';
//   String? jwtToken;
//   User? karyawanModel;
//   String? outputRegis;
//
//   Future<String?> setToken(String? token) async {
//     await _storage.write(key: _tokenKey, value: token);
//     return token;
//   }
//
//   String? getToken() {
//     return jwtToken;
//   }
//
//   User? getUser() {
//     return pasienModel;
//   }
//
//   Future<User?> setUser(User? pasien) async {
//     pasienModel = pasien;
//     notifyListeners();
//     return pasienModel;
//   }
//
//   Future<http.Response> attemptLogIn(String username, String password) async {
//     var res = await http.post(
//       Uri.parse('https://apap-103.cs.ui.ac.id/api/auth/login'),
//       headers: <String, String>{
//         "Content-Type": "application/json; charset=UTF-8",
//         "Accept": "application/json",
//       },
//       body: jsonEncode(
//           <String, String>{'username': username, 'password': password}),
//     );
//     JwtResponse response = jwtResponseFromJson(res.body);
//     jwtToken = response.token;
//     await setToken(response.token);
//     notifyListeners();
//     return res;
//   }
//
//   Future<http.Response> attemptSignUp(String nama, String username,
//       String password, String email, int umur) async {
//     var res = await http.post(
//       Uri.parse('https://apap-103.cs.ui.ac.id/api/auth/signup'),
//       headers: <String, String>{
//         "Content-Type": "application/json; charset=UTF-8",
//         "Accept": "application/json",
//       },
//       body: jsonEncode(<String, String>{
//         'nama': nama,
//         'username': username,
//         'password': password,
//         'email': email,
//         'umur': umur.toString()
//       }),
//     );
//     RegisterResponse response = registerResponseFromJson(res.body);
//     outputRegis = response.message;
//     notifyListeners();
//     return res;
//   }
//
//
//   Future<User?> getDataUser() async {
//     http.Response res = await http.post(
//         Uri.parse('https://apap-103.cs.ui.ac.id/api/auth/pasien'),
//         headers: <String, String>{
//           "Content-Type": "application/json",
//           "Accept": "application/json",
//           "Authorization": "Bearer $jwtToken",
//         });
//     print(res.statusCode);
//     if (res.statusCode == 200) {
//       pasienModel = User.fromJson(jsonDecode(res.body));
//
//       notifyListeners();
//       return pasienModel;
//     } else {
//       // If the server did not return a 200 OK response,
//       // then throw an exception.
//       throw Exception('Failed to get user detail');
//     }
//   }
//
//   Future<void> logout() async {
//     await _storage.delete(key: _tokenKey);
//     setToken(null);
//     notifyListeners();
//     setUser(null);
//   }
// }