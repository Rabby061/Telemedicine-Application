import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_app/controllers/firestoreService.dart';
import 'package:doctor_app/views/auth_screen/download.dart';

import 'package:flutter/material.dart';
import 'package:doctor_app/consts/consts.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:get/get.dart';

class documentScreen extends StatefulWidget {
  documentScreen({super.key});

  @override
  State<documentScreen> createState() => _documentScreenState();
}
class _documentScreenState extends State<documentScreen> {
 

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
        automaticallyImplyLeading: false,
        
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
              child: "No patient found".text.color(bColor).make(),
            );
          }
          var data = snapshot.data!.docs;

          return ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: data.length,
            itemBuilder: (context, index) {

              return StreamBuilder(
                stream: FirestoreServices.getPatient2(id:data[index]['user-id']),
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
                                    Get.to(()=> downloadScreen(user_id: ddata['id'],));
                                  },
                    child: Column(
                  
                      children: [
                        ListTile(
                        leading: CircleAvatar(
                                    radius: 25,
                                    backgroundImage: ddata['imageUrl'] == ''
                                    ? const AssetImage(doctor1) as ImageProvider<Object>
                                    : NetworkImage(ddata['imageUrl']),
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
                      
                    trailing:  Column(
                      children: [
                        GestureDetector(
                        onTap: () {
                            //payment();
                            
                            
                            FlutterPhoneDirectCaller.callNumber(ddata['phone']).then((value) => {
                                
                            });
                            
                        },
                        child: Container(
                          width: 40,
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.amber,
                          ),
                          child: const Icon(Icons.phone,color: whiteColor,)),
                      ),
                        Text(
                            "${formattedDateTime}",
                            style: TextStyle(
                            color: bColor,
                            fontSize: 14,
                                      
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
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
    );
  }
}