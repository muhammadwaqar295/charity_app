import 'package:charity_app/consts/colors.dart';
import 'package:charity_app/reusable_widgets/our_back_button.dart';
import 'package:charity_app/reusable_widgets/our_button.dart';
import 'package:charity_app/reusable_widgets/our_multi_line_textfield.dart';
import 'package:charity_app/reusable_widgets/our_text.dart';
import 'package:charity_app/reusable_widgets/our_textField.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../../consts/strings.dart';
import '../../controllers/item_donation_controller.dart';

class FoodDonationScreen extends StatelessWidget {
  const FoodDonationScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final donationController = Get.find<ItemDonationController>();


    return Scaffold(
      appBar: AppBar(
        backgroundColor: yellowColor,
        centerTitle: true,
        leading: ourBackButton(context),
        title: ourText(color: whiteColor, title: foodDonation, textSize: 22),

      ),
      backgroundColor:whiteColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [


                const SizedBox(height: 12),
            
                // Add Food Items Field
            
                ourText(color: blackColor, title: addFoodItems, textSize: 16),
            
                const SizedBox(height: 8),
                ourTextField(
                  title: addFoods,
                  hint: addFoodItems,
                  isPass: false,
                  controller: donationController.titleController,
                ),

               // ourTextField(title:addFoods  ,hint: addFoodItems,isPass: false),

                const SizedBox(height: 13),

                ourText(color: blackColor, title: add_address, textSize: 16),

                const SizedBox(height: 8),

                ourTextField(
                  title: add_address,
                  hint: plz_add_yor_address,
                  isPass: false,
                  controller: donationController.addressController,
                ),



                const SizedBox(height: 13),
            
                // Add Time Field

                ourText(color: blackColor, title: availabilityTime, textSize: 16),
            
            
                const SizedBox(height: 8),
                ourTextField(
                  title: addTime,
                  hint: availabilityTime,
                  isPass: false,
                  controller: donationController.timeController,
                ),
              //  ourTextField(title:addTime  ,hint: availabilityTime,isPass: false),
            
                const SizedBox(height: 13),
            
                // Description Field
            
                ourText(color: blackColor, title: description, textSize: 16),
            
                const SizedBox(height: 8),
                ourMultilineTextField(
                  title: addDescription,
                  hint: addDescription,
                  controller: donationController.descriptionController,
                ),
                //ourMultilineTextField(title:addDescription  ,hint: addDescription,),
            
                const SizedBox(height: 20),
            
                // Donate Now Button
                SizedBox(
                  width: double.infinity,
                  child:ourButton(
                    onPress: () => donationController.addDonation(type: 'Food'),
                    color: yellowColor,
                    textColor: textColor,
                    title: donateNow,
                  ),

                ),
                const SizedBox(height: 16),
            
                // Cancel Button
                SizedBox(
                  width: double.infinity,
                  child:
                  ourButton(
                      onPress: (){
                        Get.back();
                      },
                      color: yellowColor,
                      textColor: textColor,
                      title: cancel),
                
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
