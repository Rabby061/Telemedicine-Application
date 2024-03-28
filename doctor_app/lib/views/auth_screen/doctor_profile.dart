import 'package:flutter/material.dart';
import 'package:doctor_app/consts/consts.dart';

class doctorProfile extends StatelessWidget {
  const doctorProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD9E4EE),
      appBar: AppBar(
        backgroundColor: bluecolor,
        elevation: 0.0,
        title: const Text(
              "Doctor Name",
              style: TextStyle(
                color: whiteColor,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  
                  children: [
                    CircleAvatar(
                      radius: 40,
                      child: Image.asset(doctor1),
                    ),
                    10.widthBox,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
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
                          const Spacer(),
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
                    )
                  ],
                ),
              ),
              10.heightBox,
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: whiteColor,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      title: const Text(
                                "Phone Number",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: bColor,
                                  ),
                          ),
                      trailing: Container(
                        width: 50,
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.amber,
                        ),
                        child: const Icon(Icons.phone,color: whiteColor,)),
                    ),
                    10.heightBox,
                    const Text(
                                "Educational Qualication",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: bold,
                                    color: bColor,
                                  ),
                          ),
                    5.heightBox,
                    Text(
                                "this is the educational qualification.",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: bColor.withOpacity(0.8),
                                  ),
                          ),
                    
                    10.heightBox,
                    const Text(
                                "Address",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: bold,
                                    color: bColor,
                                  ),
                          ),
                    5.heightBox,
                    Text(
                                "this is the address",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: bColor.withOpacity(0.8),
                                  ),
                          ),
        
                    10.heightBox,
                    const Text(
                                "Working Time",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: bold,
                                    color: bColor,
                                  ),
                          ),
                    5.heightBox,
                    Text(
                                "this is the Working time",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: bColor.withOpacity(0.8),
                                  ),
                          ),
                    10.heightBox,
                    const Text(
                                "Service",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: bold,
                                    color: bColor,
                                  ),
                          ),
                    5.heightBox,
                    Text(
                                "Our services",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: bColor.withOpacity(0.8),
                                  ),
                          ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}