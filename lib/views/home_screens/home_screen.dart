import 'package:charity_app/consts/consts.dart';
import 'package:charity_app/consts/images.dart';
import 'package:charity_app/reusable_widgets/our_text.dart';
import 'package:charity_app/reusable_widgets/profile_circle_avatar.dart';
import 'package:charity_app/views/donation/donate_cloth_screen.dart';
import 'package:charity_app/views/donation/donate_food_screen.dart';
import 'package:charity_app/views/donation/donate_for_construction_screen.dart';
import 'package:charity_app/views/donation/donate_for_medical_screen.dart';
import 'package:charity_app/views/donation/donation_details_screen.dart';
import 'package:charity_app/views/home_screens/components/MenuBarPage.dart';
import 'package:charity_app/views/notificatons/notification_screen.dart';
import 'package:charity_app/views/profile/profile_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../consts/firebase_const.dart';
import '../../services/firestore_services.dart';
import 'components/category_items.dart';
import 'components/spacial_event_compaigns.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.menu, size: 28),
                    onPressed: () {
                     Get.to(()=>MenuBarPage());
                    },
                  ),

                  ourText(color:yellowColor , title: charity, textSize: 24),


                  Row(
                    children: [
                      GestureDetector(child: ourCircleAvatar(radius: 18,fallbackIcon: Icons.notifications_none),
                      onTap: (){
                        Get.to(()=>NotificationScreen());
                      },),


                      const SizedBox(width: 8),


                      // Inside HomeScreen's build method:
                      StreamBuilder(
                        stream: FiretoreServices.getUser(currentUser!.uid),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return ourCircleAvatar(radius: 18); // Placeholder while loading
                          }

                          if (!snapshot.hasData || !snapshot.data!.exists) {
                            return ourCircleAvatar(radius: 18); // Default avatar if no data
                          }

                          var userData = snapshot.data!.data() as Map<String, dynamic>;
                          String imageUrl = userData['imgUrl'] ?? imgProfile;

                          return GestureDetector(
                            onTap: () {
                              Get.to(() => const ProfileScreen());
                            },
                            child: ourCircleAvatar(
                              radius: 18,
                              image: (imageUrl.isNotEmpty && imageUrl.startsWith('http')) ? imageUrl : imgProfile,
                            ),
                          );
                        },
                      ),


                      /* GestureDetector(child: ourCircleAvatar(radius: 18,image: imgProfile),
                      onTap: (){
                        Get.to(()=>const ProfileScreen());
                      },),*/


                    ],
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Search Bar
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const TextField(
                  decoration: InputDecoration(
                    icon: Icon(Icons.search, color: blackColor, size: 20),
                    hintText: searchCharityCampaigns,
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(vertical: 8),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Donation Campaign Grid
               Padding(
                padding: const EdgeInsets.only(left: 4),
                child:
                    ourText(color: blackColor, title: donationCampaigns, textSize: 16)


              ),
              const SizedBox(height: 8),
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection('donation_compaigns').snapshots(),
                builder: (context, snapshot) {
                  print("snapshot state 👉 ${snapshot.connectionState}");
                  print("snapshot hasData 👉 ${snapshot.hasData}");
                  print("snapshot hasError 👉 ${snapshot.hasError}");
                  print("snapshot error 👉 ${snapshot.error}");
                  print("docs count 👉 ${snapshot.data?.docs.length}");

                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final docs = snapshot.data?.docs;
                  if (docs == null || docs.isEmpty) {
                    return const Text("No donation campaigns found.");
                  }

                  final campaigns = docs.map((doc) {
                    final data = doc.data() as Map<String, dynamic>;
                    print("Campaign doc data 👉 $data");
                    return DonationCampaignModel.fromMap(data, doc.id);
                  }).toList();

                  print("campaigns parsed 👉 ${campaigns.length}");

                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: campaigns.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                      childAspectRatio: 0.98,
                    ),
                    itemBuilder: (context, index) {
                      final campaign = campaigns[index];
                      return GestureDetector(
                        onTap: () => Get.to(() => DonationDetailsScreen(campaign: campaign)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 100,
                              decoration: BoxDecoration(
                                border: Border.all(color: yellowColor, width: 1.5),
                                borderRadius: BorderRadius.circular(8),
                                image: DecorationImage(
                                  image: NetworkImage(
                                      campaign.imageUrls.isNotEmpty
                                          ? campaign.imageUrls[0]
                                          : 'https://via.placeholder.com/150'
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 2),
                              child: ourText(color: blackColor, title: campaign.title, textSize: 12),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 2),
                              child: Text(
                                campaign.shortDescription,
                                style: const TextStyle(fontSize: 10),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),


              // Eid Campaign Section
               Padding(
                padding: const EdgeInsets.only(left: 4),
                child: ourText(color: blackColor, title: eidCampaigns, textSize: 16)
              ),
              const SizedBox(height: 8),

// Horizontal scrollable Eid section
              SizedBox(
                height: 120,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    const SizedBox(width: 12), // spacing from left edge
                    GestureDetector(
                 /*     onTap: (){Get.to(()=>EventsScreen());},*/
                        child: spacialCompaings(imgEid, eidRelief)),
                    const SizedBox(width: 12),
                    spacialCompaings(imgRamazan, ramadanSupport),
                    const SizedBox(width: 12),
                    spacialCompaings(imgFood, foodSupport),
                    const SizedBox(width: 12),
                    spacialCompaings(imgCloth, clothingHelp),
                    const SizedBox(width: 12), // spacing at end
                  ],
                ),
              ),


              // Categories Section

               Padding(
                padding: const EdgeInsets.only(left: 4),
                child:
                ourText(color: blackColor, title: categories, textSize: 16)

              ),
              const SizedBox(height: 8),
              SizedBox(
                height: 92,
                child: GridView.count(
                  crossAxisCount: 4,
                  mainAxisSpacing: 6,
                  crossAxisSpacing: 6,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    categoryItem(imgFood, food,()=>Get.to(()=>const FoodDonationScreen())),
                    categoryItem(imgCloth, clothing,()=>Get.to(()=>const DonateClothScreen())),
                    categoryItem(imgMedical, medical,()=>Get.to(()=>const DonateForMedicalScreen())),
                    categoryItem(imgConstruction, shelter,()=>Get.to(()=>const DonateForConstructionScreen())),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}

class DonationCampaignModel {
  final String id;
  final String title;
  final String shortDescription;
  final String fullDescription;
  final String needyName;
  final String needAmount;
  final int daysLeft;
  final List<String> imageUrls;

  DonationCampaignModel({
    required this.id,
    required this.title,
    required this.shortDescription,
    required this.fullDescription,
    required this.needyName,
    required this.needAmount,
    required this.daysLeft,
    required this.imageUrls,
  });

  factory DonationCampaignModel.fromMap(Map<String, dynamic> data, String docId) {
    return DonationCampaignModel(
      id: docId,
      title: data['title'] ?? '',
      shortDescription: data['short_description'] ?? '',
      fullDescription: data['full_description'] ?? '',
      needyName: data['needy_name'] ?? '',
      needAmount: data['need_amount'] ?? '',
      daysLeft: int.tryParse(data['days_left']?.toString() ?? '0') ?? 0,
      imageUrls: List<String>.from(data['image'] ?? []),
    );
  }
}
