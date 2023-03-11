import 'package:flutter/material.dart';

import '../../profile/presentation/profile.dart';
// import '../../authentication/presentation/pages/_pages.dart';


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
        title: Text("Home"),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 88.0, left: 32, right: 32),
              child: Container(
                width: 325,
                height: 369,
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
                        width: 231,
                        height: 178,
                        child: Image.asset("resources/images/png/$icon.png", fit:BoxFit.contain ,),
                      ),
                    ),
                    SizedBox(height: 24,),
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
                    ),),



                  ],
                ),
              ),
            ),
            Text("Hello World")
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => ProfilePage()));
        },
        label: Text("Profile"), icon: Icon(Icons.person
      ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
