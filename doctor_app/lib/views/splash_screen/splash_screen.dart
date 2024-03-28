import 'package:doctor_app/consts/consts.dart';

import 'package:doctor_app/views/auth_screen/login_screen.dart';
import 'package:doctor_app/widgets_common/navbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';


class splash_screen extends StatelessWidget {
  const splash_screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              bluecolor.withOpacity(0.8),
              bluecolor,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Image.asset(icDoctors),
            ),
            const SizedBox(height: 50),
            const Text(
              "Online Doctors",
              style: TextStyle(
                color: whiteColor,
                fontSize: 35,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
                wordSpacing: 2,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Contact to doctor",
              style: TextStyle(
                color: whiteColor,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 60),
            Material(
              color: whiteColor,
              borderRadius: BorderRadius.circular(10),
              child: InkWell(
                onTap: () {
                  auth.authStateChanges().listen((User? user) {
                    if(user == null){
                      Get.to(()=>loginscreen());
                    }
                    else{
                      Get.offAll(()=>Navbar());
                    }
                  });
                  //  Navigator.push(context, MaterialPageRoute(
                  //    builder: (context) => const loginscreen(),
                  //    ));
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 40),
                  child: const Text(
                    "Let's Go",
                    style: TextStyle(
                      color: bluecolor,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
            Image.asset(
              icBigheart,
              color: whiteColor,
              scale: 2,
              ),
          ],
        ),
      ),
    );
  }
}