part of '_pages.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  static List<Widget> historyTabs = <Widget>[];
  static List<MonthlyPresensi?>? historyData = <MonthlyPresensi>[];
  static List<Widget> historyViewTabs = <Widget>[];



  Future<void> setMonth(UserProvider dataUser, HelperMethod helperMethod) async {
    historyTabs.clear();
    var now = DateTime.now();
    var formatter = DateFormat('MMMM');
    for (int i = 5; i >= 0; i--){
      var dateMonth = DateTime(now.year, now.month - i, now.day);
      String month = formatter.format(dateMonth);
      historyTabs.add(Tab(child: Text(month),));
    }
    historyData = dataUser.getHistoryPresensi();
  }

  setData() {
    historyViewTabs.clear();
    for (int i = 5; i >= 0; i--){
      historyViewTabs.add(
        cardPresensi(historyData![i]!)
      );
    }
  }

  Widget tabBarView() {
    setData();
    return TabBarView(
        children: historyViewTabs.map((e) {
          return e;
        }).toList()
    );
  }
  Widget cardPresensi(MonthlyPresensi monthlyPresensi) {
    Widget presensiMasuk(String jam, String ket){
      return Container(
        margin: EdgeInsets.symmetric(vertical: 10.h),
        child: Row(
          children: [
            SvgPicture.asset(
                'resources/images/svg/in.svg',
              width: 30.w,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("MASUK", style: TextStyle(fontWeight: FontWeight.bold),),
                  Text(ket, style: TextStyle(color: Colors.black54),)
                ],
              ),
            ),
            Expanded(child: SizedBox()),
            Text(jam.substring(0,5), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25.h),)
          ],
        ),
      );
    }
    Widget presensiKeluar(String jam, String ket){
      return Container(
        margin: EdgeInsets.symmetric(vertical: 10.h),
        child: Row(
          children: [
            SvgPicture.asset(
              'resources/images/svg/out.svg',
              width: 30.w,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("KELUAR", style: TextStyle(fontWeight: FontWeight.bold),),
                  Text(ket, style: TextStyle(color: Colors.black54),)
                ],
              ),
            ),
            Expanded(child: SizedBox()),
            Text(jam.substring(0,5), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25.h),)
          ],
        ),
      );
    }
    Widget dailyPresensi(Data dataPresensi){
      return Container(
        margin: EdgeInsets.symmetric(vertical: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(DateFormat('d MMMM y').format(dataPresensi.tanggalAbsensi)),
            presensiMasuk(dataPresensi.jamAbsensiMasuk, dataPresensi.keteranganAbsensiMasuk),
            dataPresensi.jamAbsensiKeluar != null ? presensiKeluar(dataPresensi.jamAbsensiKeluar, dataPresensi.keteranganAbsensiMasuk) : Container()
          ],
        ),
      );
    }

    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
        child: Column(
          children: <Widget>[...?monthlyPresensi.data?.map((e) => dailyPresensi(e)).toList()]
        ),
      ),
    );
  }
  PreferredSizeWidget appBarWithTabs() {
    return AppBar(
      automaticallyImplyLeading: true,
      title: Text("Riwayat Presensi"),
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
    HelperMethod helperMethod = HelperMethod();
    final dataUser = Provider.of<UserProvider>(context);
    setMonth(dataUser, helperMethod);
    return DefaultTabController(
      length: historyTabs.length,
      initialIndex: 5,
      child: Scaffold(
          extendBody: true,
          appBar: appBarWithTabs(),
          backgroundColor: Color.fromRGBO(246, 242, 255, 1),
          body: tabBarView()
      ),
    );
  }
}
