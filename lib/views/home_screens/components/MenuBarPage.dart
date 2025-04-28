import 'package:flutter/material.dart';

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
                  // Space for Status Bar (wifi, battery, etc.)
                  SizedBox(height: MediaQuery.of(context).padding.top),

                  // Top Orange Title with CURVED right corner
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 70),
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(40),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        "Charity",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ),
                  ),

                  // List of menu items
                  Expanded(
                    child: ListView(
                      padding: EdgeInsets.zero,
                      children: [
                        menuItem(Icons.home, "Home"),
                        menuItem(Icons.person, "Profile"),
                        menuItem(Icons.history, "History"),
                        menuItem(Icons.notifications, "Notification"),
                        menuItem(Icons.info_outline, "About"),
                        menuItem(Icons.logout, "Logout"),
                        menuItem(Icons.event, "Events"),
                        menuItem(Icons.admin_panel_settings, "Admin"),
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

  // Menu Item Widget without onTap
  Widget menuItem(IconData icon, String title) {
    return ListTile(
      leading: Icon(icon, color: Colors.black87),
      title: Text(
        title,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      ),
      // No onTap here
    );
  }
}
