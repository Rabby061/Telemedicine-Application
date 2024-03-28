import 'package:admin_app/controllers/auth_controller.dart';
import 'package:admin_app/views/auth_screen/dashboard.dart';

import 'package:get/get.dart';
import 'package:admin_app/consts/consts.dart';

import 'package:admin_app/widgets_common/applogo_widget.dart';
import 'package:admin_app/widgets_common/bg_widget.dart';
import 'package:admin_app/widgets_common/custom_textfield.dart';

import 'package:admin_app/widgets_common/our_button.dart';

class loginscreen extends StatelessWidget {
  const loginscreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AuthController());
    return bgwidget(Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(child: Column(children: [
        (context.screenHeight*0.01).heightBox,
        applogoWidget(),
        1.heightBox,
        "Log in to Online Doctor".text.fontFamily(bold).white.size(22).make(),
        15.heightBox,
        Column(
          children: [
            customTextField(hint: emailHint,title: email,isPass: false,controller: controller.emailController),
            5.heightBox,
            customTextField(hint: passwordHint,title: password,isPass: true,controller: controller.passwordController),
            
              5.heightBox,
              ourButton(() async {
                  await controller.loginMethod(context).then((value) {
                  if (value!=null) {
                    VxToast.show(context, msg: "Log in successful");
                    Get.offAll(()=> dashBoard());
                  }
                });
              }, bluecolor,whiteColor , login).box.width(context.screenWidth - 50).make(),
              5.heightBox,
          ], 
        ).box.white.rounded.padding(const EdgeInsets.all(16)).width(context.screenWidth -70).shadowSm.make(),
      ],)),
    ));
  }
}