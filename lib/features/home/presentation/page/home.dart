part of '_pages.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  @override
  Widget build(BuildContext context) {
    // TimeOfDay now = TimeOfDay.now();
    // String formattedTime = DateFormat.Hm().format(DateTime.now());
    Stream<DateTime> _clockStream;

    @override
    void initState() {
      super.initState();
      _clockStream = Stream.periodic(Duration(seconds: 1), (_) => DateTime.now());
    }

    final icon = "icon-absensi-1";
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        centerTitle: true,
        title: Text("Home", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
      ),
      backgroundColor: Color.fromRGBO(246, 242, 255, 1),
      body: SingleChildScrollView(
        child: Column(
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
              ],
            ),
          ),
            // StreamBuilder<DateTime>(
            //   stream: _clockStream,
            //   builder: (context, snapshot) {
            //     final timeString = DateFormat('HH:mm:ss').format(snapshot.data ?? DateTime.now());
            //     return Text(
            //       timeString,
            //       style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            //     );
            //   },
            // ),


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
                        child: Image.asset("resources/images/png/$icon.png", fit:BoxFit.contain ,),
                      ),
                    ),
                    SizedBox(height: 24.h,),
                    Text("Jam Masuk", style: TextStyle(
                      fontSize: 20.sp,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                    ),),
                    StreamBuilder(
                      stream: Stream.periodic(const Duration(seconds: 1)),
                      builder: (context, snapshot) {
                        return Text(DateFormat('MM/dd/yyyy hh:mm:ss').format(DateTime.now()));
                      },
                    ),
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
            SizedBox(height: 32.h,),
            Center(
              child: InkWell(
                onTap: () => {
                print('masuk'),
                displayDialog(
                context, "Top Up Saldo", "Top up saldo berhasil!")

                },
                child: Container(
                  width: 200.w,
                  height: 48.h,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(130, 83, 240, 1) ,
                    borderRadius: BorderRadius.circular(8.r),
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
          ],
        ),
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

  void displayDialog(context, title, text) => showDialog(
    context: context,
    builder: (context) => Dialog(
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
            AutoSizeText("08.06",
              maxFontSize: 75,
                style: TextStyle(
                    fontSize: 75.sp,
                    fontWeight: FontWeight.w700,
                    fontFamily: "Poppins")
            ),
            Padding(
              padding: EdgeInsets.only(top: 24.0.h, left: 32.w, right: 32.w),
              child: AutoSizeText("Anda yakin ingin absen masuk?",
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
                          // HelperBigText(
                          //   text: "Tidak Sekarang",
                          //   color: Colors.white,
                          //   maxLines: 1,
                          //   size: 18.sp,
                          //   fontWeight: FontWeight.w700,
                          // ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 16.w,),
                  InkWell(
                    onTap: () => {
                      print('masuk'),

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
                          AutoSizeText("Iya, masuk!",
                              maxFontSize: 12,
                              maxLines: 1,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 12.sp,
                                  color: Color.fromRGBO(40, 34, 86, 1),
                                  fontWeight: FontWeight.w400,
                                  fontFamily: "Poppins")
                          ),
                          // HelperBigText(
                          //   text: "Masuk",
                          //   color: Colors.white,
                          //   maxLines: 1,
                          //   size: 18.sp,
                          //   fontWeight: FontWeight.w700,
                          // ),
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
}
