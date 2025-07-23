import 'package:charity_app/consts/consts.dart';
import 'package:charity_app/consts/firebase_const.dart';
import 'package:charity_app/consts/images.dart';
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
                  color: blackColor,
                  title: profile,
                  textSize: 22,
                ),

                const SizedBox(height: 20),

                StreamBuilder(
                  stream: FiretoreServices.getUser(currentUser!.uid),
                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    }
                    if (snapshot.hasError || !snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return const Text(no_profile_data_found);
                    }

                    var data = snapshot.data!.docs[0];
                    String imageUrl = data['imgUrl'] ?? imgProfile;


                    return Column(
                      children: [
                        CircleAvatar( // Use direct CircleAvatar to test
                          radius: 50,
                          backgroundImage: NetworkImage(imageUrl),
                          backgroundColor: Colors.grey.shade200,
                        ),
                        const SizedBox(height: 30),
                        profileInfoLabel(yourName),
                        profileInfoBox(data['name'] ?? ''),
                        const SizedBox(height: 15),
                        profileInfoLabel(yourEmailAddress),
                        profileInfoBox(data['email'] ?? ''),
                        const SizedBox(height: 30),
                        ourButton(
                          onPress: () {
                            Get.to(() => const EditProfileScreen());
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
