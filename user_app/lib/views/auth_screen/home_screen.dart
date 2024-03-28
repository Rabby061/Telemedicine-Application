

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:user_app/consts/consts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:user_app/controllers/auth_controller.dart';
import 'package:user_app/controllers/firestoreService.dart';

import 'package:user_app/views/auth_screen/all_doctors.dart';

import 'package:user_app/views/auth_screen/doctors_section.dart';
import 'package:user_app/views/auth_screen/document_screen.dart';
import 'package:user_app/views/auth_screen/login_screen.dart';
import 'package:user_app/views/auth_screen/profile.dart';

class home_screen extends StatelessWidget {
  home_screen({super.key});


  final selectedIndex=0;
  final List catNames=[
    "Dental",
    "Heart",
    "Eye",
    "Brain",
    "Ear",
  ];

  final List<Icon> catIcons=[
    Icon(MdiIcons.toothOutline,color: bluecolor,size: 30),
    Icon(MdiIcons.heartPlus,color: bluecolor,size: 30),
    Icon(MdiIcons.eye,color: bluecolor,size: 30),
    Icon(MdiIcons.brain,color: bluecolor,size: 30),
    Icon(MdiIcons.earHearing,color: bluecolor,size: 30),
  ];

  @override
  Widget build(BuildContext context) {

    
    var search=TextEditingController();
    return Scaffold(
      body: Material(
        color: const Color(0xFFD9E4EE),
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height/3,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      bluecolor.withOpacity(0.8),
                      bluecolor,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter, 
                  ),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: StreamBuilder(
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
                          var data = snapshot.data!.docs[0];
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  CircleAvatar(
                                    radius: 30,
                                    backgroundImage: data['imageUrl'] == ''
                                    ? const AssetImage(doctor1) as ImageProvider<Object>
                                    : NetworkImage(data['imageUrl']),
                                  ),
                                  IconButton(
                                    onPressed: () async {
                                      await Get.put(AuthController()).signoutMethod(context);
                                      Get.offAll(() => loginscreen());
                                    }, 
                                    icon: const Icon(
                                    Icons.logout_outlined,
                                    color: whiteColor,
                                    size: 30,
                                    )
                                  ),
                                ],
                              ),
                              const SizedBox(height: 15),
                              Text(
                                "Hi, ${data['name']}",
                                style: TextStyle(
                                  color: whiteColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              const SizedBox(height: 10),
                              const Text(
                                "Your Health is Our\nFirst Priority",
                                style: TextStyle(
                                  color: whiteColor,
                                  fontSize: 25,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 15,bottom: 20),
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
                                  controller: search,
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
                                        
                                        Get.offAll(()=> allDoctor(category: "",search: search.text.toString(),));
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        }
                      ),
                    ),
                    Padding(padding: const EdgeInsets.only(left: 15),
                      child: Text("Catagories",style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: bColor.withOpacity(0.7),
                      ),),
                    ),
                    const SizedBox(height:15),
                    Container(
                      height: 100,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: catNames.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: (){
                                        Get.offAll(()=> allDoctor(category: catNames[index].toString().toLowerCase(),));
                                      },
                            child: Column(
                              children: [
                                Container(
                                  margin: const EdgeInsets.symmetric(vertical: 5,horizontal: 15),
                                  height: 60,
                                  width: 60,
                                  decoration: const BoxDecoration(
                                    color: whiteColor,
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: sdColor,
                                        blurRadius: 4,
                                        spreadRadius: 2,
                                      ),
                                    ],
                                  ),
                                  child: Center(
                                    child: catIcons[index],
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  catNames[index],
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: bColor.withOpacity(0.7),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 30),
                    Padding(padding: const EdgeInsets.only(left: 15),
                      child: Text("Recomended Doctors",style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: bColor.withOpacity(0.7),
                      ),),
                    ),
                    const Column(
                      children: [
                        DoctorsSection(),
                      ],
                    ),
                  ],
                ),
              ),
    
            ],
          ),
        ),
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