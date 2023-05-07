part of '_pages.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  late Future<User?> dataFutureUser;

  @override
  Widget build(BuildContext context) {
    final dataUser = Provider.of<UserProvider>(context);
    HelperMethod helperMethod = HelperMethod();
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Profile',
        ),
      ),
      backgroundColor: Color.fromRGBO(246, 242, 255, 1),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 40.0, left: 24, right: 24),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.r),
                  color: Colors.white,
                  border: Border.all(color: Colors.black12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white,
                      offset: Offset(-4, -4),
                      blurRadius: 15,
                      spreadRadius: 4,
                    ),
                    BoxShadow(
                      color: Colors.grey.shade300,
                      offset: Offset(4, 4),
                      blurRadius: 15,
                      spreadRadius: 4,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 32.0),
                      child: Center(
                          child: HelperBigText(
                        text: dataUser.getUser()?.nama ?? "Nama Pegawai",
                        size: 18.sp,
                        fontWeight: FontWeight.w700,
                      )),
                    ),
                    Center(
                        child: HelperBigText(
                      text: dataUser.getUser()?.nip ?? "NIP",
                      size: 18.sp,
                      fontWeight: FontWeight.w700,
                    )),
                    SizedBox(height: 48.h),
                    Padding(
                      padding: const EdgeInsets.only(left: 28.0),
                      child: HelperBigText(
                        text: "Instansi",
                        size: 14.sp,
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(
                            left: 24.0, right: 24, top: 4),
                        child: Container(
                          height: 50.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.r),
                            color: Color.fromRGBO(240, 238, 252, 1),
                            border: Border.all(color: Colors.black12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 12),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(Icons.apartment),
                                SizedBox(
                                  width: 24.w,
                                ),
                                Expanded(
                                    child: SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Text(
                                          dataUser.getUser()?.idInstansi ?? "Instansi",
                                          style: TextStyle(fontSize: 14.sp),
                                        )))
                              ],
                            ),
                          ),
                        )),
                    Padding(
                      padding: const EdgeInsets.only(left: 28.0, top: 18),
                      child: HelperBigText(
                        text: "Jabatan",
                        size: 14,
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(
                            left: 24.0, right: 24.0, top: 4.0),
                        child: Container(
                          height: 50.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.r),
                            color: Color.fromRGBO(240, 238, 252, 1),
                            border: Border.all(color: Colors.black12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 12),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(Icons.event_seat),
                                SizedBox(
                                  width: 24.w,
                                ),
                                Expanded(
                                    child: SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Text(
                                          dataUser.getUser()?.idJabatan ?? "Jabatan",
                                          style: TextStyle(fontSize: 14.sp),
                                        )))
                              ],
                            ),
                          ),
                        )),
                    Padding(
                      padding: const EdgeInsets.only(left: 28.0, top: 18),
                      child: HelperBigText(
                        text: "Email",
                        size: 14.sp,
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(
                            left: 24.0, right: 24.0, top: 4.0),
                        child: Container(
                          height: 50.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.r),
                            color: Color.fromRGBO(240, 238, 252, 1),
                            border: Border.all(color: Colors.black12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 12),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(Icons.email),
                                SizedBox(
                                  width: 24.w,
                                ),
                                Expanded(
                                    child: SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Text(
                                          dataUser.getUser()?.email ?? "Email",
                                          style: TextStyle(fontSize: 14.sp),
                                        )))
                              ],
                            ),
                          ),
                        )), SizedBox(
                      height: 104.h,
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(top: 28.0, right: 60.0, left: 60.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromRGBO(130, 83, 240, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r), // <-- Radius
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        fontFamily: "Poppins")),
                child: Center(
                  child: AutoSizeText("Ubah Password",
                      maxLines: 1,
                      style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          fontFamily: "Poppins")),
                ),
                onPressed: () async {
                  Navigator.push(context,MaterialPageRoute(builder: (BuildContext context) => ChangePasswordPage()));
                },
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(top: 12.0, right: 60.0, left: 60.0),
              child: Container(
                width: 400.w,
                height: 58.h,
                child: ElevatedButton.icon(
                  icon: Icon(Icons.logout),
                  label: AutoSizeText("Logout",
                      maxLines: 1,
                      style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          fontFamily: "Poppins")), //label text
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromRGBO(168, 0, 0, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r), // <-- Radius
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 60, vertical: 12),
                      textStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          fontFamily: "Poppins")),
                  onPressed: () async {
                    helperMethod.logout(dataUser);
                    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => LoginPage()));
                  },
                ),
              ),
            ),
            SizedBox(
              height: 40.h,
            )
          ],
        ),
      ),
    );
  }
}
