import 'package:charity_app/consts/consts.dart';
import 'package:charity_app/consts/firebase_const.dart';
import 'package:charity_app/consts/images.dart';
import 'package:charity_app/reusable_widgets/profile_circle_avatar.dart';
import 'package:charity_app/views/profile/edit_profile_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:charity_app/reusable_widgets/our_text.dart';
import 'package:charity_app/reusable_widgets/our_button.dart';
import 'package:get/get.dart';
import '../../services/firestore_services.dart';

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
                  color: yellowColor,
                  title: profile,
                  textSize: 22,
                ),

                const SizedBox(height: 20),
                StreamBuilder(
                  stream: FiretoreServices.getUser(currentUser!.uid),
                  builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {


                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (!snapshot.hasData || snapshot.hasError || !snapshot.data!.exists) {
                      return const Text(no_profile_data_found);
                    }

                    var data = snapshot.data!.data() as Map<String, dynamic>;
                    String imageUrl = data['imgUrl'] ?? imgProfile;


                    return Column(
                      children: [

                        ourCircleAvatar(
                          radius: 50,
                          image: (imageUrl.isNotEmpty && imageUrl.startsWith('http'))
                              ? imageUrl
                              : imgProfile,
                        ),

                        //ourCircleAvatar(radius: 50,image: imageUrl),

                        const SizedBox(height: 30),
                        profileInfoLabel(yourName),
                        profileInfoBox(data['name'] ?? ''),
                        const SizedBox(height: 15),
                        profileInfoLabel(yourEmailAddress),
                        profileInfoBox(data['email'] ?? ''),
                        const SizedBox(height: 30),
                        ourButton(
                          onPress: () {
                            Get.to(() =>  EditProfileScreen(data:data));
                          },
                          color: yellowColor,
                          textColor: whiteColor,
                          title: editProfile,
                        ),
                      ],
                    );
                  },
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
