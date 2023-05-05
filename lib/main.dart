part of '_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.removeAfter(initialization);
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => UserProvider()),
    ],
    child: MyApp(),
  ));
}

Future initialization(BuildContext? context) async {
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Presensi',
        theme: ThemeData(
            appBarTheme: AppBarTheme(
              color: Colors.white,
              foregroundColor: Colors.black,
              iconTheme: IconThemeData(color: Color.fromRGBO(130, 83, 240, 1)),
            ),
            primaryColor: Colors.black,
            fontFamily: 'poppins'),

        home: CheckAuth(),
      ),
      designSize: const Size(390, 844),
    );
  }
}