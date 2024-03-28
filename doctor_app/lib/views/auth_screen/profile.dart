import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_app/controllers/auth_controller.dart';
import 'package:doctor_app/controllers/firestoreService.dart';
import 'package:doctor_app/controllers/profile_change_controller.dart';
import 'package:doctor_app/views/auth_screen/details_card.dart';
import 'package:doctor_app/views/auth_screen/login_screen.dart';
import 'package:doctor_app/views/auth_screen/update_info.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:doctor_app/consts/consts.dart';

import 'package:get/get.dart';


class user_profile extends StatelessWidget {
  const user_profile({super.key});

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
          var email2 = data['email'];
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
                  const SizedBox(height:20),
                  SizedBox(
                    width: 250,
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
                    width: 250,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: (){
                        controller.addressController.text=data['address'];
                        controller.timeController.text=data['start-time'];
                        controller.timeController2.text=data['end-time'];
                        controller.specialityController.text=data['speciality'];
                        controller.serviceController.text=data['services'];
                        controller.phoneController.text=data['phone'];
                        Get.to(()=> update_info(
                          data: data,
                        ));
                      }, 
                      child: const Text(
                                    "Update Information",
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
                  const SizedBox(height:20),
                  SizedBox(
                    width: 200,
                    height: 50,
                    child: ElevatedButton(
                    onPressed: () async {

                                      
                                      await firestore
                                      .collection("calls")
                                      .where('doctor-id', isEqualTo: currentUser!.uid)
                                      .get()
                                      .then((querySnapshot) {
                                      querySnapshot.docs.forEach((doc) {
                                      doc.reference.delete();
                                      });
                                      });
                                      await firestore.collection(doctorsCollection).doc(currentUser!.uid).delete();
                                      AuthCredential credential = EmailAuthProvider.credential(email: email2, password: authpass);
                                      await currentUser!.reauthenticateWithCredential(credential).then((value) {
                                        print("kaj korse");
                                      currentUser!.delete().then((value) => {
                                          Get.offAll(() => loginscreen())
                                      });
                                      }).catchError((error){
                                      print(error.toString());
                                       });
                                      
                                    },  
                    child: const Text(
                                "Delete Account",
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
                  const SizedBox(height:30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      detailsCard(count: "${data['total-call']}",title: "Total Call Recieved",width: context.screenWidth/2.5),
                      //detailsCard(count: "${data['total-revenue']}",title: "Total Money Earned",width: context.screenWidth/2.5),
                    ],
                  )
                  
                      
                ],
              ),
            ),
          );
          }
        },
      ),
    );
  }
}