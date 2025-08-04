
import 'package:charity_app/admin/events_for_admin/all_events_for_admin.dart';
import 'package:charity_app/admin/persons_for_admin/all_persons_for_admin.dart';
import 'package:charity_app/consts/consts.dart';
import 'package:charity_app/controllers/admin_home_controller.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:get/get.dart';


import 'items_recive.dart';
class AdminHome extends StatelessWidget {
  const AdminHome({super.key});

  @override
  Widget build(BuildContext context) {

    var controller = Get.put(AdminHomeController());

    var navBody = [
      const AllPersonsForAdmin(),
      const AllEventsForAdmin(),
      const ItemsRecive()

    ];

    var navItems = [
      const Icon(Icons.person,color: Colors.white,),
      const Icon(Icons.event,color: Colors.white,),
      const Icon(Icons.local_shipping,color: Colors.white,),

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
