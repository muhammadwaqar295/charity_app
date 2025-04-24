import 'package:charity_app/consts/consts.dart';
import 'package:charity_app/consts/images.dart';
import 'package:charity_app/reusable_widgets/our_back_button.dart';
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

              // Profile Image
              const CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage(imgProfile), // replace with your image or network
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
                title: noorJan,
                //hint: "Trần Lâm Khang",
                isPass: false,
              ),

              const SizedBox(height: 15),

              // Your Email Address
              Align(
                alignment: Alignment.centerLeft,
                child: ourText(
                  color: blackColor,
                  title: yourEmailAddress,
                  textSize: 14,
                ),
              ),
              const SizedBox(height: 5),
              ourTextField(
                title: noorGmail,
              //  hint: "tranlamkhang99@gmail.com",
                isPass: false,
              ),

              const SizedBox(height: 15),

              // Your Phone
              Align(
                alignment: Alignment.centerLeft,
                child: ourText(
                  color: blackColor,
                  title: yourPhone,
                  textSize: 14,
                ),
              ),
              const SizedBox(height: 5),
              ourTextField(
                title: phoneNo,
               // hint: "0902442394",
                isPass: false,
              ),

              const SizedBox(height: 20),



              const SizedBox(height: 30),

              // Edit Profile Button
              ourButton(
                onPress: () {
                  // Save profile logic
                },
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
