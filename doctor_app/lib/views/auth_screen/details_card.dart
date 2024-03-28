import 'package:doctor_app/consts/consts.dart';

Widget detailsCard({width,String? count,String? title}){
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      "$count".text.fontFamily(bold).color(bColor).size(16).make(),
      5.heightBox,
      "$title".text.color(bColor).make(),
    ],

  ).box.white.rounded.width(width).height(80).padding(const EdgeInsets.all(4)).make();
}