import 'package:charity_app/controllers/requester_register_controller.dart';
import 'package:charity_app/reusable_widgets/our_back_button.dart';
import 'package:charity_app/reusable_widgets/our_multi_line_textfield.dart';
import 'package:charity_app/reusable_widgets/our_button.dart';
import 'package:charity_app/reusable_widgets/our_text.dart';
import 'package:charity_app/reusable_widgets/our_textField.dart';
import 'package:charity_app/reusable_widgets/requester_imgs.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../consts/consts.dart';

class SignupRequester extends StatefulWidget {
  const SignupRequester({super.key});

  @override
  State<SignupRequester> createState() => _SignupRequesterState();
}

class _SignupRequesterState extends State<SignupRequester> {

var controller=Get.put(RequesterRegisterController());

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
            title: registerRequester,
            textSize: 20)
      ),
      body: SafeArea(
        child: SingleChildScrollView(
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
                  controller: controller.rNameController,
                  isPass: false,
                ),
        
                const SizedBox(height: 15),
        
                // Password TextField
                ourTextField(
                  title:title
                    ,hint: title_Hint,
                    controller: controller.rTitleController,
                    isPass: false
                ),
        
                const SizedBox(height: 15),
        
        
                ourTextField(
                  title: days,
                  hint: days_Hint,
                  controller: controller.rDaysController,
                  isPass: false
                ),
        
                const SizedBox(height: 15),
        
        
        
                ourTextField(
                  title:amounta,
                  hint: amounta_Hint,
                  controller: controller.rAmountController,
                  isPass: false
                ),
        
        
                const SizedBox(height: 15),
               ourTextField(
                  title:short_Des,
                  hint: short_Des_Hint,
                  controller: controller.rShortDesController,
                  isPass: false
                ),
        
        
                const SizedBox(height: 15),
        
           ourMultilineTextField(
               title: addDetails,
               controller: controller.rLongDesController,
               hint: addDetailsHint),


                const SizedBox(height: 20),

                ourText(color: blackColor, title: add_Images, textSize: 16),
                const SizedBox(height: 15),
                Obx(()=>
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: List.generate(3,
        
                          //when we select img than show img else box
                              (index)=>
        
                          controller.rImagesList[index] != null ?
        
                          GestureDetector(
                            onTap: () {
                              controller.pickImage(index, context);
                            },
                            child: Image.file(
                              controller.rImagesList[index],
                              width: 100,
                              height: 150,
                            ),
                          )
        
                              : RequesterImages(label: "${index+1}", onPress: () {
                            controller.pickImage(index, context);
                          })),
                    ),
                ),
        
                const SizedBox(height: 20),
        
                // Submit Button
                Obx(() => controller.isloading.value
                    ? const Center(child: CircularProgressIndicator())
                    : Center(
                  child: ourButton(
                    onPress: () async {
                      if (controller.rNameController.text.isEmpty ||
                          controller.rTitleController.text.isEmpty ||
                          controller.rDaysController.text.isEmpty ||
                          controller.rAmountController.text.isEmpty ||
                          controller.rShortDesController.text.isEmpty ||
                          controller.rLongDesController.text.isEmpty) {
                        Fluttertoast.showToast(msg: please_fill_all_fields);
                        return;
                      }

                      controller.isloading(true);
                      await controller.uploadImages();
                      await controller.uploadProducts(context);
                      controller.isloading(false);
                      Get.back();




                    },
                    color: yellowColor,
                    textColor: whiteColor,
                    title: submit,
                  ),
                ),
                ),

                const SizedBox(height: 15),
        
              ],
            ),
          ),
        ),
      ),
    );
  }

}