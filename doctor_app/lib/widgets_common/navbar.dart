import 'package:doctor_app/consts/consts.dart';
import 'package:doctor_app/views/auth_screen/document_screen.dart';
import 'package:doctor_app/views/auth_screen/profile.dart';

class Navbar extends StatefulWidget {
  const Navbar({super.key});

  @override
  State<Navbar> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Navbar> {
  int selectedIndex=0;
  List screenList= [
    user_profile(),
    documentScreen(),
    
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screenList.elementAt(selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.white.withOpacity(0.5),
        selectedItemColor: whiteColor,
        selectedLabelStyle: const TextStyle(
          color: whiteColor,
        ),
        selectedIconTheme: const IconThemeData(
          color: whiteColor,
        ),
        backgroundColor: Colors.blue,
        type: BottomNavigationBarType.fixed,
        currentIndex: selectedIndex,
        onTap: (value) {
          setState(() {
            selectedIndex=value;
          });
        },
        items: const [
        BottomNavigationBarItem(icon: Icon(Icons.person),label: "Profile"),  
        
        BottomNavigationBarItem(icon: Icon(Icons.file_copy_rounded),label: "Documents"), 

      ],),
    );
  }
}