part of '_pages.dart';

class FirstPassResetPage extends StatefulWidget {
  const FirstPassResetPage({Key? key}) : super(key: key);

  @override
  State<FirstPassResetPage> createState() => _FirstPassResetPageState();
}

class _FirstPassResetPageState extends State<FirstPassResetPage> {
  @override
  Widget build(BuildContext context) {
    // Step 1: panggil data user
    // final dataUser = Provider.of<UserProvider>(context);
    // Step 2: Jangan membuat widgets menjadi const
    // Step 3: dataUser.getFirstLogin()!.toString() ?? ''
    final password = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Password Baru"),
        SizedBox(height: 8,),
        Container(
          decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(
                    color: Colors.black12
                ),
                BoxShadow(
                    color: Color(0xFFF6F2FF),
                    blurRadius: 10,
                    spreadRadius: -5
                ),
              ],
              borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(5.0, 0, 5.0 ,0),
            child: TextFormField(
              autofocus: false,
              initialValue: '',
              obscureText: true,
              decoration: const InputDecoration(
                hintText: 'Password',
                contentPadding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                border: InputBorder.none,
              ),
            ),
          ),
        ),
      ],
    );
    final repeatPassword = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Ulangi Password Baru"),
        SizedBox(height: 8,),
        Container(
          decoration: BoxDecoration(
            boxShadow: const [
              BoxShadow(
                  color: Colors.black12
              ),
              BoxShadow(
                  color: Color(0xFFF6F2FF),
                  blurRadius: 10,
                  spreadRadius: -5
              ),
            ],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(5.0, 0, 5.0 ,0),
            child: TextFormField(
              autofocus: false,
              initialValue: '',
              obscureText: true,
              decoration: const InputDecoration(
                hintText: 'Password',
                contentPadding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                border: InputBorder.none,
              ),
            ),
          ),
        ),
      ],
    );
    final saveButton = Container(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      margin: EdgeInsets.fromLTRB(40, 0, 40, 0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF8253F0),
          minimumSize: const Size.fromHeight(40),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: const Text('Simpan', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => LoginPage()));
        },
      ),
    );

    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        centerTitle: false,
        title: Text(
          'Ubah Password',
          style: GoogleFonts.poppins(
              color: Colors.white,
              fontWeight: FontWeight.w500,)
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_outlined),
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: Color(0xFFF6F2FF),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(15),
          child: Column(
            children: [
              Center(
                child: Container(
                  margin: const EdgeInsets.only(top: 20),
                  decoration: const BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black12,
                            blurRadius: 10
                        )
                      ]
                  ),
                  child: Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    child: Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: Column(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.transparent,
                            radius: 83.0,
                            child: Image.asset('resources/images/png/ResetPassword.png'),
                          ),
                          Column(
                            children: const [
                              Text("Ubah Password",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24
                                ),
                              ),
                              SizedBox(height: 10,),
                              Padding(
                                padding: EdgeInsets.fromLTRB(25.0, 0, 25.0, 0),
                                child: Text("Untuk melanjutkan pemakaian aplikasi presensi, lakukan ubah password terlebih dahulu!",
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(25.0, 0, 25.0, 0),
                                child: Text("Untuk melanjutkan pemakaian aplikasi presensi, lakukan ubah password terlebih dahulu!",
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 30),
                          password,
                          SizedBox(height: 20),
                          repeatPassword
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              saveButton
            ],
          ),
        ),
      ),
    );
  }
}
