import 'package:charity_app/consts/consts.dart';
import 'package:charity_app/consts/images.dart';
import 'package:charity_app/views/history/history_screen.dart';
import 'package:charity_app/views/notificatons/notification_screen.dart';
import 'package:charity_app/views/profile/profile_screen.dart';
import 'package:get/get.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import '../../controllers/home_contoller.dart';
import '../home_screens/home_screen.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(HomeController());

    var navBody = [
      const HomeScreen(),
      const HistoryScreen(),
      NotificationScreen(),
      const ProfileScreen(),
    ];

    var navItems = [
      Image.asset(icHome, width: 26, color: whiteColor),
      Image.asset(icHistory, width: 26, color: whiteColor),
      Image.asset(icNotification, width: 26, color: whiteColor),
      Image.asset(icProfile, width: 26, color: whiteColor),
    ];

    return Scaffold(
      backgroundColor: Colors.grey[100],
      bottomNavigationBar: SafeArea( // 👈 Add this
        child: Obx(() => CurvedNavigationBar(
          backgroundColor: Colors.transparent,
          color: yellowColor,
          buttonBackgroundColor: yellowColor,
          height: 60,
          index: controller.currentNavIndex.value,
          animationCurve: Curves.easeInOut,
          animationDuration: const Duration(milliseconds: 300),
          items: navItems,
          onTap: (index) {
            controller.currentNavIndex.value = index;
          },
        )),
      ),
      body: Obx(() => navBody[controller.currentNavIndex.value]),
    );

  }
}
