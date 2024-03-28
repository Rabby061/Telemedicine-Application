import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

import 'package:admin_app/consts/consts.dart';



class doctorProfile extends StatefulWidget {
  final dynamic ddata2;

  const doctorProfile({Key? key, required this.ddata2}) : super(key: key);

  @override
  _DoctorProfileState createState() => _DoctorProfileState();
}

class _DoctorProfileState extends State<doctorProfile> {

   Map<String,dynamic>? paymentIntent;

  

  @override
  Widget build(BuildContext context) {
    
    
    return Scaffold(
      backgroundColor: const Color(0xFFD9E4EE),
      appBar: AppBar(
        backgroundColor: bluecolor,
        elevation: 0.0,
        title: Text(
              "${widget.ddata2['name']}",
              style: TextStyle(
                color: whiteColor,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            automaticallyImplyLeading: true,
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
                    ClipRRect(
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(15),
                                          topRight: Radius.circular(15),
                                          bottomLeft: Radius.circular(15),
                                          bottomRight: Radius.circular(15),
                                        ),
                                        child: widget.ddata2['imageUrl'] == '' ?
                                        Image.asset(
                                          doctor1,
                                          height: 100,
                                          width: 80,
                                          fit: BoxFit.cover,
                                        
                                        )
                                        :
                                        Image.network(
                                          widget.ddata2['imageUrl'],
                                          height: 100,
                                          width: 80,
                                          fit: BoxFit.cover,
                                          )
                                      ),
                    10.widthBox,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                                "${widget.ddata2['name']}",
                                style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w500,
                                    color: bluecolor,
                                  ),
                          ),
                          Text(
                                "${widget.ddata2['speciality']}",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: bColor.withOpacity(0.6),
                                  ),
                          ),
                          const Spacer(),
                          Text(
                                "Total service : ${widget.ddata2['total-call']}",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: bColor.withOpacity(0.6),
                                  ),
                          ),
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
                                "Phone",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: bColor,
                                  ),
                          ),
                      trailing: GestureDetector(
                        onTap: () {
                            //payment();
                            
                           
                            FlutterPhoneDirectCaller.callNumber(widget.ddata2['phone']).then((value) => {
                                
                            });
                            
                        },
                        child: Container(
                          width: 50,
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.amber,
                          ),
                          child: const Icon(Icons.phone,color: whiteColor,)),
                      ),
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
                                "${widget.ddata2['qualification']}",
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
                                "${widget.ddata2['address']}",
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
                                 "${widget.ddata2['start-time']} To ${widget.ddata2['end-time']}",
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
                                "${widget.ddata2['services']}",
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