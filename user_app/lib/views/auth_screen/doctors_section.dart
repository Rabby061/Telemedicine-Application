import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:user_app/consts/consts.dart';
import 'package:get/get.dart';
import 'package:user_app/controllers/firestoreService.dart';
import 'package:user_app/views/auth_screen/doctor_profile.dart';

class DoctorsSection extends StatelessWidget {
  const DoctorsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirestoreServices.getDoctor(category: ""),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if(!snapshot.hasData)
          {
            return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(redColor),
              ),
            );
          }
            var ddata = snapshot.data!.docs;
            var x = ddata.length>20?20:ddata.length;
          return Container(
          height: 340,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: x,
            itemBuilder: (context, index) {
              var ddata2=ddata[index];
              
              return GestureDetector(
                onTap: (){
                                Get.to(()=> doctorProfile(ddata2: ddata2,));
                              },
                child: Column(
              
                  children: [
                    Container(
                      height: 300,
                      width: 200,
                      margin: const EdgeInsets.symmetric(vertical: 15,horizontal: 20),
                      
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
                                        child: ddata[index]['imageUrl'] == '' ?
                                        Image.asset(
                                          doctor1,
                                          height: 200,
                                          width: 200,
                                          fit: BoxFit.cover,
                                        
                                        )
                                        :
                                        Image.network(
                                          ddata[index]['imageUrl'],
                                          height: 200,
                                          width: 200,
                                          fit: BoxFit.cover,
                                          )
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
                                  "${ddata[index]['name']}",
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w500,
                                      color: bluecolor,
                                    ),
                                ),
                                Text(
                                  "${ddata[index]['speciality']}",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      color: bColor.withOpacity(0.6),
                                    ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  "Total Service: ${ddata[index]['total-call']}",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      color: bColor.withOpacity(0.8),
                                    ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      }
    );
  }
}