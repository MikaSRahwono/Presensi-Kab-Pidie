part of '_model.dart';

MonthlyPresensi presensiFromJson(String str) => MonthlyPresensi.fromJson(json.decode(str));

String presensiToJson(MonthlyPresensi data) => json.encode(data.toJson());

class MonthlyPresensi {
  MonthlyPresensi({
    required this.month,
    required this.data,
  });

  int? month;
  List<Data>? data;

  factory MonthlyPresensi.fromJson(Map<String, dynamic>? json){
    Iterable list = json!['data'];
    print(list);
    List<Data> presensis = list == [] ? [] : list.map((e) => Data.fromJson(e)).toList();
    return MonthlyPresensi(
        month: json!["bulan"],
        data: presensis
    );
  }

  Map<String, dynamic> toJson() {
    List<String>? datas = data?.map((e) => e.toJson().toString()).toList();
    return {
      "month": month,
      "data": jsonEncode(datas),
    };
  }
}
