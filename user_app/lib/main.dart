
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:user_app/consts/consts.dart';
import 'package:user_app/views/splash_screen/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Platform.isAndroid?
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyD9w86x1LxbPlHpPXd8O2Le1DJ34GpxrPQ",
      appId: "1:124043125156:android:3f377a751902c2ac062131",
      messagingSenderId: "124043125156",
      projectId: "mobile-doctor-3317b",
      storageBucket: "mobile-doctor-3317b.appspot.com",
    ),
  )
  :await Firebase.initializeApp();
  Stripe.publishableKey='pk_test_51OFsCPE1fmwNrbV1neEzpnt1ezNnLMGoIgoH7CY0yscK7XLRJqfLmphZ5uAsnpForoiLSvrDXC7EZTkgFZjgWGw300kmEvx2cO';
  await Stripe.instance.applySettings();
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
      home: splash_screen(), 
    );
  }
}

