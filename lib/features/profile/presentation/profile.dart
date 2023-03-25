import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:presensi_mobileapp/widgets/_widgets.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // // diganti ga pake text nanti
  // TextEditingController instansiController = TextEditingController(text: "nama instansi");
  //
  // final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: true,
        title: Text(
          'Profile',
          style: GoogleFonts.poppins(
              color: Colors.black, fontWeight: FontWeight.w700),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_outlined),
          color: Color.fromRGBO(130, 83, 240, 1),
          onPressed: () {
            Navigator.pop(context);
          },
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
                  borderRadius: BorderRadius.circular(16),
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
                        text: "Nama Pegawai",
                        size: 18,
                        fontWeight: FontWeight.w700,
                      )),
                    ),
                    Center(
                        child: HelperBigText(
                      text: "Nip",
                      size: 18,
                      fontWeight: FontWeight.w700,
                    )),
                    SizedBox(height: 48),
                    Padding(
                      padding: const EdgeInsets.only(left: 28.0),
                      child: HelperBigText(
                        text: "Instansi",
                        size: 14,
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(
                            left: 24.0, right: 24, top: 4),
                        child: Container(
                          height: 44,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Color.fromRGBO(240, 238, 252, 1),
                            border: Border.all(color: Colors.black12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 12),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(Icons.account_balance),
                                SizedBox(
                                  width: 24,
                                ),
                                Expanded(
                                    child: SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Text(
                                          "Nama Instansi dsadasdadasdadasdasdasdasdasdadas",
                                          style: TextStyle(fontSize: 14),
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
                          height: 44,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Color.fromRGBO(240, 238, 252, 1),
                            border: Border.all(color: Colors.black12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 12),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(Icons.account_balance),
                                SizedBox(
                                  width: 24,
                                ),
                                Expanded(
                                    child: SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Text(
                                          "Jabatan dsadasdadasdadasdasdasdasdasdadas",
                                          style: TextStyle(fontSize: 14),
                                        )))
                              ],
                            ),
                          ),
                        )),
                    Padding(
                      padding: const EdgeInsets.only(left: 28.0, top: 18),
                      child: HelperBigText(
                        text: "Tanggal Lahir",
                        size: 14,
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(
                            left: 24.0, right: 24.0, top: 4.0),
                        child: Container(
                          height: 44,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Color.fromRGBO(240, 238, 252, 1),
                            border: Border.all(color: Colors.black12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 12),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(Icons.account_balance),
                                SizedBox(
                                  width: 24,
                                ),
                                Expanded(
                                    child: SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Text(
                                          "Tanggal lahir sdwdadsadawdasdadwa",
                                          style: TextStyle(fontSize: 14),
                                        )))
                              ],
                            ),
                          ),
                        )),
                    Padding(
                      padding: const EdgeInsets.only(left: 28.0, top: 18),
                      child: HelperBigText(
                        text: "Email",
                        size: 14,
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(
                            left: 24.0, right: 24.0, top: 4.0),
                        child: Container(
                          height: 44,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Color.fromRGBO(240, 238, 252, 1),
                            border: Border.all(color: Colors.black12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 12),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 8.0, bottom: 8),
                                  child: Icon(Icons.account_balance),
                                ),
                                SizedBox(
                                  width: 24,
                                ),
                                Expanded(
                                    child: SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Text(
                                          "Emaildsadasdadasdadasdasdasdasdasdadas",
                                          style: TextStyle(fontSize: 14),
                                        )))
                              ],
                            ),
                          ),
                        )),
                    SizedBox(
                      height: 104,
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
                      borderRadius: BorderRadius.circular(12), // <-- Radius
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
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          fontFamily: "Poppins")),
                ),
                onPressed: () async {
                  // if (!_formKey.currentState!.validate()) {
                  //   return;
                  // }
                  // var response = await dataUser
                  //     .topUpSaldo(int.parse(saldoController.text));
                  // print(response.statusCode);
                  // if (response.statusCode == 200) {
                  //   Navigator.pushReplacement(
                  //       context,
                  //       MaterialPageRoute(
                  //           builder: (_) => MainPage(
                  //             startIndex: 4,
                  //           )));
                  //   displayDialog(
                  //       context, "Top Up Saldo", "Top up saldo berhasil!");
                  // } else {
                  //   displayDialog(
                  //       context, "An Error Occurred", dataUser.outputTopUp);
                  // }
                },
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(top: 12.0, right: 60.0, left: 60.0),
              child: Container(
                width: 400,
                height: 48,
                child: ElevatedButton.icon(
                  icon: Icon(Icons.logout),
                  label: AutoSizeText("Logout",
                      maxLines: 1,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          fontFamily: "Poppins")), //label text
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromRGBO(168, 0, 0, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12), // <-- Radius
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 60, vertical: 12),
                      textStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          fontFamily: "Poppins")),
                  onPressed: () async {
                    // if (!_formKey.currentState!.validate()) {
                    //   return;
                    // }
                    // var response = await dataUser
                    //     .topUpSaldo(int.parse(saldoController.text));
                    // print(response.statusCode);
                    // if (response.statusCode == 200) {
                    //   Navigator.pushReplacement(
                    //       context,
                    //       MaterialPageRoute(
                    //           builder: (_) => MainPage(
                    //             startIndex: 4,
                    //           )));
                    //   displayDialog(
                    //       context, "Top Up Saldo", "Top up saldo berhasil!");
                    // } else {
                    //   displayDialog(
                    //       context, "An Error Occurred", dataUser.outputTopUp);
                    // }
                  },
                ),
              ),
            ),
            SizedBox(
              height: 40,
            )
          ],
        ),
      ),
    );
  }
}
