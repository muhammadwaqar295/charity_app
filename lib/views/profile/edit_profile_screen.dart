import 'dart:io';
import 'package:charity_app/consts/consts.dart';
import 'package:charity_app/consts/images.dart';
import 'package:charity_app/reusable_widgets/our_back_button.dart';
import 'package:charity_app/reusable_widgets/our_text.dart';
import 'package:charity_app/reusable_widgets/our_button.dart';
import 'package:charity_app/reusable_widgets/our_textField.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import '../../controllers/profile_edit_controller.dart';
import '../../reusable_widgets/profile_circle_avatar.dart';

class EditProfileScreen extends StatelessWidget {

  final dynamic data;
  const EditProfileScreen({super.key,this.data});

  @override
  Widget build(BuildContext context) {

    var controller = Get.put(ProfileEditController());



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
                child: ourBackButton(context)
              ),

              const SizedBox(height: 10),

              // Profile Text
              ourText(
                color: blackColor,
                title: profile,
                textSize: 22,
              ),

              const SizedBox(height: 20),



              //ourCircleAvatar(radius: 50,image: data['imgUrl']),

              Obx(() {
                String? imageUrl;
                if (controller.profileImagePath.value.isNotEmpty) {
                  // Local file selected from gallery
                  return GestureDetector(
                    onTap: () async {
                      await controller.pickImage();
                    },
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: FileImage(File(controller.profileImagePath.value)),
                    ),
                  );
                } else {
                  // Firebase image or fallback asset
                  imageUrl = controller.profileImageLink.isNotEmpty
                      ? controller.profileImageLink
                      : (data['imgUrl'] ?? "");

                  return GestureDetector(
                    onTap: () async {
                      await controller.pickImage();
                    },
                    child: ourCircleAvatar(
                      radius: 50,
                      image: imageUrl!.isNotEmpty ? imageUrl : imgProfile, // fallback to asset
                      fallbackIcon: Icons.person,
                    ),
                  );
                }
              }),


              const SizedBox(height: 10),

              ourButton(
                title: uploadImage,
                color: yellowColor,
                textColor: whiteColor,
                onPress: () async {
                  if (controller.profileImagePath.value.isNotEmpty) {
                    await controller.uploadProfileImage(File(controller.profileImagePath.value));
                  } else {
                    Fluttertoast.showToast(msg: please_select_an_image_first);
                  }
                },
              ),




              const SizedBox(height: 30),
              // Your Name
              Align(
                alignment: Alignment.centerLeft,
                child: ourText(
                  color: blackColor,
                  title: yourName,
                  textSize: 14,
                ),
              ),
              const SizedBox(height: 5),

              ourTextField(
                controller: controller.nameController,
                title: data['name'],
                isPass: false,
              ),

              const SizedBox(height: 15),

              // Your Email Address
              Align(
                alignment: Alignment.centerLeft,
                child: ourText(
                  color: blackColor,
                  title: yourOldPass,
                  textSize: 14,
                ),
              ),
              const SizedBox(height: 5),
              ourTextField(
                title: password,
              controller: controller.oldpassController,
                hint: passwordHint,
                isPass: false,
              ),

              const SizedBox(height: 15),

              // Your Phone
              Align(
                alignment: Alignment.centerLeft,
                child: ourText(
                  color: blackColor,
                  title: yourNewPass,
                  textSize: 14,
                ),
              ),
              const SizedBox(height: 5),
              ourTextField(
                controller: controller.newpassController,
                title: password,
                hint: passwordHint,
                isPass: false,
              ),





              const SizedBox(height: 30),

              // Edit Profile Button
              ourButton(
                onPress: () async {
                  // Check if both old and new password fields are filled
                  if (controller.oldpassController.text.isEmpty ||
                      controller.newpassController.text.isEmpty) {
                    Fluttertoast.showToast(msg: please_enter_both_old_and_new_passwords);
                    return;
                  }
                  try {
                    // Re-authenticate the user with their old password
                    await controller.changeAuthPassword(
                      email: data['email'],
                      password: controller.oldpassController.text,
                      newPassword: controller.newpassController.text,
                    );
                    // Optionally update password in Firestore (NOT RECOMMENDED FOR REAL APPS)
                    await controller.updateProfile(
                      password: controller.newpassController.text,
                    );
                    Fluttertoast.showToast(msg: password_updated_successfully);
                    // Clear text fields after success
                    controller.oldpassController.clear();
                    controller.newpassController.clear();
                  } catch (e) {
                    Fluttertoast.showToast(msg: wrong_old_password_or_error_occurred);

                  }
                },
                // Save profile logic
                color: yellowColor,
                textColor: whiteColor,
                title: save,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
