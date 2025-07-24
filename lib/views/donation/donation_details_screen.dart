import 'package:charity_app/consts/consts.dart';
import 'package:charity_app/reusable_widgets/our_back_button.dart';
import 'package:charity_app/reusable_widgets/our_button.dart';
import 'package:charity_app/reusable_widgets/profile_circle_avatar.dart';
import 'package:charity_app/views/donation/donation_screen.dart';
import 'package:get/get.dart'; // Create this model if not done
import '../../reusable_widgets/our_text.dart';
import '../home_screens/home_screen.dart';

class DonationDetailsScreen extends StatelessWidget {
  final DonationCampaignModel campaign;

  const DonationDetailsScreen({super.key, required this.campaign});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Top Bar
              Row(
                children: [
                  ourBackButton(context),
                  Expanded(
                    child: Center(
                      child: ourText(color: blackColor, title: compin, textSize: 22),
                    ),
                  ),
                  const SizedBox(width: 48),
                ],
              ),

              const SizedBox(height: 12),

              // Main Image / Avatar
              ourCircleAvatar(
                radius: 60,
                image: campaign.imageUrls.isNotEmpty ? campaign.imageUrls[0] : '',
                fallbackIcon: Icons.person,
              ),

              const SizedBox(height: 16),

              // Name
              Align(
                alignment: Alignment.centerLeft,
                child: ourText(
                  color: blackColor,
                  title: "Name: ${campaign.needyName}",
                  textSize: 18,
                ),
              ),

              const SizedBox(height: 12),

              // Details
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ourText(color: blackColor, title: "Details:", textSize: 16),
                    const SizedBox(height: 8),
                    ourText(
                      color: textColor,
                      title: campaign.fullDescription,
                      textSize: 14,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // Donation Summary
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.grey.shade200,
                ),
                child: Row(
                  children: [
                    ourText(color: blackColor, title: "Need Amount:", textSize: 14),
                    const SizedBox(width: 4),
                    ourText(color: textColor, title: "${campaign.needAmount} PKR", textSize: 13),
                    const Spacer(),
                    const Icon(Icons.access_time_rounded, size: 16),
                    const SizedBox(width: 6),
                    ourText(color: textColor, title: "${campaign.daysLeft} days left", textSize: 13),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              // Image Gallery
              SizedBox(
                height: 140,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: campaign.imageUrls.length,
                  itemBuilder: (context, index) {
                    return Container(
                      width: 120,
                      margin: const EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black12),
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: NetworkImage(campaign.imageUrls[index]),
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 20),

              // Donate Now Button
              ourButton(
                onPress: () {
                  Get.to(() => const DonationScreen());
                },
                color: yellowColor,
                textColor: blackColor,
                title: donateNow,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
