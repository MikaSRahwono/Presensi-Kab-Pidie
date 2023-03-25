part of '../_pages.dart';

class OTPCheckPage extends StatefulWidget {
  const OTPCheckPage({Key? key, required this.email}) : super(key: key);

  final String email;

  @override
  State<OTPCheckPage> createState() => _OTPCheckPageState();
}

class _OTPCheckPageState extends State<OTPCheckPage> {
  int endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 120;
  final kodeController = TextEditingController();
  CountdownTimerController? timerController;
  final TextEditingController _fieldOne = TextEditingController();
  final TextEditingController _fieldTwo = TextEditingController();
  final TextEditingController _fieldThree = TextEditingController();
  final TextEditingController _fieldFour = TextEditingController();
  final TextEditingController _fieldFive = TextEditingController();
  final TextEditingController _fieldSix = TextEditingController();
  bool isFull = false;
  String otpCode = "";

  @override
  void initState() {
    super.initState();
    timerController = CountdownTimerController(endTime: endTime);
  }

  @override
  void dispose() {
    kodeController.dispose();
    timerController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dataUser = Provider.of<UserProvider>(context);

    void setOtp() {
      otpCode = _fieldOne.text +
          _fieldTwo.text +
          _fieldThree.text +
          _fieldFour.text +
          _fieldFive.text +
          _fieldSix.text;
      if (otpCode.length == 6) {
        setState(() {
          isFull = true;
        });
      } else {
        setState(() {
          isFull = false;
        });
      }
      print(otpCode);
    }

    Widget PinField(
        TextEditingController controller, int height, int width, int fontSize) {
      return SizedBox(
        height: height.h,
        width: width.w,
        child: TextFormField(
          controller: controller,
          autofocus: false,
          obscureText: true,
          style: TextStyle(fontSize: fontSize.sp),
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          inputFormatters: [
            LengthLimitingTextInputFormatter(1),
            FilteringTextInputFormatter.digitsOnly
          ],
          onChanged: (value) {
            if (value.length == 1) {
              FocusScope.of(context).nextFocus();
              setOtp();
            } else if (value.length == 0) {
              FocusScope.of(context).previousFocus();
              setOtp();
            }
          },
        ),
      );
    }

    Widget KodeField(int height, int width, int fontSize) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Center(
            child: AutoSizeText(
              "Kode",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
              minFontSize: 18,
            ),
          ),
          SizedBox(
            height: 6,
          ),
          Container(
            height: height.h,
            margin: EdgeInsets.symmetric(horizontal: 12.w),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  PinField(_fieldOne, height, width, fontSize),
                  PinField(_fieldTwo, height, width, fontSize),
                  PinField(_fieldThree, height, width, fontSize),
                  PinField(_fieldFour, height, width, fontSize),
                  PinField(_fieldFive, height, width, fontSize),
                  PinField(_fieldSix, height, width, fontSize)
                ],
              ),
            ),
          ),
        ],
      );
    }

    final alertDialogFailed = CupertinoAlertDialog(
      title: const Text('Kode OTP Salah'),
      content: SingleChildScrollView(
        child: ListBody(
          children: const <Widget>[
            Text('silahkan masukkan ulang kode anda'),
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
    final sendButton = Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      margin: EdgeInsets.fromLTRB(30.w, 0, 30.w, 0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF8253F0),
          minimumSize: Size.fromHeight(50.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: const Text(
          'Submit',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        onPressed: () async {
          print(otpCode);
          var response = await otpCheck(widget.email, otpCode);
          print(response);
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
                        ChangePasswordForgotPage(email: widget.email)));
          }
        },
      ),
    );
    final disabledButton = Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      margin: EdgeInsets.fromLTRB(30.w, 0, 30.w, 0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF8253F0),
          minimumSize: Size.fromHeight(50.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: const Text(
          'Submit',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        onPressed: null,
      ),
    );
    final resendButton = Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      margin: EdgeInsets.fromLTRB(10.w, 0, 10.w, 0),
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
            backgroundColor: Colors.white,
            minimumSize: Size.fromHeight(50.h),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            side: BorderSide(color: Colors.black38)),
        child: const Text(
          'Kirim Ulang Kode',
          style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Color(0xFF8253F0)),
        ),
        onPressed: () async {
          print("start");
          setState(() {
            endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 120;
            timerController = CountdownTimerController(endTime: endTime);
          });
          forgetPass(widget.email);
        },
      ),
    );
    final resendCode = CountdownTimer(
        endTime: endTime,
        widgetBuilder: (_, CurrentRemainingTime? time) {
          if (time == null) {
            return Container(
                margin: EdgeInsets.symmetric(vertical: 20.h),
                child: resendButton);
          } else {
            return Padding(
                padding: EdgeInsets.all(40.h),
                child: Text(
                    'Kirim ulang kode dalam: ${time.min ?? "00"}:${time.sec}'));
          }
        });

    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        centerTitle: false,
        title: Text('Masukkan Kode',
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
                      padding: const EdgeInsets.only(
                          left: 20.0, top: 0.0, right: 20.0),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 90.w, vertical: 7.h),
                            child: Image.asset(
                                'resources/images/png/checkEmail.png'),
                          ),
                          Column(
                            children: [
                              const AutoSizeText(
                                "Cek Email Anda!",
                                maxFontSize: 30,
                                minFontSize: 24,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 10.h),
                              const Padding(
                                padding: EdgeInsets.fromLTRB(25.0, 0, 25.0, 0),
                                child: AutoSizeText(
                                  "Kami memberikan 6 digit kode pada email anda! Masukkan kode untuk melanjutkan reset password",
                                  textAlign: TextAlign.center,
                                  maxLines: 3,
                                  maxFontSize: 13,
                                ),
                              ),
                              SizedBox(
                                height: 30.h,
                              ),
                              KodeField(70, 30, 30),
                              resendCode,
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              if (!isFull) ...[disabledButton] else ...[sendButton]
            ],
          ),
        ),
      ),
    );
  }
}
