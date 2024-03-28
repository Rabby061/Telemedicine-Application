
import 'package:doctor_app/consts/consts.dart';
import 'package:flutter/material.dart';

class filecard extends StatelessWidget {
  const filecard({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading:const Text(
                    "File1.pdf",
                    style: TextStyle(
                    color: bColor,
                    fontSize: 18,
                    fontFamily: bold,
                    fontWeight: FontWeight.w500,
                    ),
                  ),
      trailing: IconButton(
        onPressed: (){
          
        }, 
        icon: const Icon(
          Icons.download,
          color: bColor,
        )
      ),
      tileColor: whiteColor,
    );
  }
}