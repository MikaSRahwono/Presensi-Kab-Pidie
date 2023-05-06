part of '_pages.dart';

class CheckAuth extends StatefulWidget {
  @override
  _CheckAuthState createState() => _CheckAuthState();
}

class _CheckAuthState extends State<CheckAuth> {
  bool isAuth = false;

  @override
  Widget build(BuildContext context) {
    final UserProvider dataUser = Provider.of<UserProvider>(context);
    HelperDialog helperDialog = HelperDialog();
    HelperMethod helperMethod = HelperMethod();

    Widget child;
    return FutureBuilder(
        future: helperMethod.loginCheckFuture(context,dataUser, helperDialog),
        builder: (context, snapshot){

          if(snapshot.hasData){
            if(snapshot.data == true){
              child = HomePage();
            } else {
              child = LoginPage();
            }
          } else{
            // Future hasn't completed yet
            child = ProfilePage();
          }

          return Scaffold(
            body: child,
          );
        }
    );
  }
}