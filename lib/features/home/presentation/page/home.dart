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
  String _flag = '';
  var isLoading = false;
  late Map<String, String> encodeBody = {};

  @override
  void initState() {
    super.initState();
    getCurrentLocation().then((value) => {
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
  /// Methods
  /// -----------------------------------

  void displayDialog(context, String title, String descButton, UserProvider dataUser, Map<String, String> _encodeBody) {
    void displayError(context, e) {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) =>
              CupertinoAlertDialog(
                title: Text("Terjadi Error",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize:  18.sp,
                    fontWeight: FontWeight.w500,
                  ),),
                content:  Text(e.toString(),
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize:  12.sp,
                  ),),
                actions: <CupertinoDialogAction>[
                  CupertinoDialogAction(
                    child: Text("Oke"),
                    onPressed: (){
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ));
    };
    void serverError(context) {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) =>
              CupertinoAlertDialog(
                title: Text("Server Error",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize:  18.sp,
                    fontWeight: FontWeight.w500,
                  ),),
                content:  Text("Laporkan ke admin jika anda menemukan peringatan ini!",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize:  12.sp,
                  ),),
                actions: <CupertinoDialogAction>[
                  CupertinoDialogAction(
                    child: Text("Oke"),
                    onPressed: (){
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ));
    }

    showDialog(
        context: context,
        builder: (context) =>
            AlertDialog(
              contentPadding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.h),
              content: StatefulBuilder(
                builder: (BuildContext context, StateSetter setState){
                  return  Container(
                    height: 385.h,
                    width: 380.w,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                              onTap: () => {
                                setState(() {
                                  isLoading = false;
                                }),
                                Navigator.pop(context)
                              },
                              child: Container(
                                margin: EdgeInsets.only(right: 10.w, top: 10.h),
                                width: 10,
                                height: 10,
                                child: SvgPicture.asset(
                                  'resources/images/svg/cancel_icon.svg',
                                  fit: BoxFit.fill,
                                ),
                              ),
                            )
                          ],
                        ),
                        Center(
                          child: Container(
                            margin: EdgeInsets.only(top: 30.h),
                            child: StreamBuilder(
                              stream: Stream.periodic(const Duration(seconds: 1)),
                              builder: (context, snapshot) {
                                return AutoSizeText(
                                    DateFormat('hh:mm').format(DateTime.now()),
                                    maxFontSize: 60,
                                    style: TextStyle(
                                        fontSize: 60.sp,
                                        fontWeight: FontWeight.w700,
                                        fontFamily: "Poppins")
                                );
                              },
                            ),
                          ),
                        ),
                        Center(
                          child: Container(
                            margin: EdgeInsets.only(top: 5.h),
                            padding: EdgeInsets.symmetric(horizontal: 10.w),
                            child: AutoSizeText(title,
                                maxFontSize: 16,
                                maxLines: 1,
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: "Poppins")
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 8.0.h, left: 45.h, right: 45.h),
                          child: AutoSizeText("Data Kehadiran akan tercatat oleh sistem secara otomatis",
                              maxFontSize: 12,
                              minFontSize: 9,
                              maxLines: 2,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 12.sp,
                                  color: Color.fromRGBO(157, 153, 174, 1),
                                  fontWeight: FontWeight.w400,
                                  fontFamily: "Poppins")
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top:40.0.h, left: 5.w, right: 5.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              InkWell(
                                onTap: () => {
                                  setState(() {
                                    isLoading = false;
                                  }),
                                  Navigator.pop(context)
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                                  decoration: BoxDecoration(
                                    color: Colors.transparent ,
                                    borderRadius: BorderRadius.circular(8.r),
                                    border: Border.all(
                                      color: Colors.black,
                                      width: 2,
                                    ),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.only(top: 8.0.h, bottom: 8.0.h),
                                    child: Center(
                                      child:
                                      AutoSizeText("Tidak Sekarang",
                                          maxFontSize: 12,
                                          maxLines: 1,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 12.sp,
                                              color: Color.fromRGBO(40, 34, 86, 1),
                                              fontWeight: FontWeight.w400,
                                              fontFamily: "Poppins")
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () async {
                                  setState(() {
                                    isLoading = true;
                                  });
                                  if (dataUser.getPresensi()?.status == null){
                                    try {
                                      var respData = await dataUser.absenMasuk(_encodeBody, context);
                                      var resMap = jsonDecode(respData.body);
                                      onTapStatusAbsensi(context, "masuk");
                                      dataUser.setPresensiModel(Presensi.fromJson(resMap));
                                      onTapClockIn(context, DateFormat('hh:mm').format(DateTime.now()));
                                      setState(()  {
                                        dataUser.setLockedDinas(true);
                                        isLoading = false;
                                      });
                                      Navigator.pop(context);
                                    }
                                    catch(e) {
                                      setState(() {
                                        isLoading = false;
                                      });
                                      Navigator.pop(context);
                                      if(e.toString() == "Server Error") {
                                        serverError(context);
                                      } else {
                                        displayError(context, e);
                                      }
                                    }
                                  }
                                  else if (dataUser.getPresensi()?.status == "masuk"){
                                    try {
                                      var respData = await dataUser.absenKeluar(_encodeBody, context);
                                      var resMap = jsonDecode(respData.body);
                                      onTapStatusAbsensi(context, "keluar");
                                      dataUser.setPresensiModel(Presensi.fromJson(resMap));
                                      onTapClockIn(context, DateFormat('hh:mm').format(DateTime.now()));
                                      setState(() {
                                        dataUser.setLockedDinas(true);
                                        isLoading = false;
                                      });
                                      Navigator.pop(context);
                                    }
                                    catch(e) {
                                      setState(() {
                                        isLoading = false;
                                      });
                                      Navigator.pop(context);
                                      if(e.toString() == "Server Error") {
                                        serverError(context);
                                      } else {
                                        displayError(context, e);
                                      }
                                    }
                                  };
                                },
                                child: Container(
                                  width: 100.w,
                                  padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
                                  margin: EdgeInsets.symmetric(horizontal: 1.w),
                                  decoration: BoxDecoration(
                                    color: Color.fromRGBO(255, 212, 101, 1) ,
                                    borderRadius: BorderRadius.circular(8.r),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.only(top: 8.0.h, bottom: 8.0.h,),
                                    child: Center(
                                      child: isLoading?
                                      SizedBox(
                                        child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.white)),
                                        width: 10.w,
                                        height: 10.w,
                                      ):
                                      AutoSizeText(descButton,
                                          maxFontSize: 12,
                                          minFontSize: 9,
                                          maxLines: 1,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 12.sp,
                                              color: Color.fromRGBO(40, 34, 86, 1),
                                              fontWeight: FontWeight.w400,
                                              fontFamily: "Poppins")
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                  );
                },
              ),
            )
    );
  }
  Widget _buildAbsensiContent(BuildContext context) {
    final dataUser = Provider.of<UserProvider>(context);
    final dataPresensi = dataUser.getPresensi()?.data;
    String _clockIn = dataPresensi?.jamAbsensiMasuk.toString().substring(0, 5) ?? '- - : - -';
    String? _clockOut = dataPresensi?.jamAbsensiKeluar == null ? '- - : - -' : dataUser.getPresensi()?.data?.jamAbsensiKeluar.toString().substring(0, 5);
    String statClockIn = dataPresensi?.keteranganAbsensiMasuk ?? "";
    String statClockOut = dataPresensi?.keteranganAbsensiKeluar ?? "";
    String stat = dataUser.getPresensi()?.status ?? "";
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
          getCurrentLocation().then((value) => {
            lat = '${value.latitude}',
            longi = '${value.longitude}'
          }
          ),
          encodeBody['date_time'] = DateFormat('yyyy-MM-dd H:m:s').format(DateTime.now()).toString(),
          encodeBody['latitude'] = lat,
          encodeBody['longitude'] = longi,
          encodeBody['status'] = dataUser.getFlagDinas().toString(),
          displayDialog(
              context, "Anda yakin ingin absen masuk?", "iya, masuk!", dataUser,  encodeBody)


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

          getCurrentLocation().then((value) => {
            lat = '${value.latitude}',
            longi = '${value.longitude}'
          } ),

          encodeBody['date_time'] = DateFormat('yyyy-MM-dd H:m:s').format(DateTime.now()).toString(),
          encodeBody['latitude'] = lat,
          encodeBody['longitude'] = longi,
          encodeBody['status'] = dataUser.getFlagDinas().toString(),
          displayDialog(
              context, "Anda yakin ingin absen keluar?", "iya, keluar!", dataUser,  encodeBody)

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
  void onTapClockOut(BuildContext context, _clockOut) {
    final dataUser = Provider.of<UserProvider>(context, listen: false);
    if (mounted)
      setState(() {
        dataUser.clockOut = _clockOut;
      });
  }
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

  /// -----------------------------------
  /// Build
  /// -----------------------------------
  Widget build(BuildContext context) {
    final dataUser = Provider.of<UserProvider>(context);
    _flag = dataUser.flagAbsensi.toString();
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
              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => ProfilePage()));
            }

          }else{
            if (mounted){
              dataUser.logout();
              showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) =>
                      CupertinoAlertDialog(
                        title: Text("Sesi telah habis",
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize:  18.sp,
                            fontWeight: FontWeight.w500,
                          ),),
                        content:  Text("Maaf sesi anda telah habis, mohon untuk login kembali!",
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize:  12.sp,
                          ),),
                        actions: <CupertinoDialogAction>[
                          CupertinoDialogAction(
                            child: Text("Oke"),
                            onPressed: (){
                              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                                  LoginPage()), (Route<dynamic> route) => false);
                            },
                          ),
                        ],
                      ));
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