import 'package:get/get.dart';
import 'package:user_app/consts/consts.dart';
import 'package:user_app/controllers/profile_change_controller.dart';
import 'package:user_app/views/auth_screen/profile.dart';
import 'package:user_app/widgets_common/applogo_widget.dart';
import 'package:user_app/widgets_common/bg_widget.dart';
import 'package:user_app/widgets_common/custom_textfield.dart';

import 'package:user_app/widgets_common/our_button.dart';

class ChangePassword extends StatelessWidget {
  final dynamic data;
  const ChangePassword({super.key,this.data});
  

  

  @override
  Widget build(BuildContext context) {

    var controller = Get.put(ProfileController());
    var passwordController = TextEditingController();
    var passwordRetypeController = TextEditingController();
    return bgwidget(Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(child: Column(children: [
        (context.screenHeight*0.01).heightBox,
        applogoWidget(),
        1.heightBox,
        "Reset Your Password".text.fontFamily(bold).white.size(22).make(),
        15.heightBox,
        Column(
          children: [
            customTextField(hint: passwordHint,title: "New Password",controller: passwordController,isPass: true),
            5.heightBox,
            customTextField(hint: passwordHint,title: "Retype New Password",controller: passwordRetypeController,isPass: true),
              20.heightBox,
              ourButton(() async {
                
                await controller.changeAuthPassword( data['email'],data['password'],passwordController.text);
                
                Get.offAll(()=>user_profile());
              }, bluecolor , whiteColor , "Change").box.width(context.screenWidth - 50).make(),
          ], 
        ).box.white.rounded.padding(const EdgeInsets.all(16)).width(context.screenWidth -70).shadowSm.make(),
      ],)),
    ));
  }
}