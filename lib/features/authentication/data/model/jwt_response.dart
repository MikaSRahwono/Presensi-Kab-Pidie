// To parse this JSON data, do
//
//     final jwtResponse = jwtResponseFromJson(jsonString);

import 'dart:convert';

JwtResponse jwtResponseFromJson(String str) => JwtResponse.fromJson(json.decode(str));

String jwtResponseToJson(JwtResponse data) => json.encode(data.toJson());

class JwtResponse {
  JwtResponse({
    required this.message,
    required this.tokens,
    required this.firstLogin,
  });

  String message;
  Tokens tokens;
  bool firstLogin;

  factory JwtResponse.fromJson(Map<String, dynamic> json) => JwtResponse(
    message: json["message"],
    tokens: Tokens.fromJson(json["tokens"]),
    firstLogin: json["first_login"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "tokens": tokens.toJson(),
    "first_login": firstLogin,
  };
}

class Tokens {
  Tokens({
    required this.access,
    required this.refresh,
  });

  String access;
  String refresh;

  factory Tokens.fromJson(Map<String, dynamic> json) => Tokens(
    access: json["access"],
    refresh: json["refresh"],
  );

  Map<String, dynamic> toJson() => {
    "access": access,
    "refresh": refresh,
  };
}
