
import 'dart:io';

import 'package:doctor_app/controllers/profile_change_controller.dart';
import 'package:doctor_app/widgets_common/custom_textfield2.dart';
import 'package:doctor_app/widgets_common/navbar.dart';
import 'package:get/get.dart';
import 'package:doctor_app/consts/consts.dart';
import 'package:doctor_app/widgets_common/bg_widget.dart';
import 'package:doctor_app/widgets_common/custom_textfield.dart';
import 'package:doctor_app/widgets_common/our_button.dart';

class doctor_info extends StatefulWidget {
  const doctor_info({super.key});

  @override
  State<doctor_info> createState() => _doctorInfoState();
}

class _doctorInfoState extends State<doctor_info> {
  bool? isCheck=false;
  var controller = Get.put(ProfileController());
  var qualificationController = TextEditingController();
  var addressController = TextEditingController();
  var timeController = TextEditingController();
  var timeController2 = TextEditingController();
  var specialityController = TextEditingController();
  var serviceController = TextEditingController();
  var phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return bgwidget(Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Center(child: Column(children: [
          (context.screenHeight*0.01).heightBox,
          30.heightBox,
          "Provide Professional Information".text.fontFamily(bold).white.size(22).make(),
          15.heightBox,
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                customTextField(hint: "Enter phone number",title: "Phone No.",controller: phoneController,isPass: false),
                5.heightBox,
                customTextField(hint: "Enter your academic degrees",title: "Educational Qualification",controller: qualificationController,isPass: false),
                5.heightBox,
                customTextField(hint: "Enter your address",title: "Address",controller: addressController,isPass: false),
                5.heightBox,
                customTextField(hint: "24:60:60",title: "Working Time Start",controller: timeController,isPass: false),
                5.heightBox,
                customTextField(hint: "24:60:60",title: "Working Time End",controller: timeController2,isPass: false),
                5.heightBox,
                customTextField(hint: "Heart/Eye/Brain/Psychologist/cardiologist",title: "Speciality",controller: specialityController,isPass: false),
                
                5.heightBox,
                customTextField2(hint: "Enter your services",title: "Service",controller: serviceController),
                
                5.heightBox,
                Obx(
                  () => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                            "Upload your latest academic certificate",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                            fontSize: 16,
                            fontFamily: semibold,
                            color: bluecolor,
                            ),
                          ),
                          5.heightBox,
                      Container(
                      height: 200,
                      width: 400,
                      
                      decoration: BoxDecoration(
                        color: const Color(0xFFF2F8FF),
                        
                      
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            children: [
                                ClipRRect(
                                  
                                  
                                  child: controller.certificateImgPath.isEmpty?
                
                                  Image.asset(
                                    "assets/images/document.jpg",
                                    height: 200,
                                    width: 400,
                                    fit: BoxFit.cover,
                                  )
                                  :
                                  Image.file(
                                    File(controller.certificateImgPath.value),
                                    height: 200,
                                    width: 400,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              
                            ],
                          
                          ),
                        ],
                        ), 
                      ), 
                    ],
                      
                  ),
                ),

                10.heightBox,
                ourButton(() async {
                    await controller.changeCertificate(context);
                    await controller.uploadCertificateImage();
                },bluecolor, whiteColor , "Upload").box.width(context.screenWidth - 250).make(),
                10.heightBox,
                  
                ourButton(() async {
                    await controller.updateInfo(
                      certificateImg: controller.certificateImgLink,
                      qualification: qualificationController.text,
                      address: addressController.text,
                      stime: timeController.text,
                      etime: timeController2.text,
                      speciality: specialityController.text,
                      services: serviceController.text,
                      phone: phoneController.text,
                    );
                    Get.offAll(()=>const Navbar());
                },bluecolor, whiteColor , "Register").box.width(context.screenWidth - 50).make(),
                  
              ], 
            ).box.white.rounded.padding(const EdgeInsets.all(16)).width(context.screenWidth -30).shadowSm.make(),
          ),
        ],)),
      ),
    ));
  }
}