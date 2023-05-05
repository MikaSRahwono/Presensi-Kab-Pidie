part of '_pages.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  static List<Tab> historyTabs = <Tab>[];

  void setMonth() {
    historyTabs.clear();
    var now = new DateTime.now();
    var formatter = new DateFormat('MMMM');
    for (int i = 5; i >= 0; i--){
      var dateMonth = new DateTime(now.year, now.month - i, now.day);
      String month = formatter.format(dateMonth);
      historyTabs.add(Tab(child: Text(month),));
    }
    print(historyTabs);
  }

  Widget tabBarView() {
    return TabBarView(
        children: historyTabs.map((e) {
          return cardPresensi();
        }).toList()
    );
  }
  Widget cardPresensi() {
    Widget presensiMasuk(){
      return Container(
        margin: EdgeInsets.symmetric(vertical: 10.h),
        child: Row(
          children: [
            Icon(Icons.login, size: 30.w, color: Color.fromRGBO(130, 83, 240, 1),),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("MASUK", style: TextStyle(fontWeight: FontWeight.bold),),
                  Text("Ket Masuk", style: TextStyle(color: Colors.black54),)
                ],
              ),
            ),
            Expanded(child: SizedBox()),
            Text("12:00", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25.h),)
          ],
        ),
      );
    }
    Widget presensiKeluar(){
      return Container(
        margin: EdgeInsets.symmetric(vertical: 10.h),
        child: Row(
          children: [
            Icon(Icons.logout, size: 30.w, color: Color.fromRGBO(130, 83, 240, 1),),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("KELUAR", style: TextStyle(fontWeight: FontWeight.bold),),
                  Text("Ket Keluar", style: TextStyle(color: Colors.black54),)
                ],
              ),
            ),
            Expanded(child: SizedBox()),
            Text("12:00", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25.h),)
          ],
        ),
      );
    }
    Widget dailyPresensi(){
      return Container(
        margin: EdgeInsets.symmetric(vertical: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("01 Maret 2023"),
            presensiMasuk(),
            presensiKeluar()
          ],
        ),
      );
    }
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
        child: Column(
          children: [
            dailyPresensi(),
            dailyPresensi(),
            dailyPresensi(),
            dailyPresensi(),
          ],
        ),
      ),
    );
  }
  PreferredSizeWidget appBarWithTabs() {
    return AppBar(
      automaticallyImplyLeading: true,
      centerTitle: false,
      title: Text("Riwayat Presensi"),
      leading: IconButton(
        icon: Icon(Icons.arrow_back_outlined),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      bottom: TabBar(
        padding: EdgeInsets.symmetric(horizontal: 30.w),
        isScrollable: true,
        labelColor: Colors.black,
        tabs: historyTabs,
      ),
    );
  }

  /// ---------------------------------------------
  /// BUILD
  /// ---------------------------------------------
  @override
  Widget build(BuildContext context) {
    setMonth();
    return DefaultTabController(
      length: historyTabs.length,
      initialIndex: 5,
      child: Scaffold(
        extendBody: true,
        appBar: appBarWithTabs(),
        backgroundColor: Colors.white,
        body: tabBarView()
      ),
    );
  }
}
