import 'package:charity_app/reusable_widgets/our_text.dart';
import 'package:flutter/material.dart';
import 'package:charity_app/consts/colors.dart';
import 'package:charity_app/consts/consts.dart';
import 'package:charity_app/consts/images.dart';

class MenuBarPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Right side tap area (transparent)
          Positioned.fill(
            left: 280, // Start after menu width
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context); // 👈 close the menu
              },
              child: Container(
                color: Colors.transparent, // Fully transparent overlay
              ),
            ),
          ),

          // Menu on the left
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              width: 280,
              height: double.infinity,
              color: whiteColor,
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  Column(
                    children: [
                      SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.only(left: 32.58),
                        child: Image.asset(
                          splashImg,
                          width: 214.82,
                          height: 158.82,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(height: 4),
                       ourText(color: yellowColor,title: charity, textSize: 22),

                      SizedBox(height: 12),
                    ],
                  ),
                  menuItem(icHome, home),
                  menuItem(icProfile, profile),
                  menuItem(icHistory, history),
                  menuItem(icNotification, notification),
                  menuItem(icAbout, about),
                  menuItem(icLogout, logout),
                  menuItem(icEvent, events),
                  menuItem(icAdmin, admin),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget menuItem(String imagePath, String title) {
    return ListTile(
      contentPadding: const EdgeInsets.only(left: 25),
      leading: Image.asset(
        imagePath,
        width: 30,
        height: 30,
        errorBuilder: (context, error, stackTrace) {
          return Icon(Icons.error, color: redColor);
        },
      ),
      title: Text(title),
      onTap: () {
        print('$title tapped');
      },
    );
  }
}
