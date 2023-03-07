part of '_pages.dart';

class LoginPage extends StatefulWidget {
  static String tag = 'login-page';
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final nipController = TextEditingController();
  final passController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    nipController.dispose();
    passController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    final logo = Hero(
      tag: 'hero',
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 48.0,
        child: Image.asset('resources/images/png/logo.png'),
      ),
    );
    final nip = Container(
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10
          )
        ]
      ),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 1, 8.0, 1),
          child: TextFormField(
            controller: nipController,
            keyboardType: TextInputType.emailAddress,
            autofocus: false,
            decoration: const InputDecoration(
              hintText: 'NIP',
              contentPadding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
              border: InputBorder.none,
            ),
          ),
        ),
      ),
    );
    final password = Container(
      decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Colors.black12,
                blurRadius: 10
            )
          ]
      ),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 1, 8.0, 1),
          child: TextFormField(
            controller: passController,
            autofocus: false,
            obscureText: true,
            decoration: const InputDecoration(
              hintText: 'Password',
              contentPadding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
              border: InputBorder.none,
            ),
          ),
        ),
      ),
    );
    final loginButton = Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF8253F0),
          minimumSize: const Size.fromHeight(50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: const Text('Login', style: TextStyle(fontSize: 15,),),
          onPressed: () async {
          var response = await fetchToken(nipController.text, passController.text);
          Map resMap = json.decode(response);

          // TODO: Session flutter buat tokennya
          var token = resMap['tokens']['access'];
          var isFirst = resMap['first_login'];
          if (isFirst) {
            Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => FirstPassResetPage()));
          }
          else{
            Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => HomePage()));
          }
          },
      ),
    );
    final forgotLabel = TextButton(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text("Lupa Password", style: TextStyle(color: Colors.black, fontSize: 15)),
          Icon(Icons.chevron_right, color: Colors.black)
        ]
      ),
      onPressed: () {},
    );
    const heading = Padding(
      padding: EdgeInsets.only(left: 40, right: 40),
      child: Text(
        'Sistem Informasi Presensi Kepegawaian Kab. Pidie',
        style: TextStyle(
          color: Colors.black,
          fontSize: 23,
        ),
          textAlign: TextAlign.center
      ),
    );

    return Scaffold(
      backgroundColor: Color(0xFFF6F2FF),
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            logo,
            const SizedBox(height: 40.0),
            heading,
            const SizedBox(height: 48.0),
            nip,
            const SizedBox(height: 8.0),
            password,
            const SizedBox(height: 24.0),
            loginButton,
            forgotLabel
          ],
        ),
      ),
    );
  }
}

Future<String> fetchToken(nip, pass) async {
  var request = http.MultipartRequest('POST', Uri.parse('http://localhost:8000/account/login'));
  request.fields.addAll({
    'nip': nip,
    'password': pass
  });


  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    return (await response.stream.bytesToString());
  }
  else {
    return ("Error");
  }

}