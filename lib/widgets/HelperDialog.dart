part of "_widgets.dart";

class HelperDialog {
  var isLoading = false;

   void displayDialog(context, String title, String descButton, UserProvider dataUser, Map<String, String> _encodeBody, Function onTapStatusAbsensi, Function onTapClockIn) {
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

  void alertDialogSuccess(context) {
    showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) =>
            CupertinoAlertDialog(
              title: const Text('Login Ulang'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: const <Widget>[
                    Text('lakukan login ulang'),
                    Text('dengan password baru anda'),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text('oke'),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => LoginPage()));
                  },
                ),
              ],
            )
    );
  }
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
  }

  void checkAuthDialog(context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) =>
            CupertinoAlertDialog(
              title: Text("Sesi telah habis",
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w500,
                ),),
              content: Text(
                "Maaf sesi anda telah habis, mohon untuk login kembali!",
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 12.sp,
                ),),
              actions: <CupertinoDialogAction>[
                CupertinoDialogAction(
                  child: Text("Oke"),
                  onPressed: () {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) =>
                            LoginPage()), (Route<
                        dynamic> route) => false);
                  },
                ),
              ],
            ));
  }


}
