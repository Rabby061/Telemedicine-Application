import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:user_app/consts/consts.dart';
import 'package:user_app/controllers/auth_controller.dart';
import 'package:user_app/controllers/firestoreService.dart';
import 'package:user_app/controllers/profile_change_controller.dart';
import 'package:user_app/views/auth_screen/all_doctors.dart';


import 'package:get/get.dart';
import 'package:user_app/views/auth_screen/document_screen.dart';
import 'package:user_app/views/auth_screen/home_screen.dart';
import 'package:user_app/views/auth_screen/login_screen.dart';


class user_profile extends StatelessWidget {
  const user_profile({super.key});
  final selectedIndex=3;

  @override
  Widget build(BuildContext context) {

    var controller = Get.put(ProfileController());

    return Scaffold(
      backgroundColor: const Color(0xFFD9E4EE),
      appBar: AppBar(
        backgroundColor: bluecolor,
        elevation: 0.0,
        automaticallyImplyLeading: false,
        title: const Text(
              "Profile",
              style: TextStyle(
                color: whiteColor,
                fontSize: 22,
                fontWeight: FontWeight.w500,
                fontFamily: bold,
              ),
            ),
      ),
      body: StreamBuilder(
        stream: FirestoreServices.getUser(currentUser!.uid), 
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if(!snapshot.hasData)
          {
            return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(redColor),
              ),
            );
          }
          else{

            var data = snapshot.data!.docs[0];

            return SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              const SizedBox(height:20),
              Stack(
                children: [
                  SizedBox(
                    width: 120, height: 120,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: data['imageUrl'] == '' ?
                      Image.asset(doctor1)
                      :
                      Image.network(data['imageUrl'])
                      ),
                      
                  ),
                  Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                  width: 35,
                  height: 35,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: bluecolor,
                  ),
                  child: IconButton(
                              onPressed: () async {
                                await controller.changeImage(context);
                                await controller.uploadProfileImage();
                                await controller.updateProfile(controller.profileImgLink);

                              }, 
                              icon: const Icon(
                              LineAwesomeIcons.alternate_pencil,
                              color: whiteColor,
                              size: 20,
                            )
                        ),
                ),
              ),
              ],
              ),
      
              const SizedBox(height:20),
              Text(
                              "${data['name']}",
                              style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: bold,
                                  color: bColor,
                                ),
                            ),
              const SizedBox(height:10),
              Text(
                              "${data['email']}",
                              style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: bColor,
                                ),
                            ),
              const SizedBox(height:10),
              Text(
                              "Phone: ${data['phone']}",
                              style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: bColor,
                                ),
              ),
              const SizedBox(height:20),
              SizedBox(
                width: 200,
                height: 50,
                child: ElevatedButton(
                  onPressed: () async {
                    try  {
                    await FirebaseAuth.instance.sendPasswordResetEmail(email: data['email']);
                    VxToast.show(context, msg: "Email send");
                  } on FirebaseAuthException catch (e) {
                    VxToast.show(context, msg: "${e}");
                  }
                  }, 
                  child: const Text(
                                "Change Password",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    color: whiteColor,
                                  ),
                    ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: bluecolor,
                    side: BorderSide.none,
                    shape: const StadiumBorder(),
                  ),
                ),
              ),
              const SizedBox(height:20),
              SizedBox(
                width: 200,
                height: 50,
                child: ElevatedButton(
                  onPressed: () async {
                                      await Get.put(AuthController()).signoutMethod(context);
                                      Get.offAll(() => loginscreen());
                                    },  
                  child: const Text(
                                "Logout",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    color: whiteColor,
                                  ),
                    ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: bluecolor,
                    side: BorderSide.none,
                    shape: const StadiumBorder(),
                  ),
                ),
              ),
              const Divider(),
              const SizedBox(height:50),
              
            ],
          ),
        ),
        );
          }
        },
      ),

      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.white.withOpacity(0.5),
        selectedItemColor: whiteColor,
        selectedLabelStyle: const TextStyle(
          color: whiteColor,
        ),
        selectedIconTheme: const IconThemeData(
          color: whiteColor,
        ),
        backgroundColor: Colors.blue,
        type: BottomNavigationBarType.fixed,
        currentIndex: selectedIndex,
        onTap: (value) {
          if(value==0)
          {
            Get.offAll(()=> home_screen());
          }
          else if(value==1)
          {
            Get.offAll(()=> documentScreen());
          }
          else if(value==2)
          {
            Get.offAll(()=> allDoctor(category: "",search: "",));
          }
          else if(value==3)
          {
            Get.offAll(()=> user_profile());
          }
        },
        items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home),label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.file_copy_rounded),label: "Documents"),
        BottomNavigationBarItem(icon: Icon(Icons.person),label: "Doctor"),
        BottomNavigationBarItem(icon: Icon(Icons.settings),label: "Profile"),

      ],),
    );
  }
}