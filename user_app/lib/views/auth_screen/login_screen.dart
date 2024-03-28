import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:user_app/consts/consts.dart';
import 'package:user_app/controllers/auth_controller.dart';
import 'package:user_app/views/auth_screen/home_screen.dart';
import 'package:user_app/views/auth_screen/signup_screen.dart';
import 'package:user_app/widgets_common/applogo_widget.dart';
import 'package:user_app/widgets_common/bg_widget.dart';
import 'package:user_app/widgets_common/custom_textfield.dart';

import 'package:user_app/widgets_common/our_button.dart';

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
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(onPressed: () async {
                if(controller.emailController.text == "")
                {
                  VxToast.show(context, msg: "Enter your email");
                }
                else{
                  try  {
                    await FirebaseAuth.instance.sendPasswordResetEmail(email: controller.emailController.text);
                    VxToast.show(context, msg: "Email send");
                  } on FirebaseAuthException catch (e) {
                    VxToast.show(context, msg: "${e}");
                  }
                }
              }, child: forgetpass.text.make())),
              5.heightBox,
              ourButton(() async {
                
                await controller.loginMethod(context).then((value) {
                  if (value!=null) {
                    VxToast.show(context, msg: "Log in successful");
                    Get.offAll(()=> home_screen());
                  }
                });
              }, bluecolor,whiteColor , login).box.width(context.screenWidth - 50).make(),
              5.heightBox,
              createnewaccount.text.color(fontGrey).make(),
              5.heightBox,
              ourButton((){Get.to(()=> const SignupScreen());}, lightBlue , bluecolor , signup).box.width(context.screenWidth - 50).make(),
          ], 
        ).box.white.rounded.padding(const EdgeInsets.all(16)).width(context.screenWidth -70).shadowSm.make(),
      ],)),
    ));
  }
}