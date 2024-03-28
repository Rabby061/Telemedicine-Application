import 'package:get/get.dart';
import 'package:user_app/consts/consts.dart';
import 'package:user_app/views/auth_screen/otp.dart';
import 'package:user_app/widgets_common/applogo_widget.dart';
import 'package:user_app/widgets_common/bg_widget.dart';
import 'package:user_app/widgets_common/custom_textfield.dart';
import 'package:user_app/widgets_common/our_button.dart';

class SendCode extends StatelessWidget {
  const SendCode({super.key});

  @override
  Widget build(BuildContext context) {
    return bgwidget(Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(child: Column(children: [
        (context.screenHeight*0.01).heightBox,
        applogoWidget(),
        1.heightBox,
        "Forget Password!".text.fontFamily(bold).white.size(22).make(),
        15.heightBox,
        Column(
          children: [
            customTextField(hint: emailHint,title: email),
              20.heightBox,
              ourButton((){Get.to(()=> const MyVerify());}, bluecolor , whiteColor , "Send Code").box.width(context.screenWidth - 50).make(),
          ], 
        ).box.white.rounded.padding(const EdgeInsets.all(16)).width(context.screenWidth -70).shadowSm.make(),
      ],)),
    ));
  }
}