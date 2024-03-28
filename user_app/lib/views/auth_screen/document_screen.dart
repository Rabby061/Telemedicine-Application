import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:user_app/controllers/firestoreService.dart';
import 'package:user_app/views/auth_screen/all_doctors.dart';
import 'package:user_app/views/auth_screen/doctor_profile.dart';
import 'package:user_app/views/auth_screen/download.dart';
import 'package:user_app/views/auth_screen/home_screen.dart';
import 'package:user_app/views/auth_screen/profile.dart';

import 'package:flutter/material.dart';
import 'package:user_app/consts/consts.dart';
import 'package:get/get.dart';

class documentScreen extends StatefulWidget {
  documentScreen({super.key});

  @override
  State<documentScreen> createState() => _documentScreenState();
}
class _documentScreenState extends State<documentScreen> {
  int selectedIndex=1;
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD9E4EE),
      appBar: AppBar(
        backgroundColor: bluecolor,
        elevation: 0.0,
        title: const Text(
              "Reports & prescriptions",
              style: TextStyle(
                color: whiteColor,
                fontSize: 22,
                fontWeight: FontWeight.w500,
                fontFamily: bold,
              ),
            ),
      ),
      body: StreamBuilder(
        stream: FirestoreServices.getCall(currentUser!.uid),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {

          if(!snapshot.hasData)
          {
            return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(redColor),
              ),
            );
          }
          else if(snapshot.data!.docs.isEmpty){
              return Center(
              child: "No doctor found".text.color(bColor).make(),
            );
          }
          var data = snapshot.data!.docs;

          return ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: data.length,
            itemBuilder: (context, index) {

              return StreamBuilder(
                stream: FirestoreServices.getDoctor2(id:data[index]['doctor-id']),
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot2) {

                  if(!snapshot2.hasData)
                  {
                    return const Center(
                    child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(redColor),
                    ),
                  );
                  }
                  
                  var ddata=snapshot2.data!.docs[0];
                  Timestamp timestamp = data[index]['time'];

                  DateTime dateTime = timestamp.toDate();
                  String formattedDateTime = "${dateTime.year}-${dateTime.month}-${dateTime.day} ${dateTime.hour}:${dateTime.minute}:${dateTime.second}";
                  return GestureDetector(
                    onTap: (){
                                    Get.to(()=> downloadScreen(doctor_id: ddata['id'],));
                                  },
                    child: Column(
                  
                      children: [
                        ListTile(
                        leading: GestureDetector(
                            onTap: () {
                              Get.to(()=> doctorProfile(ddata2: ddata,));
                            },
                            child: CircleAvatar(
                              radius: 25,
                              backgroundImage: ddata['imageUrl'] == ''
                                  ? const AssetImage(doctor1) as ImageProvider<Object>
                                  : NetworkImage(ddata['imageUrl']),
                            ),
                          ),
                        title: Text(
                        "${ddata['name']}",
                        style: const TextStyle(
                        color: bColor,
                        fontSize: 18,
                        fontFamily: bold,
                        fontWeight: FontWeight.w500,
                        ),
                      ),
                      
                    trailing:  Text(
                        "${formattedDateTime}",
                        style: TextStyle(
                        color: bColor,
                        fontSize: 14,
                                  
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    tileColor: whiteColor,
                    ),
                        1.heightBox,
                      ],
                    ),
                  );
                }
              );
            },
          );
        }
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