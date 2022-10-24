import 'imports.dart';

int? isViewed ;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  isViewed = prefs.getInt("onBoard");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Assessment',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: isViewed != 0 || isViewed == null ? OnBoard() : const HomeScreen(),
      // initialRoute: initScreen == true ? "onboard" : "/",
      // routes: {
      //   '/': (context) => HomeScreen(),
      //   'onboard': (context) => OnBoardingScreen(),
      // }
    );
  }
}


