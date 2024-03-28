import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:doctor_app/consts/consts.dart';
import 'package:doctor_app/views/auth_screen/doctor_profile.dart';

class allDoctor extends StatefulWidget {
  allDoctor({super.key});

  @override
  State<allDoctor> createState() => _MyWidgetState();
}
class _MyWidgetState extends State<allDoctor> {
  Icon cusIcon= Icon(Icons.search);
  Widget cusSearchBar= Text(
              "All Doctors",
              style: TextStyle(
                color: whiteColor,
                fontSize: 22,
                fontWeight: FontWeight.w500,
                fontFamily: bold,
              ),
            );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD9E4EE),
      appBar: AppBar(
        backgroundColor: bluecolor,
        elevation: 0.0,
        title: cusSearchBar,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: (){
              setState(() {
                  if(this.cusIcon.icon == Icons.search)
                  {
                    this.cusIcon=Icon(Icons.cancel);
                    this.cusSearchBar= TextField(
                      decoration: InputDecoration(
                        fillColor: darkBlue,
                        filled: true,
                        hintText: "search",
                        hintStyle: TextStyle(
                        color: whiteColor,
                        fontSize: 16,
                        ),
                        border:OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(60)),
                          borderSide: BorderSide(color: bluecolor),
                        ),
                        contentPadding: EdgeInsets.all(10),
                      ),
                      textInputAction: TextInputAction.go,
                      style: TextStyle(
                        color: whiteColor,
                        fontSize: 16,
                      ),
                  
                    );

                  }
                  else{
                    this.cusIcon=Icon(Icons.search);
                    this.cusSearchBar=Text(
              "All Doctors",
              style: TextStyle(
                color: whiteColor,
                fontSize: 22,
                fontWeight: FontWeight.w500,
                fontFamily: bold,
              ),
            );
                  }
              });
            }, 
            icon: cusIcon,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: GridView.builder(
        physics: const BouncingScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 18,
          crossAxisSpacing: 8,
          mainAxisExtent: 300,
        ),
        itemCount: 10,
        itemBuilder: (context,index){
          return GestureDetector(
            onTap: (){
                            Get.to(()=> const doctorProfile());
                          },
            child: Column(
          
              children: [
                Container(
                  height: 300,
                  width: 200,
                  
                  decoration: BoxDecoration(
                    color: const Color(0xFFF2F8FF),
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: const [
                      BoxShadow(
                        color: sdColor,
                        blurRadius: 4,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(15),
                                topRight: Radius.circular(15),
                              ),
                              child: Image.asset(
                                "assets/images/doctor${(index+1)%4==0?4:(index+1)%4}.jpg",
                                height: 200,
                                width: 200,
                                fit: BoxFit.cover,
                              ),
                            ),
                          
                        ],
                      ),
                      const SizedBox(height: 8),
                      Padding(
                        padding:EdgeInsets.symmetric(horizontal: 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Dr Looney",
                              style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w500,
                                  color: bluecolor,
                                ),
                            ),
                            Text(
                              "Surgeon",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: bColor.withOpacity(0.6),
                                ),
                            ),
                            const SizedBox(height: 8),
                            VxRating(
                              selectionColor: Colors.amber,
                              onRatingUpdate: (Value) {},
                              maxRating: 5,
                              count: 5,
                              value: 4,
                              stepInt: true,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        } 
      ),

      )
      
    );
  }
}