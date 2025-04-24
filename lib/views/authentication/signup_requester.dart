import 'package:charity_app/reusable_widgets/our_back_button.dart';
import 'package:charity_app/reusable_widgets/our_multi_line_textfield.dart';
import 'package:charity_app/reusable_widgets/our_button.dart';
import 'package:charity_app/reusable_widgets/our_text.dart';
import 'package:charity_app/reusable_widgets/our_textField.dart';

import '../../consts/consts.dart';

class SignupRequester extends StatefulWidget {
  const SignupRequester({super.key});

  @override
  State<SignupRequester> createState() => _SignupRequesterState();
}

class _SignupRequesterState extends State<SignupRequester> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: yellowColor,
        elevation: 0,

        leading:ourBackButton(context,iconColor: blackColor),


        title: ourText(
            color: blackColor,
            title: becomeRequester,
            textSize: 20)
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              const SizedBox(height: 30),

                   //name TextField
              ourTextField(
                title: name,
                hint: nameHint,
                isPass: false,
              ),

              const SizedBox(height: 15),

              // Password TextField
              ourTextField(
                title:password
                  ,hint: passwordHint,
                  isPass: true
              ),

              const SizedBox(height: 15),

              // Email TextField
              ourTextField(
                title: email,
                hint: emailHint,
                isPass: false
              ),

              const SizedBox(height: 15),

              // Phone TextField

              ourTextField(
                title:phone,
                hint: phoneHint,
                isPass: false
              ),


              const SizedBox(height: 15),

         ourMultilineTextField(
             title: addDetails,
             hint: addDetailsHint),





              const SizedBox(height: 20),

              // Submit Button
              Center(
                child: ourButton(
                    onPress: (){},
                    color: yellowColor,
                    textColor: whiteColor,
                    title: submit),
              ),

            ],
          ),
        ),
      ),
    );
  }

}