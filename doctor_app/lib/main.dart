
import 'dart:io';

import 'package:get/get_navigation/get_navigation.dart';
import 'package:doctor_app/consts/consts.dart';
import 'package:doctor_app/views/splash_screen/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Platform.isAndroid?
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyD9w86x1LxbPlHpPXd8O2Le1DJ34GpxrPQ",
      appId: "1:124043125156:android:6c33211f066c84d1062131",
      messagingSenderId: "124043125156",
      projectId: "mobile-doctor-3317b",
      storageBucket: "mobile-doctor-3317b.appspot.com",
    ),
  )
  :await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: appname,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.transparent,
        appBarTheme: const AppBarTheme(backgroundColor: Colors.transparent),
        fontFamily: regular,
      ),
      home: const splash_screen(), 
    );
  }
}

