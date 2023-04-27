part of '_pages.dart';

class CheckAuth extends StatefulWidget {
  @override
  _CheckAuthState createState() => _CheckAuthState();
}

class _CheckAuthState extends State<CheckAuth> {
  bool isAuth = false;
  final _myFuture = AsyncMemoizer<bool>();

  Future<bool> loginCheckFuture(UserProvider dataUser, HelperDialog helperDialog) async {
    return _myFuture.runOnce(() async {
      if (await dataUser.isLoggedIn()) {
        await dataUser.getDataPresensi();
        if (dataUser.getTokenIsValid()! == false) {
          if (mounted) {
            dataUser.logout();
            helperDialog.checkAuthDialog(context);
          }
        }
        await dataUser.getDataUser();
          if (dataUser.getTokenIsValid()! == false) {
            if (mounted) {
              dataUser.logout();
              helperDialog.checkAuthDialog(context);
            }
          }
        return true;
      }
      return false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final UserProvider dataUser = Provider.of<UserProvider>(context);
    HelperDialog helperDialog = HelperDialog();

    Widget child;
    return FutureBuilder(
        future: loginCheckFuture(dataUser, helperDialog),
        builder: (context, snapshot){

          if(snapshot.hasData){
            if(snapshot.data == true){
              child = HomePage();
            } else {
              child = LoginPage();
            }
          } else{
            // future hasnt completed yet
            child = SplashScreen();
          }

          return Scaffold(
            body: child,
          );
        }
    );
  }
}