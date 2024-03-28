

import 'package:admin_app/consts/colors.dart';
import 'package:admin_app/views/auth_screen/all_doctors.dart';
import 'package:admin_app/views/auth_screen/all_user.dart';
import 'package:admin_app/views/auth_screen/doctors_request.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../consts/consts.dart';

class dashBoard extends StatelessWidget {
  dashBoard({super.key});


  final selectedIndex=0;
  final List Names=[
    "Users",
    "Doctors",
    "Doctors Request",
  ];

  final List<Icon> Icons=[
    Icon(MdiIcons.heartPlus,color: bluecolor,size: 30),
    Icon(MdiIcons.heartPlus,color: bluecolor,size: 30),
    Icon(MdiIcons.eye,color: bluecolor,size: 30),
  ];

  @override
  Widget build(BuildContext context) {
    Color colorFromHex(String hexColor) {
  final hexCode = hexColor.replaceAll('#', '');
  return Color(int.parse('0xFF$hexCode'));
  }


Color myColor = colorFromHex('#1e9ef4');
    return Scaffold(
      body: Material(
        color: myColor,
        child: Padding(
                    padding: const EdgeInsets.only(left:5.0,right: 5.0,top: 50.0),
                    child: GridView.builder(
                    physics: const BouncingScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      mainAxisSpacing: 34,
                      crossAxisSpacing: 8,
                      mainAxisExtent: 200,
                    ),
                    itemCount: 3,
                    itemBuilder: (context,index){
                          return GestureDetector(
                        onTap: (){
                                      if(index==0)
                                      {
                                        Get.to(()=> allUser());
                                      } 
                                      else if(index==1)
                                      {
                                        Get.to(()=> allDoctor());
                                      } 
                                      else if(index==2)
                                      {
                                        Get.to(()=> doctorRequest());
                                      }
                            },
                        child: Column(
                      
                          children: [
                            Container(
                              height: 200,
                              width: 320,
                              
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
                                 mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Stack(
                                    children: [
                                        ClipRRect(
                                          
                                          child: 
                                          Image.asset(
                                            "assets/icons/dash${index+1}.png",
                                            height: 100,
                                            width: 100,
                                            fit: BoxFit.cover,
                                          
                                          )
                                         
                                        ),
                                      
                                    ],
                                  ),
                                  const SizedBox(height: 20),
                                  Padding(
                                    padding:EdgeInsets.symmetric(horizontal: 5),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${Names[index]}",
                                          style: TextStyle(
                                              fontSize: 26,
                                              fontWeight: FontWeight.w500,
                                              color: bluecolor,
                                              fontFamily: bold,
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
      ),
    );
  }
}