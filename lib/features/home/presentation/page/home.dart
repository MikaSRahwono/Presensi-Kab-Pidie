part of '_pages.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    // Step 1: panggil data user
    final dataUser = Provider.of<UserProvider>(context);
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: const Text("Presensi"),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF8253F0),
                minimumSize: const Size.fromHeight(50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'testing get request',
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              onPressed: () async {
                var response = await dataUser
                    .getRequestWithJWT("https://randomfox.ca/floof/");
                // Map resMap = json.decode(response);
                // TODO: Session flutter buat tokennya
                if (response.statusCode == 200) {
                  print("berhasil");
                  print(response.body);
                } else {
                  print("gagal get");
                }
                // if (dataUser.firstLogin) {
                //   Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => FirstPassResetPage()));
                // }
                // else{
                //   Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => HomePage()));
                // }
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => ProfilePage()));
        },
        label: Text("Profile"),
        icon: Icon(Icons.person),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
