import 'package:doctor_app/controllers/profile_change_controller.dart';
import 'package:doctor_app/widgets_common/applogo_widget.dart';
import 'package:doctor_app/widgets_common/custom_textfield2.dart';
import 'package:doctor_app/widgets_common/navbar.dart';
import 'package:get/get.dart';
import 'package:doctor_app/consts/consts.dart';
import 'package:doctor_app/widgets_common/bg_widget.dart';
import 'package:doctor_app/widgets_common/custom_textfield.dart';
import 'package:doctor_app/widgets_common/our_button.dart';

class update_info extends StatelessWidget {
  final dynamic data;
  const update_info({super.key,this.data});

  
  
  
  
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProfileController());
  
    
    return bgwidget(Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Center(child: Column(children: [
          (context.screenHeight*0.01).heightBox,
          applogoWidget(),
          1.heightBox,
          "Update Professional Information".text.fontFamily(bold).white.size(22).make(),
          15.heightBox,
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                customTextField(hint: "Enter phone number",title: "Phone No.",controller: controller.phoneController,isPass: false),
                5.heightBox,
                
                customTextField(hint: "Enter your address",title: "Address",controller: controller.addressController,isPass: false),
                5.heightBox,
                customTextField(hint: "24:60:60",title: "Working Time Start",controller: controller.timeController,isPass: false),
                5.heightBox,
                customTextField(hint: "24:60:60",title: "Working Time End",controller: controller.timeController2,isPass: false),
                5.heightBox,
                customTextField(hint: "Heart/Eye/Brain/Psychologist/cardiologist",title: "Speciality",controller: controller.specialityController,isPass: false),
                
                5.heightBox,
                customTextField2(hint: "Enter your services",title: "Service",controller: controller.serviceController),
                
                10.heightBox,
                
                  
                ourButton(() async {
                  await controller.updateInfo2(
                      
                    );
                  Get.to(()=> const Navbar());
                  },bluecolor, whiteColor , "Update").box.width(context.screenWidth - 50).make(),
                  
              ], 
            ).box.white.rounded.padding(const EdgeInsets.all(16)).width(context.screenWidth -30).shadowSm.make(),
          ),
        ],)),
      ),
    ));
  }
}