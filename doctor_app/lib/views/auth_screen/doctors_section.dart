import 'package:doctor_app/consts/consts.dart';
import 'package:get/get.dart';
import 'package:doctor_app/views/auth_screen/doctor_profile.dart';

class DoctorsSection extends StatelessWidget {
  const DoctorsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 340,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: 4,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: (){
                            Get.to(()=> const doctorProfile());
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
                              child: Image.asset(
                                "assets/images/doctor${index+1}.jpg",
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
        },
      ),
    );
  }
}