import 'package:charity_app/consts/consts.dart';
import 'package:charity_app/consts/images.dart';
import 'package:charity_app/views/history/history_screen.dart';
import 'package:charity_app/views/notificatons/notification_screen.dart';
import 'package:charity_app/views/profile/profile_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import '../../controllers/home_contoller.dart';
import '../home_screens/home_screen.dart';
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final controller = Get.put(HomeController());

  int unreadCount = 0;

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection('notifications')
        .where('isRead', isEqualTo: false)
        .snapshots()
        .listen((snapshot) {
      setState(() {
        unreadCount = snapshot.docs.length;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var navBody = [
      const HomeScreen(),
      const HistoryScreen(),
      NotificationScreen(),
      const ProfileScreen(),
    ];

    var navItems = [
      Image.asset(icHome, width: 26, color: whiteColor),
      Image.asset(icHistory, width: 26, color: whiteColor),

      // 👇 Notification icon with badge
      Stack(
        clipBehavior: Clip.none,
        children: [
          Image.asset(icNotification, width: 26, color: whiteColor),
          if (unreadCount > 0)
            Positioned(
              right: -4,
              top: -4,
              child: Container(
                padding: const EdgeInsets.all(3),
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  '$unreadCount',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
        ],
      ),

      Image.asset(icProfile, width: 26, color: whiteColor),
    ];

    return Scaffold(
      backgroundColor: Colors.grey[100],
      bottomNavigationBar: SafeArea(
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
