import 'package:charity_app/consts/consts.dart';
import 'package:charity_app/consts/images.dart';
import 'package:charity_app/reusable_widgets/our_back_button.dart';
import 'package:charity_app/reusable_widgets/our_button.dart';
import 'package:charity_app/reusable_widgets/profile_circle_avatar.dart';
import '../../reusable_widgets/our_text.dart';

class DonationDetailsScreen extends StatelessWidget {
  const DonationDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Top Row with Back Button and Title
              Row(
                children: [
                ourBackButton(context),
                   Expanded(
                    child: Center(
                      child: ourText(color: blackColor, title: compin, textSize: 22),
                    ),
                  ),
                  const SizedBox(width: 48), // To balance back button
                ],
              ),

              const SizedBox(height: 12),

              // Profile Image
              ourCircleAvatar(radius: 60,image: imgRequester),


              const SizedBox(height: 16),

              // Name
               Align(
                alignment: Alignment.centerLeft,
                   child:  ourText(color: blackColor, title: nameAbbas, textSize: 18),
               
              ),

              const SizedBox(height: 12),

              // Details Box
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ourText(color: blackColor, title: details, textSize: 16),
                    ourText(color: textColor, title: requesterDetails, textSize: 14),

                  ],
                )
              ),

              const SizedBox(height: 16),



              const SizedBox(height: 16),

              // Donation Row
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.grey.shade200,
                ),
                child: Row(
                  children: [
                    ourText(color: blackColor, title: needAmount, textSize: 14),
                    ourText(color: textColor, title: PKR, textSize: 13),
                    const Spacer(),
                    const Icon(Icons.access_time_rounded),
                    const SizedBox(width: 6),
                    ourText(color: textColor, title: daysLeft, textSize: 13),

                  ],
                ),
              ),

              const SizedBox(height: 12),

              // Image Gallery
              SizedBox(
                height: 140,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return Container(
                      width: 120,
                      margin: const EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black12),
                        borderRadius: BorderRadius.circular(10),
                        image: const DecorationImage(
                          image: AssetImage(imgRequester),
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 20),

              ourButton(
                  onPress: (){},
                  color: yellowColor
                  , textColor: blackColor,
                  title: donateNow)

            ],
          ),
        ),
      ),
    );
  }
}
