import 'package:charity_app/consts/consts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../../reusable_widgets/our_text.dart';
import 'edit_person_details.dart';
import 'signup_requester.dart';

import '../../views/home_screens/home_screen.dart';



class AllPersonsForAdmin extends StatelessWidget {
  const AllPersonsForAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: yellowColor,
        centerTitle: true,
        title: ourText(color: whiteColor, title: allNeedyPerson, textSize: 22),

      ),
      floatingActionButton: SafeArea(
        child: FloatingActionButton(
        backgroundColor: yellowColor,
        onPressed: (){
          
          Get.to(()=>const SignupRequester());
        
        },child: const Icon(Icons.add,color: Colors.white,),),
      ),



      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('donation_compaigns')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final docs = snapshot.data?.docs;
                  if (docs == null || docs.isEmpty) {
                    return const Text(no_donation_campaigns_found);
                  }

                  final campaigns = docs.map((doc) {
                    final data = doc.data() as Map<String, dynamic>;
                    return DonationCampaignModel.fromMap(data, doc.id);
                  }).toList();

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
                          onTap:(){
                           // Get.to(() => DonationDetailsScreen(campaign: campaign));
                          },
                          child: Stack(
                            children: [
                              Column(
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
                                              : 'https://via.placeholder.com/150',
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 2),
                                    child: ourText(
                                      color: blackColor,
                                      title: campaign.title,
                                      textSize: 12,
                                    ),
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

                              // Popup menu in top-right corner
                              Positioned(
                                right: 0,
                                child: PopupMenuButton<String>(
                                  onSelected: (value) async {
                                    if (value == edit) {
                                      // Navigate to edit screen (you should create this)

                                      Get.to(() => EditPersonDetailScreen(campaign: campaign));
                                    } else if (value == delete) {
                                      // Delete the document from Firestore
                                      await FirebaseFirestore.instance
                                          .collection('donation_compaigns')
                                          .doc(campaign.id)
                                          .delete();
                                    }
                                  },
                                  itemBuilder: (context) => [
                                    const PopupMenuItem(
                                      value: edit,
                                      child: Text(edit),
                                    ),
                                    const PopupMenuItem(
                                      value: delete,
                                      child: Text(delete),
                                    ),
                                  ],
                                  icon: const Icon(Icons.more_vert, size: 18),
                                ),
                              ),
                            ],
                          ),
                        );
                      }

                  );
                },
              ),
            ],
          ),
        ),
      ),

    );
  }
}
