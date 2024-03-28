import 'package:doctor_app/controllers/auth_controller.dart';
import 'package:doctor_app/views/auth_screen/info.dart';

import 'package:get/get.dart';
import 'package:doctor_app/consts/consts.dart';
import 'package:doctor_app/widgets_common/applogo_widget.dart';
import 'package:doctor_app/widgets_common/bg_widget.dart';
import 'package:doctor_app/widgets_common/custom_textfield.dart';
import 'package:doctor_app/widgets_common/our_button.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool? isCheck=false;
  var controller = Get.put(AuthController());

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var passwordRetypeController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return bgwidget(Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(child: Column(children: [
        (context.screenHeight*0.01).heightBox,
        applogoWidget(),
        1.heightBox,
        "Sign up to Online Doctor".text.fontFamily(bold).white.size(22).make(),
        15.heightBox,
        SingleChildScrollView(
          child: Column(
            children: [
              customTextField(hint: nameHint,title: name,controller: nameController,isPass: false),
            5.heightBox,
            customTextField(hint: emailHint,title: email,controller: emailController,isPass: false),
            5.heightBox,
            customTextField(hint: passwordHint,title: password,controller: passwordController,isPass: true),
            5.heightBox,
            customTextField(hint: passwordHint,title: retypePassword,controller: passwordRetypeController,isPass: true),
              
                5.heightBox,
                
                Row(
                  children: [
                    Checkbox(
                      checkColor: whiteColor,
                      value: isCheck, onChanged: (newValue){
                        setState(() {
                          isCheck=newValue;
                        });
                        
                    },
                    ),
                    10.widthBox,
                    Expanded(
                      child: RichText(text: const TextSpan(
                        children: [
                          TextSpan(text: "I agree to the ",style: TextStyle(
                            fontFamily: regular,
                            color: fontGrey,
                          )),
                          TextSpan(text: termAndCond,style: TextStyle(
                            fontFamily: regular,
                            color: bluecolor,
                          )),
                          TextSpan(text: " & ",style: TextStyle(
                            fontFamily: regular,
                            color: fontGrey,
                          )),
                          TextSpan(text: privacyPolicy,style: TextStyle(
                            fontFamily: regular,
                            color: bluecolor,
                          ))
                        ],
                      )),
                    ),
                  ],
                ),
                ourButton(() async {
                    if(isCheck!=false)
                    {
                      if(passwordController.text.toString().length < 6)
                      {
                        VxToast.show(context, msg: "Password must be atleast 6 character");
                      }
                      else if(passwordController.text.toString() != passwordRetypeController.text.toString())
                      {
                        VxToast.show(context, msg: "Password doesn't matches");
                      }
                      else{
                                        try {
                                      await controller.signupMethod(emailController.text,passwordController.text,context).then((value) {
                                      return controller.storeUserData(
                                        email: emailController.text,
                                        password: passwordController.text,
                                        name: nameController.text,
                                        );
                                        }).then((value) {
                                        VxToast.show(context, msg: "Sign up successful");
                                        Get.offAll(()=>doctor_info());
                                      });
                                      } catch (e) {
                                      auth.signOut();
                                      VxToast.show(context, msg: e.toString());
                                      }
                      }
                      
                  }
                }, isCheck==true? bluecolor:lightBlue,isCheck==true? whiteColor:bluecolor , signup).box.width(context.screenWidth - 50).make(),
                10.heightBox,
                RichText(text: const TextSpan(
                  children: [
                    TextSpan(
                      text: already,
                      style: TextStyle(fontFamily: bold,color: fontGrey),
                    ),
                    TextSpan(
                      text: login,
                      style: TextStyle(fontFamily: bold,color: bluecolor),
                    )
                  ],
                ),
              ).onTap(() {
                Get.back();
               }),
            ], 
          ).box.white.rounded.padding(const EdgeInsets.all(16)).width(context.screenWidth -70).shadowSm.make(),
        ),
      ],)),
    ));
  }
}