part of '_pages.dart';

class HomePage extends StatefulWidget {

  const HomePage({Key? key}) : super(key: key);


  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  late Future<Presensi?> dataFuturePresensi;
  late Future<http.Response?> respData;
  bool _dinas = false;
  late String status = '';
  late String clockin = '';
  late String clokcOut = '';
  String lat = '';
  String longi = '';
  String _flag = '';
  late Map<String, String> encodeBody = {};


  // @override
  // void initState() {
  //   super.initState();
  //   final dataUser = Provider.of<UserProvider>(context);
  //   Future.delayed(Duration.zero, ()
  //     {
  //       dataFuturePresensi = dataUser.getRequestWithJWT("http://localhost:8000/presensi/") as Future<Presensi>;
  //     }
  //   );
  //
  // }

  @override
  void initState() {
    super.initState();
    getCurrentLocation().then((value) => {
      lat = '${value.latitude}',
      longi = '${value.longitude}'
    }
    );
  }
  @override
  void dispose() {
    // dispose any resources
    super.dispose();
  }


  @override
  void didChangeDependencies() {
    final dataUser = Provider.of<UserProvider>(context);
    super.didChangeDependencies();
    respData = dataUser.getRequestWithJWT("http://127.0.0.1:8000/presensi/");
    respData.then((response_) {
      if (response_?.statusCode == 200) {
        dataUser.presensiModel = Presensi.fromJson(jsonDecode(response_!.body));
      }
      else {
        // Error response
        print('Request failed with status: ${response_?.statusCode}.');
      }
    }
    );



  }
  @override
  Widget build(BuildContext context) {

    // final dataUser = Provider.of<UserProvider>(context);
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
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => ProfilePage()));
        },
        label: Text("Profile"), icon: Icon(Icons.person),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  void displayDialog(context, String title, String descButton, UserProvider dataUser, Map<String, String> _encodeBody) =>
      showDialog(
    context: context,
    builder: (context) =>
        Dialog(
          child: Container(
            width: 326.w,
            height: 384.h,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 24.0.h, right: 20.0.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () => {
                          Navigator.pop(context)
                        },
                        child: Container(
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
                ),
                SizedBox(height: 48.h,),
                StreamBuilder(
                  stream: Stream.periodic(const Duration(seconds: 1)),
                  builder: (context, snapshot) {
                    return AutoSizeText(
                        DateFormat('hh:mm').format(DateTime.now()),
                        maxFontSize: 75,
                        style: TextStyle(
                            fontSize: 75.sp,
                            fontWeight: FontWeight.w700,
                            fontFamily: "Poppins")
                    );
                  },
                ),
                Padding(
                  padding: EdgeInsets.only(top: 24.0.h, left: 32.w, right: 32.w),
                  child: AutoSizeText(title,
                      maxFontSize: 16,
                      maxLines: 1,
                      style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                          fontFamily: "Poppins")
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8.0.h, left: 45.h, right: 45.h),
                  child: AutoSizeText("Data Kehadiran akan tercatat oleh sistem secara otomatis",
                      maxFontSize: 12,
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
                  padding: EdgeInsets.only(top:20.0.h, left: 20.w, right: 20.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                        onTap: () => {
                          Navigator.pop(context)
                        },
                        child: Container(
                          width: 124.w,
                          height: 38.h,
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
                      SizedBox(width: 16.w,),
                      InkWell(
                        onTap: () => {
                          // TODO:  Navigator to homepage using push replacement
                          if (status == ""){
                            print(_encodeBody),
                            respData = dataUser.postRequestWithJWT("http://127.0.0.1:8000/presensi/", _encodeBody),
                            respData.then((response_) {
                              print(_encodeBody);
                              print(response_?.statusCode);
                              if (response_?.statusCode == 200){
                                onTapStatusAbsensi(context, "masuk");
                                dataUser.getData("http://127.0.0.1:8000/presensi/");
                                Navigator.of(context,rootNavigator: true).pop();
                                dataUser.presensiModel = Presensi.fromJson(jsonDecode(response_!.body));
                                onTapClockIn(context, DateFormat('hh:mm').format(DateTime.now()));
                              }
                              else {
                                // Error response
                                print('Request failed with status: ${response_}.');
                              }
                            }

                            )
                          }
                          else if (status == "masuk"){
                          respData = dataUser.putRequestWithJWT("http://127.0.0.1:8000/presensi/", _encodeBody),
                            respData.then((response_) {
                              if (response_?.statusCode == 200){
                                onTapStatusAbsensi(context, "keluar");
                                dataUser.getData("http://127.0.0.1:8000/presensi/");
                                Navigator.of(context,rootNavigator: true).pop();
                                dataUser.presensiModel = Presensi.fromJson(jsonDecode(response_!.body));
                                onTapClockIn(context, DateFormat('hh:mm').format(DateTime.now()));

                              }

                              else {
                                // Error response
                                print('Request failed with status: ${response_?.body}.');
                              }
                            }

                            ),


                          },
                          // Navigator.pop(context),
                        },
                        child: Container(
                          width: 128.w,
                          height: 38.h,
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(255, 212, 101, 1) ,
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(top: 8.0.h, bottom: 8.0.h,),
                            child: Center(
                              child:
                              AutoSizeText(descButton,
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
                    ],
                  ),
                ),
          ],
        ),

      ),
    )
  );

  Widget _buildAbsensiContent(BuildContext context) {
    final dataUser = Provider.of<UserProvider>(context);
    String _clockIn = dataUser.getPresensi()?.data.jamAbsensiMasuk.toString().substring(0, 5) ?? '- - : - -';
    String _clockOut = dataUser.getPresensi()?.data.jamAbsensiKeluar.toString().substring(0, 5) ?? '- - : - -';
    String statClockIn = dataUser.getPresensi()?.data.keteranganAbsensiMasuk ?? "";
    String statClockOut = dataUser.getPresensi()?.data.keteranganAbsensiKeluar ?? "";

    String stat = dataUser.getPresensi()?.status ?? "";
    switch (stat) {
      case "masuk":
        return
          Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: 76.0.h, left: 32.w, right: 32.w
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
              ),
              Padding(
                padding: EdgeInsets.only(top: 16.0.h, left: 32.w, right: 32.w),
                child: Container(
                  width: 325.w,
                  height: 580.h,
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
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 40.0.h, left: 48.w, right: 48.w, ),
                        child: Container(
                          width: 231.w,
                          height: 178.h,
                          child: Image.asset("resources/images/png/icon-absensi-masuk.png", fit:BoxFit.contain ,),
                        ),
                      ),
                      SizedBox(height: 24.h,),
                      Text("Jam Masuk",
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 12.h,),
                      Text(_clockIn,
                        style: TextStyle(
                          fontSize: 28.sp,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                        ),

                      ),
                      Text("Status: $statClockIn",
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 16.h,),
                      Text("Jam Keluar",
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 12.h,),
                      Padding(
                        padding: EdgeInsets.only(top:4.0.h,),
                        child: Text("- - : - -",
                          style: TextStyle(
                            fontSize: 28.sp,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                          ),

                        ),
                      ),

                    ],
                  ),
                ),
              ),
              SizedBox(height: 16.h,),
              Center(
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
                    Switch(
                      value: _dinas,
                      activeColor: Colors.redAccent,
                      onChanged: (value) {
                        setState(() {
                          _dinas = value;
                          if (_dinas) {
                            _dinas = true;
                            dataUser.setFlagDinas("Perjalanan Dinas");
                            print(dataUser.getFlagDinas().toString());
                          } else {
                            _dinas = false;
                            dataUser.setFlagDinas("");
                            print(dataUser.getFlagDinas().toString());
                          }
                        });
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.h,),
              Center(
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
                    encodeBody['status'] = dataUser.flagDinas!,
                    print(encodeBody),
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
              ),
              SizedBox(height: 100.h,),
            ],
          );
      case "keluar":
        return
          Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: 76.0.h, left: 32.w, right: 32.w
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
                            child: Text("Batas waktu keluar",
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top:4.0.h,),
                            child: Text("17.00",
                              style: TextStyle(
                                fontSize: 20.sp,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),

                        ],
                      )
                      ,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 16.0.h, left: 32.w, right: 32.w),
                child: Container(
                  width: 325.w,
                  height: 580.h,
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
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 40.0.h, left: 48.w, right: 48.w, ),
                        child: Container(
                          width: 231.w,
                          height: 178.h,
                          child: Image.asset("resources/images/png/icon-absensi-keluar.png", fit:BoxFit.contain ,),
                        ),
                      ),
                      SizedBox(height: 24.h,),
                      Text("Jam Masuk",
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 12.h,),
                      Text(_clockIn,
                        style: TextStyle(
                          fontSize: 28.sp,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text("Status: $statClockIn",
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 16.h,),
                      Text("Jam Keluar",
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 12.h,),
                      Padding(
                        padding: EdgeInsets.only(top:4.0.h,),
                        child: Text(_clockOut,
                          style: TextStyle(
                            fontSize: 28.sp,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                          ),

                        ),
                      ),
                      Text("Status: $statClockOut",
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 40.h,),


                    ],
                  ),
                ),
              ),
              SizedBox(height: 16.h,),
              Center(
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
                    Switch(
                      activeColor: Colors.redAccent,
                      value: _dinas,
                      onChanged: (value) {
                        setState(() {
                          _dinas = value;
                          if (_dinas) {
                            _dinas = true;
                            dataUser.setFlagDinas("Perjalanan Dinas");
                            print(dataUser.getFlagDinas().toString());
                          } else {
                            _dinas = false;
                            dataUser.setFlagDinas("");
                            print(dataUser.getFlagDinas().toString());
                          }
                        });
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.h,),
              Center(
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
              ),

              SizedBox(height: 100.h,),
            ],
          );
      default:
        return Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  top: 76.0.h, left: 32.w, right: 32.w
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
            ),
            Padding(
              padding: EdgeInsets.only(top: 16.0.h, left: 32.w, right: 32.w),
              child: Container(
                width: 325.w,
                height: 369.h,
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
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 40.0.h, left: 48.w, right: 48.w, ),
                      child: Container(
                        width: 231.w,
                        height: 178.h,
                        child: Image.asset("resources/images/png/icon-absensi-1.png", fit:BoxFit.contain ,),
                      ),
                    ),
                    SizedBox(height: 24.h,),
                    Text("Jam Masuk", style: TextStyle(
                      fontSize: 20.sp,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                    ),),
                    SizedBox(height: 12.h,),
                    Text("- - : - -", style: TextStyle(
                      fontSize: 28.sp,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                    ),
                    ),

                  ],
                ),
              ),
            ),
            SizedBox(height: 16.h,),
            Center(
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
                  Switch(
                    activeColor: Colors.redAccent,
                    value: _dinas,
                    onChanged: (value) {
                      setState(() {
                        _dinas = value;
                        if (_dinas) {
                          _dinas = true;
                          dataUser.setFlagDinas("Perjalanan Dinas");
                          print(dataUser.getFlagDinas().toString());
                        } else {
                          _dinas = false;
                          dataUser.setFlagDinas("");
                          print(dataUser.getFlagDinas().toString());
                        }
                      });
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.h,),
            Center(
              child: InkWell(
                onTap: () => {
                  print('awal masuk'),
                  print(""),
                  getCurrentLocation().then((value) => {
                  lat = '${value.latitude}',
                  longi = '${value.longitude}'
                    }
                  ),


                  print("lat "+ lat),
                  print("longitude "+ longi),
                  encodeBody['date_time'] = DateFormat('yyyy-MM-dd H:m:s').format(DateTime.now()).toString(),
                  encodeBody['latitude'] = lat,
                  encodeBody['longitude'] = longi,
                  print("test"),
                  encodeBody['status'] = dataUser.flagDinas!,
                  print("test"),
                  print(encodeBody),
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
            ),
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
}
