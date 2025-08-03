import 'package:charity_app/consts/consts.dart';
import 'package:get/get.dart';
import '../../reusable_widgets/our_back_button.dart';
import '../../reusable_widgets/our_button.dart';
import '../../reusable_widgets/our_multi_line_textfield.dart';
import '../../reusable_widgets/our_text.dart';
import '../../reusable_widgets/our_textField.dart';

class DonateMedicineScreen extends StatelessWidget {
  const DonateMedicineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: yellowColor,
        centerTitle: true,
        leading: ourBackButton(context),
        title: ourText(color: whiteColor, title: medicineDonation, textSize: 22),

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

                ourText(color: blackColor, title: addMedicine, textSize: 16),

                const SizedBox(height: 8),

                ourTextField(title:addMedicine  ,hint: addMedicineItem,isPass: false),


                const SizedBox(height: 20),

                // Add Time Field
                ourText(color: blackColor, title: availabilityTime, textSize: 16),


                const SizedBox(height: 8),

                ourTextField(title:addTime  ,hint: availabilityTime,isPass: false),

                const SizedBox(height: 20),

                // Description Field

                ourText(color: blackColor, title: description, textSize: 16),

                const SizedBox(height: 8),

                ourMultilineTextField(title:addDescription  ,hint: addDescription,),

                const SizedBox(height: 40),

                // Donate Now Button
                SizedBox(
                  width: double.infinity,
                  child: ourButton(
                      onPress: (){},
                      color: yellowColor,
                      textColor: textColor,
                      title: donateNow),
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

