import 'package:charity_app/views/profile/edit_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:charity_app/consts/colors.dart';
import 'package:charity_app/reusable_widgets/our_text.dart';
import 'package:charity_app/reusable_widgets/our_button.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Back Arrow
                Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),

                const SizedBox(height: 10),

                // PROFILE text
                ourText(
                  color: blackColor,
                  title: "PROFILE",
                  textSize: 22,
                ),

                const SizedBox(height: 20),

                // Profile Image Placeholder
                const CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.grey,
                  child: Icon(Icons.person, size: 60, color: Colors.white),
                ),

                const SizedBox(height: 30),

                // Display Name
                profileInfoLabel("Your Name"),
                profileInfoBox("Noor Jan"),

                const SizedBox(height: 15),

                // Display Email
                profileInfoLabel("Your Email Address"),
                profileInfoBox("NoorJan001@gmail.com"),

                const SizedBox(height: 15),

                // Display Phone
                profileInfoLabel("Your Phone"),
                profileInfoBox("03078447034"),

                const SizedBox(height: 30),

                // Edit Profile Button
            ourButton(
              onPress: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const EditProfileScreen(), // ⬅️ Target screen
                  ),
                );
              },
              color: yellowColor,
              textColor: whiteColor,
              title: "EDIT PROFILE",
            ),

              ],
            ),
          ),
        ),
      ),


    );
  }

  // Label (e.g. "Your Name")
  Widget profileInfoLabel(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: ourText(
        color: blackColor,
        title: title,
        textSize: 14,
      ),
    );
  }

  // Value box (e.g. "Trần Lâm Khang")
  Widget profileInfoBox(String value) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      margin: const EdgeInsets.only(top: 5),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
      ),
      child: ourText(
        color: Colors.black87,
        title: value,
        textSize: 16,
      ),
    );
  }
}
