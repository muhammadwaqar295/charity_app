import 'package:charity_app/consts/consts.dart';
import 'package:charity_app/consts/images.dart';
import 'package:charity_app/views/history/history_screen.dart';
import 'package:charity_app/views/notificatons/notification_screen.dart';
import 'package:charity_app/views/profile/profile_screen.dart';
import 'package:get/get.dart';

import '../../controllers/home_contoller.dart';
import '../home_screens/home_screen.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {

    var controller =Get.put(HomeController());

    var navBarItem=[
      BottomNavigationBarItem(icon: Image.asset(icHome,width: 26,),label: home),
      BottomNavigationBarItem(icon: Image.asset(icHistory,width: 26,),label: history),
      BottomNavigationBarItem(icon: Image.asset(icNotification,width: 26,),label: notification),
      BottomNavigationBarItem(icon: Image.asset(icProfile,width: 26,),label: profile),
    ];


    var navBody=[

      const HomeScreen(),
      const HistoryScreen(),
      const NotificationScreen(),
      const ProfileScreen(),


    ];
    return Scaffold(
      body: Column(
        children: [
          Obx(()=> Expanded(child: navBody.elementAt(controller.currentNavIndex.value)))
        ],
      ),
      bottomNavigationBar: Obx(()=>
          BottomNavigationBar(
            currentIndex: controller.currentNavIndex.value,
            backgroundColor: yellowColor,
            selectedItemColor: whiteColor,
            selectedLabelStyle: const TextStyle(fontFamily: semibold),
            type: BottomNavigationBarType.fixed
            ,items: navBarItem,
            onTap: (value){
              controller.currentNavIndex.value=value;
            },
          ),
      ),
    );
  }
}
