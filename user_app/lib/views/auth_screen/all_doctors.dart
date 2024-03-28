import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_app/consts/consts.dart';
import 'package:user_app/controllers/firestoreService.dart';

import 'package:user_app/views/auth_screen/doctor_profile.dart';
import 'package:user_app/views/auth_screen/document_screen.dart';
import 'package:user_app/views/auth_screen/home_screen.dart';
import 'package:user_app/views/auth_screen/profile.dart';

class allDoctor extends StatefulWidget {
  final dynamic category;
  final dynamic search;

  const allDoctor({Key? key, this.category, this.search}) : super(key: key);

  @override
  _AllDoctorState createState() => _AllDoctorState();
}

class _AllDoctorState extends State<allDoctor> {

  bool? isCheck=false;

  final selectedIndex = 2;
  String s="";
  void initState() {
    super.initState();
    s = widget.search ?? ''; // Initialize s with widget.search or an empty string
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
        actions: [
          Row(
            children: [
              const Text(
              "Available doctor",
              style: TextStyle(
                color: whiteColor,
                fontSize: 14,
                fontWeight: FontWeight.w500,
                
              ),
            ),
            Checkbox(
                    checkColor: whiteColor,
                    value: isCheck, onChanged: (newValue){
                      setState(() {
                        isCheck=newValue;
                      });
                      
                  },
                  ),
            ],
          )
        ],
        
        
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
            stream: FirestoreServices.getDoctor(category: widget.category),
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
              var ddata;
              if(isCheck!=false)
              {
                    Timestamp timestamp = Timestamp.now();

                    DateTime dateTime = timestamp.toDate();
                    String formattedTime = "${dateTime.hour}:${dateTime.minute}:${dateTime.second}";
                    if(formattedTime[1] == ':')
                    {
                      formattedTime = "0"+formattedTime;
                    }
                    print(formattedTime);

                    ddata = snapshot.data!.docs.where((doctor) =>
                    doctor['name'].toString().toLowerCase().contains(s.toLowerCase()) &&
                    doctor['start-time'] is String &&
                    doctor['end-time'] is String &&
                    doctor['start-time'].compareTo(formattedTime) <= 0 &&
                    doctor['end-time'].compareTo(formattedTime) >= 0
                  ).toList();

              }
              else{
                    ddata = snapshot.data!.docs.where((doctor) =>
                      doctor['name'].toString().toLowerCase().contains(s.toLowerCase())
                          ).toList();
              }
              

              
            
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