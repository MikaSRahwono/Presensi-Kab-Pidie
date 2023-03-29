part of '_pages.dart';

class LoginPage extends StatefulWidget {
  static String tag = 'login-page';
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final nipController = TextEditingController();
  final passController = TextEditingController();
  var isLoading = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    nipController.dispose();
    passController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget NIPField(int height, int fontSize) {
      return Container(
        height: height.h,
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(color: Colors.grey.shade200, blurRadius: 10)
        ]),
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 1, 8.0, 1),
              child: TextFormField(
                controller: nipController,
                decoration: const InputDecoration(
                  hintText: 'NIP',
                  contentPadding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                  border: InputBorder.none,
                ),
                style: TextStyle(fontSize: fontSize.h),
              ),
            ),
          ),
        ),
      );
    }
    Widget PasswordField(int height, int fontSize) {
      return Container(
        height: height.h,
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(color: Colors.grey.shade200, blurRadius: 10)
        ]),
        child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 1, 8.0, 1),
                child: TextFormField(
                  controller: passController,
                  autofocus: false,
                  obscureText: true,
                  decoration: const InputDecoration(
                    hintText: 'Password',
                    contentPadding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                    border: InputBorder.none,
                  ),
                  style: TextStyle(fontSize: fontSize.h),
                ),
              ),
            )),
      );
    }
    final dataUser = Provider.of<UserProvider>(context);
    final logo = FittedBox(
      fit: BoxFit.fitWidth,
      child: Padding(
        padding: const EdgeInsets.only(left: 22.0, right: 22.0),
        child: Hero(
          tag: 'hero',
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            child: Image.asset('resources/images/png/logo.png'),
          ),
        ),
      ),
    );
    const heading = Padding(
      padding: EdgeInsets.only(left: 32, right: 32),
      child: AutoSizeText('Sistem Informasi Presensi Kepegawaian Kab. Pidie',
          maxLines: 3,
          minFontSize: 16,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
            fontSize: 23,
          ),
          textAlign: TextAlign.center),
    );
    final forgotLabel = TextButton(
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: const [
        Text("Lupa Password",
            style: TextStyle(color: Colors.black, fontSize: 13)),
        Icon(Icons.chevron_right, color: Colors.black)
      ]),
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => ForgetPassPage()));
      },
    );
    final alertDialogFailed = CupertinoAlertDialog(
      title: const Text('NIP atau Password Salah'),
      content: SingleChildScrollView(
        child: ListBody(
          children: const <Widget>[
            Text('Lakukan login kembali'),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('oke'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
    final loginButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 5.h),
      child: SizedBox(
        height: 60.h,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF8253F0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.sp),
            ),
          ),
          child: const AutoSizeText(
            'Login',
            maxFontSize: 18,
          ),
          onPressed: () async {
            setState(() {
              isLoading = true;
            });
            var response = await dataUser.attemptLogIn(
                nipController.text, passController.text, context);
            if (response.statusCode != 200) {
              showDialog<void>(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return alertDialogFailed;
                  });
            } else {
              if (dataUser.firstLogin) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            FirstPassResetPage()));
              } else {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => HomePage()),
                        (Route<dynamic> route) => false
                );
              }
            }
            setState(() {
              isLoading = false;
            });
          },
        ),
      ),
    );

    return Scaffold(
      backgroundColor: Color(0xFFF6F2FF),
      body: ModalProgressHUD(
        inAsyncCall: isLoading,
        child: Center(
          child: ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.only(left: 18.0, right: 18.0, top: 24.0),
            children: <Widget>[
              logo,
              heading,
              SizedBox(height: 48.0.h),
              if (MediaQuery.of(context).size.width <= 380) ...[
                NIPField(82, 20)
              ] else ...[
                NIPField(70, 16)
              ],
              SizedBox(height: 8.0.h),
              if (MediaQuery.of(context).size.width <= 380) ...[
                PasswordField(82, 20)
              ] else ...[
                PasswordField(70, 16)
              ],
              SizedBox(height: 20.0.h),
              loginButton,
              forgotLabel
            ],
          ),
        ),
      ),
    );
  }
}
