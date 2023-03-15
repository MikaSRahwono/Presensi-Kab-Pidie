part of '_pages.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
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
            padding: const EdgeInsets.only(top: 84.0, left: 32, right: 32),
            child: Row(
              children: [
                Container(
                  width: 157.w,
                  height: 80.h,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius
                          .circular(8),
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
                        padding: const EdgeInsets.only(top: 12.0),
                        child: Text("Batas waktu masuk", style: TextStyle(
                          fontSize: 12,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                        ),),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top:4.0,),
                        child: Text("09.00", style: TextStyle(
                          fontSize: 20,
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
                          .circular(8),
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
                        padding: const EdgeInsets.only(top: 12.0),
                        child: Text("Batas waktu keluar", style: TextStyle(
                          fontSize: 12,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                        ),),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top:4.0,),
                        child: Text("09.00", style: TextStyle(
                          fontSize: 20,
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
              padding: const EdgeInsets.only(top: 16.0, left: 32, right: 32),
              child: Container(
                width: 325.w,
                height: 369.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius
                      .circular(8),
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
                      padding: const EdgeInsets.only(top: 40.0, left: 48, right: 48, ),
                      child: Container(
                        width: 231.w,
                        height: 178.h,
                        child: Image.asset("resources/images/png/$icon.png", fit:BoxFit.contain ,),
                      ),
                    ),
                    SizedBox(height: 24.h,),
                    Text("Jam Masuk", style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                    ),),
                    SizedBox(height: 12,),
                    Text("- - : - -", style: TextStyle(
                      fontSize: 28,
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
                print('masuk')
                },
                child: Container(
                  width: 200.w,
                  height: 48.h,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(130, 83, 240, 1) ,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 8.0,),
                    child: Center(
                      child: HelperBigText(
                        text: "Masuk",
                        color: Colors.white,
                        maxLines: 1,
                        size: 18,
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
}
