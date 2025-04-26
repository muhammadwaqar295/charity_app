import 'package:charity_app/Events/eventsScreen.dart';
import 'package:charity_app/consts/consts.dart';
import 'package:charity_app/views/history/history_screen.dart';
import 'package:charity_app/views/home_screens/home_screen.dart';
import 'package:charity_app/views/notificatons/notification_screen.dart';
import 'package:charity_app/views/profile/profile_screen.dart';
import 'package:flutter/material.dart';

import '../../../reusable_widgets/our_text.dart';

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
              color: whiteColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Space for Status Bar
                  SizedBox(height: MediaQuery.of(context).padding.top),

                  // Top Orange Title
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 50), // you can increase/decrease this
                    color: yellowColor,
                    child: Center(
                        child: ourText(
                          color: whiteColor, // Text color
                          title: charity, // Text content
                          textSize: 26, // Text size
                        ),
                    ),
                  ),
                  Expanded(
                    child: ListView(
                      padding: EdgeInsets.zero,
                      children: [
                        menuItem(context, Icons.home, home, HomeScreen()),
                        menuItem(context, Icons.person, profile, ProfileScreen()),
                        menuItem(context, Icons.history, history, HistoryScreen()),
                        menuItem(context, Icons.notifications, notification, NotificationScreen()),
                        menuItem(context, Icons.info_outline, about, AboutPage()),
                        menuItem(context, Icons.logout, logout, LogoutPage()),
                        menuItem(context, Icons.event, events, EventsScreen()),
                        menuItem(context, Icons.admin_panel_settings, admin, AdminPage()),
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

  // Menu Item
  Widget menuItem(BuildContext context, IconData icon, String title, Widget page) {
    return ListTile(
      leading: Icon(icon, color: Colors.black87),
      title: Text(
        title,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      ),
      onTap: () {
        Navigator.pop(context); // Close the menu

        // Navigate to the respective page
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => page),
        );
      },
    );
  }
}

// Dummy Pages for Navigation


class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("About")),
      body: Center(
        child: Text("Welcome to the About Page"),
      ),
    );
  }
}

class LogoutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Logout")),
      body: Center(
        child: Text("You have been logged out"),
      ),
    );
  }
}



class AdminPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Admin")),
      body: Center(
        child: Text("Welcome to the Admin Page"),
      ),
    );
  }
}
