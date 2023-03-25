part of '_pages.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({Key? key}) : super(key: key);

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  bool _prevpasswordVisible = true;
  bool _passwordVisible1 = true;
  bool _passwordVisible2 = true;

  final prevpassController = TextEditingController();
  final passController1 = TextEditingController();
  final passController2 = TextEditingController();

  @override
  void initState() {
    _prevpasswordVisible = false;
    _passwordVisible1 = false;
    _passwordVisible2 = false;
  }

  @override
  void dispose() {
    prevpassController.dispose();
    passController1.dispose();
    passController2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dataUser = Provider.of<UserProvider>(context);
    // Step 1: panggil data user
    // final dataUser = Provider.of<UserProvider>(context);
    // Step 2: Jangan membuat widgets menjadi const
    // Step 3: dataUser.getFirstLogin()!.toString() ?? ''
    Widget PreviousPasswordField(int height, int fontSize) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AutoSizeText(
            "Password Sebelumnya",
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
                  controller: prevpassController,
                  obscureText: !_prevpasswordVisible,
                  decoration: InputDecoration(
                      hintText: 'Password',
                      border: InputBorder.none,
                      suffixIcon: SizedBox(
                        height: 10.h,
                        child: IconButton(
                          icon: Icon(
                              _prevpasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.black),
                          onPressed: () {
                            setState(() {
                              _prevpasswordVisible = !_prevpasswordVisible;
                            });
                          },
                        ),
                      )),
                  style: TextStyle(fontSize: fontSize.sp),
                ),
              ),
            ),
          ),
        ],
      );
    }

    Widget PasswordField(int height, int fontSize) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AutoSizeText(
            "Password Baru",
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
                  controller: passController1,
                  obscureText: !_passwordVisible1,
                  decoration: InputDecoration(
                      hintText: 'Password',
                      border: InputBorder.none,
                      suffixIcon: SizedBox(
                        height: 10.h,
                        child: IconButton(
                          icon: Icon(
                              _passwordVisible1
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.black),
                          onPressed: () {
                            setState(() {
                              _passwordVisible1 = !_passwordVisible1;
                            });
                          },
                        ),
                      )),
                  style: TextStyle(fontSize: fontSize.sp),
                ),
              ),
            ),
          ),
        ],
      );
    }

    Widget RepeatPasswordField(int height, int fontSize) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AutoSizeText(
            "Ulangi Password Baru",
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
                  controller: passController2,
                  obscureText: !_passwordVisible2,
                  decoration: InputDecoration(
                      hintText: 'Ulangi Password',
                      border: InputBorder.none,
                      suffixIcon: SizedBox(
                        height: 10.h,
                        child: IconButton(
                          icon: Icon(
                            _passwordVisible2
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.black,
                          ),
                          onPressed: () {
                            setState(() {
                              _passwordVisible2 = !_passwordVisible2;
                            });
                          },
                        ),
                      )),
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
      title: const Text('Password tidak sama'),
      content: SingleChildScrollView(
        child: ListBody(
          children: const <Widget>[
            Text('password anda tidak sama'),
            Text('masukkan password baru anda kembali'),
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
    final saveButton = Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      margin: EdgeInsets.fromLTRB(40.w, 0, 40.w, 0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF8253F0),
          minimumSize: Size.fromHeight(50.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: const Text(
          'Simpan',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        onPressed: () async {
          var response = await dataUser.changePassword(prevpassController.text,
              passController1.text, passController2.text);
          print(response);
          if (response == 'Password tidak sama') {
            showDialog<void>(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return alertDialogFailed;
                });
          } else if (response ==
              "Authentication credentials were not provided.") {
            showDialog<void>(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return alertDialogNoAuth;
                });
          } else {
            showDialog<void>(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return alertDialogSuccess;
                });
          }
        },
      ),
    );

    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        centerTitle: false,
        title: Text('Ubah Password',
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontWeight: FontWeight.w500,
            )),
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
                      padding: EdgeInsets.all(30.w),
                      child: Column(
                        children: [
                          if (MediaQuery.of(context).size.width <= 360) ...[
                            PreviousPasswordField(90, 20)
                          ] else ...[
                            PreviousPasswordField(55, 16)
                          ],
                          SizedBox(height: 20.h),
                          if (MediaQuery.of(context).size.width <= 360) ...[
                            PasswordField(90, 20)
                          ] else ...[
                            PasswordField(55, 16)
                          ],
                          SizedBox(height: 20.h),
                          if (MediaQuery.of(context).size.width <= 360) ...[
                            RepeatPasswordField(85, 20)
                          ] else ...[
                            RepeatPasswordField(55, 16)
                          ],
                          SizedBox(
                            height: 20.h,
                          )
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
