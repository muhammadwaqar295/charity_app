import 'package:charity_app/consts/consts.dart';
import 'package:charity_app/reusable_widgets/our_text.dart';
import 'package:charity_app/views/authentication/login_screen.dart';
import 'package:charity_app/views/events/event_screen/events_screen.dart';
import 'package:charity_app/views/history/history_screen.dart';
import 'package:charity_app/views/notificatons/notification_screen.dart';
import 'package:charity_app/views/profile/profile_screen.dart';
import 'package:get/get.dart';
import '../../home/home.dart';

class MenuBarPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Transparent area on right
          Positioned.fill(
            left: 250,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(color: Colors.transparent),
            ),
          ),

          // Menu on left
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              width: 250,
              height: double.infinity,
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Space for Status Bar
                  SizedBox(height: MediaQuery.of(context).padding.top),

                  // Top Orange Title with curved right corner
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 70),

                    decoration: const BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(40),
                      ),
                    ),

                    child: Center(
                      child:ourText(color: whiteColor, title: charity, textSize: 26),

                    ),
                  ),

                  // List of menu items
                  Expanded(
                    child: ListView(
                      padding: EdgeInsets.zero,
                      children: [
                        menuItem(Icons.home, home, context, const Home()),
                        menuItem(Icons.person, profile, context, const ProfileScreen()),
                        menuItem(Icons.history, history, context, const HistoryScreen()),
                        menuItem(Icons.notifications, notification, context, NotificationScreen()),
                        menuItem(Icons.info_outline, about, context, AboutPage()),
                        menuItem(Icons.logout, logout, context, const LoginScreen()),
                        menuItem(Icons.event, eventsss, context, const EventsScreen()),
                        menuItem(Icons.admin_panel_settings, admin, context, AdminPage()),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Updated Menu Item Widget with onTap to navigate
  Widget menuItem(IconData icon, String title, BuildContext context, Widget screen) {
    return ListTile(
      leading: Icon(icon, color: blackColor),
      title:ourText(color: blackColor, title: title, textSize: 16),

      onTap: () {
        Get.to(()=>screen);
      },
    );
  }
}









class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: const Text("About Page")));
  }
}





class AdminPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: const Text("Admin Page")));
  }
}
