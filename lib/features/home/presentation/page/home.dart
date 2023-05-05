part of '_pages.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  late Future<Presensi?> dataFuturePresensi;
  bool _dinas = false;
  late String status = '';
  late String clockin = '';
  late String clokcOut = '';
  String lat = '';
  String longi = '';
  var isLoading = false;
  late Map<String, String> encodeBody = {};

  @override
  void initState() {
    super.initState();
    HelperMethod helperMethod = HelperMethod();

    helperMethod.getCurrentLocation().then((value) => {
      lat = '${value.latitude}',
      longi = '${value.longitude}'
    } );
  }
  @override
  void dispose() {
    // dispose any resources
    super.dispose();
  }

  /// -----------------------------------
  /// Methods & Widgets
  /// -----------------------------------
  Widget _buildAbsensiContent(BuildContext context) {
    final dataUser = Provider.of<UserProvider>(context);
    final dataPresensi = dataUser.getPresensi()?.data;
    String _clockIn = dataPresensi?.jamAbsensiMasuk.toString().substring(0, 5) ?? '- - : - -';
    String? _clockOut = dataPresensi?.jamAbsensiKeluar == null ? '- - : - -' : dataUser.getPresensi()?.data?.jamAbsensiKeluar.toString().substring(0, 5);
    String statClockIn = dataPresensi?.keteranganAbsensiMasuk ?? "";
    String statClockOut = dataPresensi?.keteranganAbsensiKeluar ?? "";
    String stat = dataUser.getPresensi()?.status ?? "";
    HelperDialog helperDialog = HelperDialog();
    HelperMethod helperMethod = HelperMethod();

    final batasWaktu = Padding(
      padding: EdgeInsets.only(
          top: 20.0.h, left: 32.w, right: 32.w
      ),
      child: Row(
        children: [
          Container(
            width: 157.w,
            height: 80.h,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius
                    .circular(8.r),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromRGBO(112, 144, 176, 0.2),
                    blurRadius: 40,
                    offset: Offset(0, 14),
                  ),
                ]
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 12.0.h),
                  child: Text("Batas waktu masuk", style: TextStyle(
                    fontSize: 12.sp,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                  ),),
                ),
                Padding(
                  padding: EdgeInsets.only(top:4.0.h,),
                  child: Text("09.00", style: TextStyle(
                    fontSize: 20.sp,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w700,
                  ),),
                ),
              ],
            )
            ,
          ),
          SizedBox(width: 12.w,),
          Container(
            width: 157.w,
            height: 80.h,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius
                    .circular(8.r),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromRGBO(112, 144, 176, 0.2),
                    blurRadius: 40,
                    offset: Offset(0, 14),
                  ),
                ]
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 12.0.h),
                  child: Text("Batas waktu keluar", style: TextStyle(
                    fontSize: 12.sp,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                  ),),
                ),
                Padding(
                  padding: EdgeInsets.only(top:4.0.h,),
                  child: Text("17.00", style: TextStyle(
                    fontSize: 20.sp,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w700,
                  ),),
                ),
              ],
            )
            ,
          ),
        ],
      ),
    );
    final jamMasuk = Column(
      children: [
        Text("Jam Masuk", style: TextStyle(
          fontSize: 20.sp,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.bold,
        ),),
        Text(_clockIn, style: TextStyle(
          fontSize: 28.sp,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w500,
        ),),
        if (stat == "masuk" || stat == "keluar")
          ...[Text("Status: $statClockIn",
            style: TextStyle(
              color: statClockIn == "Masuk Tepat Waktu" ? Colors.green :
              statClockIn == "Masuk Terlambat" ? Colors.redAccent :
              Colors.blueAccent,
              fontSize: 14.sp,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
            ),
          )]
      ],
    );
    final jamKeluar = Column(
      children: [
        Text("Jam Keluar", style: TextStyle(
          fontSize: 20.sp,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.bold,
        ),),
        Text(_clockOut!, style: TextStyle(
          fontSize: 28.sp,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w500,
        ),),
        if (stat == "keluar")
          ...[Text("Status: $statClockOut",
            style: TextStyle(
              color: statClockOut == "Pulang Tepat Waktu" ? Colors.green :
              statClockOut == "Pulang Lebih Cepat" ? Colors.redAccent :
              Colors.blueAccent,
              fontSize: 14.sp,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
            ),
          )],
        SizedBox(height: 40.h,)
      ],
    );
    final switchDinas = Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AutoSizeText("Sedang perjalanan dinas",
              maxFontSize: 16,
              maxLines: 1,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 16.sp,
                  color: Color.fromRGBO(40, 34, 86, 1),
                  fontWeight: FontWeight.w400,
                  fontFamily: "Poppins")
          ),
          if (!dataUser.getLockedDinas())
            ...[Switch(
              value: dataUser.getFlagDinas() != "",
              activeColor: Colors.redAccent,
              onChanged: (value) async {
                setState(()  {
                  _dinas = value;
                });
                if (_dinas) {
                  await dataUser.setFlagDinas("Perjalanan Dinas");
                } else {
                  await dataUser.setFlagDinas("");
                }
              },
            )]
          else
            ...[Switch(
                value: dataUser.getFlagDinas() != "",
                activeColor: Colors.redAccent,
                onChanged: null
            )]
        ],
      ),
    );
    Widget DataCard(String img) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.h),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius
                  .circular(12.r),
              boxShadow: [
                BoxShadow(
                  color: Color.fromRGBO(112, 144, 176, 0.2),
                  blurRadius: 40,
                  offset: Offset(0, 14),
                ),
              ]
          ),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 40.0.h, left: 48.w, right: 48.w,),
                child: Container(
                  width: 231.w,
                  height: 178.h,
                  child: Image.asset(img,
                    fit: BoxFit.contain,),
                ),
              ),
              SizedBox(height: 24.h,),
              jamMasuk,
              SizedBox(height: 20.h,),
              if (stat == "keluar" || stat == "masuk")
                ...[jamKeluar]
            ],
          ),
        ),
      );
    };
    final buttonAbsenMasuk = Center(
      child: InkWell(
        onTap: () => {
          helperMethod.getCurrentLocation().then((value) => {
            lat = '${value.latitude}',
            longi = '${value.longitude}'
          }
          ),
          encodeBody['date_time'] = DateFormat('yyyy-MM-dd H:m:s').format(DateTime.now()).toString(),
          encodeBody['latitude'] = lat,
          encodeBody['longitude'] = longi,
          encodeBody['status'] = dataUser.getFlagDinas().toString(),
          helperDialog.displayDialog(
              context, "Anda yakin ingin absen masuk?", "iya, masuk!", dataUser,  encodeBody, onTapStatusAbsensi, onTapClockIn)


        },
        child: Container(
          width: 200.w,
          height: 48.h,
          decoration: BoxDecoration(
              color: Color.fromRGBO(130, 83, 240, 1) ,
              borderRadius: BorderRadius.circular(8.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.25),
                  spreadRadius: 0,
                  blurRadius: 9,
                  offset: const Offset(2, 4), // changes position of shadow
                ),
              ]
          ),
          child: Padding(
            padding: EdgeInsets.only(top: 8.0.h, bottom: 8.0.h,),
            child: Center(
              child: HelperBigText(
                text: "Masuk",
                color: Colors.white,
                maxLines: 1,
                size: 18.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ),
    );
    final buttonAbsenKeluar = Center(
      child: InkWell(
        onTap: () => {

          helperMethod.getCurrentLocation().then((value) => {
            lat = '${value.latitude}',
            longi = '${value.longitude}'
          } ),

          encodeBody['date_time'] = DateFormat('yyyy-MM-dd H:m:s').format(DateTime.now()).toString(),
          encodeBody['latitude'] = lat,
          encodeBody['longitude'] = longi,
          encodeBody['status'] = dataUser.getFlagDinas().toString(),
          helperDialog.displayDialog(
              context, "Anda yakin ingin absen keluar?", "iya, keluar!", dataUser,  encodeBody, onTapStatusAbsensi, onTapClockIn)

        },
        child: Container(
          width: 200.w,
          height: 48.h,
          decoration: BoxDecoration(
              color: Color.fromRGBO(130, 83, 240, 1) ,
              borderRadius: BorderRadius.circular(8.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.25),
                  spreadRadius: 0,
                  blurRadius: 9,
                  offset: const Offset(2, 4), // changes position of shadow
                ),
              ]
          ),
          child: Padding(
            padding: EdgeInsets.only(top: 8.0.h, bottom: 8.0.h,),
            child: Center(
              child: HelperBigText(
                text: "Keluar",
                color: Colors.white,
                maxLines: 1,
                size: 18.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ),
    );
    final buttonAbsenSelesai = Center(
      child: InkWell(
        onTap: null,
        child: Container(
          width: 200.w,
          height: 48.h,
          decoration: BoxDecoration(
              color: Color.fromRGBO(236, 236, 236, 1) ,
              borderRadius: BorderRadius.circular(8.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.25),
                  spreadRadius: 0,
                  blurRadius: 9,
                  offset: const Offset(2, 4), // changes position of shadow
                ),
              ]
          ),
          child: Padding(
            padding: EdgeInsets.only(top: 8.0.h, bottom: 8.0.h,),
            child: Center(
              child: HelperBigText(
                text: "Keluar",
                color: Color.fromRGBO(83,83,83, 1),
                maxLines: 1,
                size: 18.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ),
    );

    switch (stat) {
      case "masuk":
        return
          Column(
            children: [
              batasWaktu,
              DataCard("resources/images/png/icon-absensi-masuk.png"),
              SizedBox(height: 5.h,),
              switchDinas,
              SizedBox(height: 16.h,),
              buttonAbsenKeluar,
              SizedBox(height: 100.h,),
            ],
          );
      case "keluar":
        return
          Column(
            children: [
              batasWaktu,
              DataCard("resources/images/png/icon-absensi-keluar.png"),
              SizedBox(height: 5.h,),
              switchDinas,
              SizedBox(height: 16.h,),
              buttonAbsenSelesai,
              SizedBox(height: 100.h,),
            ],
          );
      default:
        return Column(
          children: [
            batasWaktu,
            DataCard("resources/images/png/icon-absensi-1.png"),
            SizedBox(height: 5.h,),
            switchDinas,
            SizedBox(height: 16.h,),
            buttonAbsenMasuk,
            SizedBox(height: 68.h,),
          ],
        );
    }
  }
  void onTapStatusAbsensi(BuildContext context, flagg) {
    final dataUser = Provider.of<UserProvider>(context, listen: false);
    if (mounted) {
      setState(() {
        status = flagg;
      });
    }
  }
  void onTapClockIn(BuildContext context, _clockIn) {
    final dataUser = Provider.of<UserProvider>(context, listen: false);
    if (mounted)
      setState(() {
        dataUser.clockIn = _clockIn;
      });
  }

  /// -----------------------------------
  /// Build
  /// -----------------------------------
  Widget build(BuildContext context) {
    final dataUser = Provider.of<UserProvider>(context);
    HelperDialog helperDialog = HelperDialog();
    HelperMethod helperMethod = HelperMethod();
    final icon = "icon-absensi-1";
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        centerTitle: true,
        title: Text("Presensi", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
      ),
      backgroundColor: Color.fromRGBO(246, 242, 255, 1),
      body: SingleChildScrollView(
        child: _buildAbsensiContent(context),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.white,
        foregroundColor: Color(0xFF8253F0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.w)),
        onPressed: () {
          if (dataUser.getTokenIsValid()!){
            if (mounted){
              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => HistoryPage()));
            }

          }else{
            if (mounted){
              helperMethod.logout(dataUser);
              helperDialog.sessionTimeoutDialog(context);
            }

          }

        },
        label: Text("Profile"),
        icon: IconTheme(
          data: new IconThemeData(
              color: Colors.black
          )
          , child: Icon(Icons.person),),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}