part of '_model.dart';

Presensi presensiFromJson(String str) => Presensi.fromJson(json.decode(str));

String presensiToJson(Presensi data) => json.encode(data.toJson());

class Presensi {
  Presensi({
    required this.status,
    required this.data,
  });

  String? status;
  Data? data;

  factory Presensi.fromJson(Map<String, dynamic>? json) => Presensi(
    status: json!["status"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data?.toJson(),
  };
}

class Data {
  Data({
    required this.id,
    required this.tanggalAbsensi,
    required this.jamAbsensiMasuk,
    required this.lokasiAbsensiMasuk,
    this.keteranganAbsensiMasuk,
    this.jamAbsensiKeluar,
    this.lokasiAbsensiKeluar,
    this.keteranganAbsensiKeluar,
    required this.status,
    this.keterangan,
    required this.nip,
    required this.instansi,
    required this.pemerintah,
  });

  int id;
  DateTime tanggalAbsensi;
  String jamAbsensiMasuk;
  String lokasiAbsensiMasuk;
  dynamic keteranganAbsensiMasuk;
  dynamic jamAbsensiKeluar;
  dynamic lokasiAbsensiKeluar;
  dynamic keteranganAbsensiKeluar;
  String status;
  dynamic keterangan;
  String nip;
  int instansi;
  int pemerintah;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    tanggalAbsensi: DateTime.parse(json["tanggal_absensi"]),
    jamAbsensiMasuk: json["jam_absensi_masuk"],
    lokasiAbsensiMasuk: json["lokasi_absensi_masuk"],
    keteranganAbsensiMasuk: json["keterangan_absensi_masuk"],
    jamAbsensiKeluar: json["jam_absensi_keluar"] == "null" ? null : json["jam_absensi_keluar"],
    lokasiAbsensiKeluar: json["lokasi_absensi_keluar"],
    keteranganAbsensiKeluar: json["keterangan_absensi_keluar"],
    status: json["status"],
    keterangan: json["keterangan"],
    nip: json["nip"],
    instansi: json["instansi"],
    pemerintah: json["pemerintah"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "tanggal_absensi": "${tanggalAbsensi.year.toString().padLeft(4, '0')}-${tanggalAbsensi.month.toString().padLeft(2, '0')}-${tanggalAbsensi.day.toString().padLeft(2, '0')}",
    "jam_absensi_masuk": jamAbsensiMasuk,
    "lokasi_absensi_masuk": lokasiAbsensiMasuk,
    "keterangan_absensi_masuk": keteranganAbsensiMasuk,
    "jam_absensi_keluar": jamAbsensiKeluar,
    "lokasi_absensi_keluar": lokasiAbsensiKeluar,
    "keterangan_absensi_keluar": keteranganAbsensiKeluar,
    "status": status,
    "keterangan": keterangan,
    "nip": nip,
    "instansi": instansi,
    "pemerintah": pemerintah,
  };
}
