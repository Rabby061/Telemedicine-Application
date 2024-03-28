import 'package:admin_app/consts/consts.dart';

Widget customTextField2({String? title,String? hint, controller}){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      title!.text.color(bluecolor).fontFamily(semibold).size(16).make(),
      5.heightBox,
      TextFormField(
        controller: controller,
        decoration: InputDecoration(
          hintStyle: TextStyle(fontFamily: semibold,color: textfieldGrey,),
          hintText: hint,
          isDense: true,
          fillColor: lightGrey,
          filled: true,
          border: InputBorder.none,
          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: bluecolor)),
        ),
        maxLines: 7,
      ),
      5.heightBox,
    ],
  );
}