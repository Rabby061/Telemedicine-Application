import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:admin_app/consts/consts.dart';
import 'package:admin_app/controllers/firestoreService.dart';

import 'package:admin_app/views/auth_screen/doctor_profile.dart';


class allDoctor extends StatefulWidget {

  const allDoctor({Key? key}) : super(key: key);

  @override
  _AllDoctorState createState() => _AllDoctorState();
}

class _AllDoctorState extends State<allDoctor> {

  

  final selectedIndex = 2;
  String s="";
  void initState() {
    super.initState();
    s = ''; // Initialize s with widget.search or an empty string
  }

  @override
  Widget build(BuildContext context) {
    

    
    
    return Scaffold(
      backgroundColor: const Color(0xFFD9E4EE),
      appBar: AppBar(
        backgroundColor: bluecolor,
        elevation: 0.0,
        title: const Text(
              "All Doctor",
              style: TextStyle(
                color: whiteColor,
                fontSize: 22,
                fontWeight: FontWeight.w500,
                fontFamily: bold,
              ),
            ),
        automaticallyImplyLeading: true,
        
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
                            margin: const EdgeInsets.only(top: 10,bottom: 10),
                            width: MediaQuery.of(context).size.width,
                            height: 55,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: whiteColor,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: const [
                                BoxShadow(
                                  color: sdColor,
                                  blurRadius: 6,
                                  spreadRadius: 3,
                                ),
          
                              ],
                            ),
                            child: TextFormField(
                              
                              
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Search here...",
                                hintStyle: TextStyle(
                                  color: Colors.black.withOpacity(0.5),
                                ),
                                prefixIcon: IconButton(
                                  icon: const Icon(
                                    Icons.search,
                                    size: 25,
                                  ),
                                  onPressed: () {
                                    
                                    
                                  },
                                ),
                                
                                
                              ),
                              onChanged: (value) {
                                setState(() {
                                  s=value;
                                });
                              },
                            ),
                          ),
          ),
          StreamBuilder(
            stream: FirestoreServices.getDoctor(),
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
            else{
              var ddata = snapshot.data!.docs.where((doctor) =>
                      doctor['name'].toString().toLowerCase().contains(s.toLowerCase())
                          ).toList();

              
            
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left:10.0,right: 10.0),
                  child: GridView.builder(
                  physics: const BouncingScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 18,
                    crossAxisSpacing: 8,
                    mainAxisExtent: 300,
                  ),
                  itemCount: ddata.length,
                  itemBuilder: (context,index){
                    var ddata2=ddata[index];
                    
                    

                    
                    return GestureDetector(
                      onTap: (){
                                      Get.to(()=> doctorProfile(ddata2: ddata2,));
                                    },
                      child: Column(
                    
                        children: [
                          Container(
                            height: 300,
                            width: 200,
                            
                            decoration: BoxDecoration(
                              color: const Color(0xFFF2F8FF),
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: const [
                                BoxShadow(
                                  color: sdColor,
                                  blurRadius: 4,
                                  spreadRadius: 2,
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Stack(
                                  children: [
                                      ClipRRect(
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(15),
                                          topRight: Radius.circular(15),
                                        ),
                                        child: ddata[index]['imageUrl'] == '' ?
                                        Image.asset(
                                          doctor1,
                                          height: 200,
                                          width: 200,
                                          fit: BoxFit.cover,
                                        
                                        )
                                        :
                                        Image.network(
                                          ddata[index]['imageUrl'],
                                          height: 200,
                                          width: 200,
                                          fit: BoxFit.cover,
                                          )
                                      ),
                                    
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Padding(
                                  padding:EdgeInsets.symmetric(horizontal: 5),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${ddata[index]['name']}",
                                        style: TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.w500,
                                            color: bluecolor,
                                          ),
                                      ),
                                      Text(
                                        "${ddata[index]['speciality']}",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                            color: bColor.withOpacity(0.6),
                                          ),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        "Total service: ${ddata[index]['total-call']}",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                            color: bColor.withOpacity(0.8),
                                          ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                    
                  } 
                  
                ),
              
                ),
              );
            }
            }
          ),
        ],
      ),

      
      
    );
  }
}