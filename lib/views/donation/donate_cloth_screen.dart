import 'package:charity_app/consts/consts.dart';
import 'package:get/get.dart';
import '../../controllers/item_donation_controller.dart';
import '../../reusable_widgets/our_back_button.dart';
import '../../reusable_widgets/our_button.dart';
import '../../reusable_widgets/our_multi_line_textfield.dart';
import '../../reusable_widgets/our_text.dart';
import '../../reusable_widgets/our_textField.dart';

class DonateClothScreen extends StatelessWidget {
  const DonateClothScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final donationController = Get.put(ItemDonationController());



    return Scaffold(
      appBar: AppBar(
        backgroundColor: yellowColor,
        centerTitle: true,
        leading: ourBackButton(context),
        title: ourText(color: whiteColor, title: clothDonation, textSize: 22),

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

                ourText(color: blackColor, title: addCloths, textSize: 16),

                const SizedBox(height: 8),

                ourTextField(
                  title: addCloths,
                  hint: addClothItems,
                  isPass: false,
                  controller: donationController.titleController,
                ),

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

                ourText(color: blackColor, title: availabilityTime, textSize: 16),
                const SizedBox(height: 8),
                // Add Time Field
                ourTextField(
                  title: addTime,
                  hint: availabilityTime,
                  isPass: false,
                  controller: donationController.timeController,
                ),

                const SizedBox(height: 13),

                ourText(color: blackColor, title: description, textSize: 16),
                const SizedBox(height: 8),
                ourMultilineTextField(
                  title: addDescription,
                  hint: addDescription,
                  controller: donationController.descriptionController,
                ),
                const SizedBox(height: 20),

                // Description Field







                // Donate Now Button
                SizedBox(
                  width: double.infinity,
                  child: ourButton(
                    onPress: () => donationController.addDonation(type: 'Cloths'),
                    color: yellowColor,
                    textColor: textColor,
                    title: donateNow,
                  ),
                ),
                const SizedBox(height: 16),

                // Cancel Button
                SizedBox(





                  width: double.infinity,
                  child:   ourButton(
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

