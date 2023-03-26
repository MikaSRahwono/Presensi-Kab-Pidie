part of '../_pages.dart';

class ForgetPassPage extends StatefulWidget {
  const ForgetPassPage({Key? key}) : super(key: key);

  @override
  State<ForgetPassPage> createState() => _ForgetPassPageState();
}

class _ForgetPassPageState extends State<ForgetPassPage> {
  final emailController = TextEditingController();
  bool isLoading = false;
  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dataUser = Provider.of<UserProvider>(context);
    // Step 1: panggil data user
    // final dataUser = Provider.of<UserProvider>(context);
    // Step 2: Jangan membuat widgets menjadi const
    // Step 3: dataUser.getFirstLogin()!.toString() ?? ''
    Widget EmailField(int height, int fontSize) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AutoSizeText(
            "Email",
            maxFontSize: 14,
          ),
          SizedBox(
            height: 6,
          ),
          Container(
            height: height.h,
            decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(color: Colors.black12),
                BoxShadow(
                    color: Color(0xFFF6F2FF), blurRadius: 10, spreadRadius: -5),
              ],
              borderRadius: BorderRadius.circular(10.sp),
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(15.0, 0, 5.0, 0),
                child: TextFormField(
                  autofocus: false,
                  controller: emailController,
                  decoration: InputDecoration(
                    hintText: 'Email',
                    border: InputBorder.none,
                  ),
                  style: TextStyle(fontSize: fontSize.sp),
                ),
              ),
            ),
          ),
        ],
      );
    }
    final alertDialogSuccess = CupertinoAlertDialog(
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
    );
    final alertDialogFailed = CupertinoAlertDialog(
      title: const Text('Gagal Mengirimkan Kode'),
      content: SingleChildScrollView(
        child: ListBody(
          children: const <Widget>[
            Text('silahkan masukkan ulang email anda'),
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
    final alertDialogNoAuth = CupertinoAlertDialog(
      title: const Text('Ubah Password Gagal'),
      content: SingleChildScrollView(
        child: ListBody(
          children: const <Widget>[
            Text('login ulang dengan'),
            Text('password yang telah diberikan'),
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
    );
    final sendButton = Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      margin: EdgeInsets.fromLTRB(0.w, 0, 0.w, 0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF8253F0),
          minimumSize: Size.fromHeight(50.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: const Text(
          'Kirimkan Kode',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        onPressed: () async {
          setState(() {
            isLoading = true;
          });
          var response = await forgetPass(emailController.text);
          if (response == 'Error') {
            showDialog<void>(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return alertDialogFailed;
                });
          } else {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) =>
                        OTPCheckPage(email: emailController.text)));
          }
          setState(() {
            isLoading = false;
          });
        },
      ),
    );

    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        centerTitle: false,
        title: Text('Lupa Password',
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w500,
            )),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_outlined),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: Color(0xFFF6F2FF),
      body: ModalProgressHUD(
        inAsyncCall: isLoading,
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(left: 10.w, right: 10.w, top: 10.h),
            child: Column(
              children: [
                Center(
                  child: Container(
                    decoration: const BoxDecoration(boxShadow: [
                      BoxShadow(color: Colors.black12, blurRadius: 10)
                    ]),
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.sp)),
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: 30.0.w, top: 0.0, right: 30.0.w),
                        child: Column(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 40.h),
                                const AutoSizeText(
                                  "Reset Password",
                                  maxFontSize: 35,
                                  minFontSize: 25,
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 0.h),
                                const Padding(
                                  padding: EdgeInsets.fromLTRB(0.0, 0, 25.0, 0),
                                  child: AutoSizeText(
                                    "Masukkan email yang terdaftar pada akun anda untuk melakukan reset password anda",
                                    textAlign: TextAlign.left,
                                    maxLines: 3,
                                    maxFontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 25.h),
                            if (MediaQuery.of(context).size.width <= 360) ...[
                              EmailField(90, 20)
                            ] else ...[
                              EmailField(55, 16)
                            ],
                            SizedBox(height: 30.h),
                            sendButton,
                            SizedBox(height: 20.h)
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
