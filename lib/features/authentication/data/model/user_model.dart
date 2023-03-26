// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    required this.nip,
    required this.nama,
    required this.idJabatan,
    required this.idInstansi,
    required this.email,
  });

  String nip;
  String nama;
  String idJabatan;
  String idInstansi;
  String email;

  factory User.fromJson(Map<String, dynamic> json) => User(
    nip: json["nip"],
    nama: json["nama"],
    idJabatan: json["id_jabatan"],
    idInstansi: json["id_instansi"],
    email: json["email"],
  );

  Map<String, dynamic> toJson() => {
    "nip": nip,
    "nama": nama,
    "id_jabatan": idJabatan,
    "id_instansi": idInstansi,
    "email": email,
  };
}
