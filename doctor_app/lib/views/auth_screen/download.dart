
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_app/controllers/firestoreService.dart';
import 'package:doctor_app/controllers/profile_change_controller.dart';

import 'package:flutter/material.dart';
import 'package:doctor_app/consts/consts.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';


import 'package:url_launcher/url_launcher.dart';

class downloadScreen extends StatefulWidget {
  final dynamic user_id;
  downloadScreen({super.key,this.user_id});

  @override
  State<downloadScreen> createState() => _downloadScreenState();
}
class _downloadScreenState extends State<downloadScreen> {

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProfileController());
    return Scaffold(
      backgroundColor: const Color(0xFFD9E4EE),
      appBar: AppBar(
        backgroundColor: bluecolor,
        elevation: 0.0,
        title: const Text(
              "Prescriptions and reports",
              style: TextStyle(
                color: whiteColor,
                fontSize: 22,
                fontWeight: FontWeight.w500,
                fontFamily: bold,
              ),
            ),
          automaticallyImplyLeading: true,
      ),
      body: StreamBuilder(
        stream: FirestoreServices.getFile(uid: widget.user_id,doctorID: currentUser!.uid),
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
              child: "No file found".text.color(bColor).make(),
            );
          }
          var data = snapshot.data!.docs;
          return ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: data.length,
            itemBuilder: (context, index) {
              
              return GestureDetector(
                onTap: (){
                                
                              },
                child: Column(
              
                  children: [
                    ListTile(
                      leading: IconButton(
                          onPressed: () async {
                            String url = data[index]['url'];
                            if (await canLaunch(url)) {
                            await launch(url);
                            } else {
      
                            VxToast.show(context, msg: "could not download file");
                            }
          
                          }, 
                          icon: const Icon(
                          Icons.download,
                          color: bColor,
                          )
                          ),
                    title: Text(
                        "${data[index]['file-name']}",
                        style: const TextStyle(
                        color: bColor,
                        fontSize: 18,
                        fontFamily: bold,
                        fontWeight: FontWeight.w500,
                       ),
                       ),
                    
                      trailing: IconButton(
                      onPressed: () async {
                        setState(() async {
                          await firestore.collection("files").doc(data[index].id).delete();
                        });
                          
          
                      }, 
                      icon: const Icon(
                      Icons.delete,
                      color: bColor,
                      )
                      ),
                    tileColor: whiteColor,
                    ),
                    1.heightBox,
                  ],
                ),
              );
            },
          );
        }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          setState(() {
            controller.selectFile(userId: widget.user_id);
          });
        },
        child: const Icon(Icons.upload_file,size: 30,),
        ),
    );
  }
}