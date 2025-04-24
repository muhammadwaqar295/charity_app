import 'package:charity_app/consts/consts.dart';
import 'package:charity_app/consts/images.dart';
import 'package:charity_app/reusable_widgets/profile_circle_avatar.dart';
import 'package:charity_app/views/profile/edit_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:charity_app/consts/colors.dart';
import 'package:charity_app/reusable_widgets/our_text.dart';
import 'package:charity_app/reusable_widgets/our_button.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

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


                const SizedBox(height: 10),

                // PROFILE text
                ourText(
                  color: blackColor,
                  title: profile,
                  textSize: 22,
                ),

                const SizedBox(height: 20),

                // Profile Image Placeholder
           ourCircleAvatar(radius: 50, image: imgProfile),
               /* const CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.grey,
                  child: Icon(Icons.person, size: 60, color: Colors.white),
                ),*/

                const SizedBox(height: 30),

                // Display Name
                profileInfoLabel(yourName),
                profileInfoBox(noorJan),

                const SizedBox(height: 15),

                // Display Email
                profileInfoLabel(yourEmailAddress),
                profileInfoBox(noorGmail),

                const SizedBox(height: 15),

                // Display Phone
                profileInfoLabel(yourPhone),
                profileInfoBox(phoneNo),

                const SizedBox(height: 30),

                // Edit Profile Button
            ourButton(
              onPress: () {

               Get.to(()=> const EditProfileScreen());
              },
              color: yellowColor,
              textColor: whiteColor,
              title: editProfile,
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


  Widget profileInfoBox(String value) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      margin: const EdgeInsets.only(top: 5),
      decoration: BoxDecoration(
        color: greyColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: ourText(
        color: blackColor,
        title: value,
        textSize: 16,
      ),
    );
  }
}
