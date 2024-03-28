
import 'package:admin_app/consts/consts.dart';
import 'package:flutter/material.dart';

class customcard extends StatelessWidget {
  const customcard({super.key});

  @override
  Widget build(BuildContext context) {
    return  const ListTile(
      leading: CircleAvatar(
        radius: 30,
        backgroundImage: AssetImage(doctor1),
      ),
      title: Text(
                    "Dr. Looney",
                    style: TextStyle(
                    color: bColor,
                    fontSize: 18,
                    fontFamily: bold,
                    fontWeight: FontWeight.w500,
                    ),
                  ),
      subtitle: Text(
                        "Upload and download file",
                        style: TextStyle(
                        color: bColor,
                        fontSize: 14,
                                  
                        fontWeight: FontWeight.w500,
                      ),
                    ),
      tileColor: whiteColor,
    );
  }
}