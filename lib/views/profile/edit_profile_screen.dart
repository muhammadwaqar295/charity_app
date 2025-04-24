import 'package:flutter/material.dart';
import 'package:charity_app/consts/colors.dart';
import 'package:charity_app/reusable_widgets/our_text.dart';
import 'package:charity_app/reusable_widgets/our_button.dart';
import 'package:charity_app/reusable_widgets/our_textField.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: SafeArea(
        child: SingleChildScrollView(
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

              // Profile Text
              ourText(
                color: blackColor,
                title: "PROFILE",
                textSize: 22,
              ),

              const SizedBox(height: 20),

              // Profile Image
              const CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage("assets/images/profile.png"), // replace with your image or network
              ),

              const SizedBox(height: 30),

              // Your Name
              Align(
                alignment: Alignment.centerLeft,
                child: ourText(
                  color: blackColor,
                  title: "Your Name",
                  textSize: 14,
                ),
              ),
              const SizedBox(height: 5),
              ourTextField(
                title: "",
                hint: "Trần Lâm Khang",
                isPass: false,
              ),

              const SizedBox(height: 15),

              // Your Email Address
              Align(
                alignment: Alignment.centerLeft,
                child: ourText(
                  color: blackColor,
                  title: "Your Email Address",
                  textSize: 14,
                ),
              ),
              const SizedBox(height: 5),
              ourTextField(
                title: "",
                hint: "tranlamkhang99@gmail.com",
                isPass: false,
              ),

              const SizedBox(height: 15),

              // Your Phone
              Align(
                alignment: Alignment.centerLeft,
                child: ourText(
                  color: blackColor,
                  title: "Your Phone",
                  textSize: 14,
                ),
              ),
              const SizedBox(height: 5),
              ourTextField(
                title: "",
                hint: "0902442394",
                isPass: false,
              ),

              const SizedBox(height: 20),

              // Total Amount Donated (non-editable)
              Align(
                alignment: Alignment.centerLeft,
                child: ourText(
                  color: blackColor,
                  title: "Total Amount Donated:",
                  textSize: 12,
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: ourText(
                  color: blackColor,
                  title: "5000 PKR",
                  textSize: 12,
                ),
              ),

              const SizedBox(height: 30),

              // Edit Profile Button
              ourButton(
                onPress: () {
                  // Save profile logic
                },
                color: yellowColor,
                textColor: whiteColor,
                title: "save",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
