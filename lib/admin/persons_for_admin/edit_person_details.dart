import 'package:charity_app/reusable_widgets/our_multi_line_textfield.dart';
import 'package:charity_app/reusable_widgets/our_textField.dart';
import 'package:get/get.dart';
import '../../consts/consts.dart';
import '../../reusable_widgets/our_back_button.dart';
import '../../reusable_widgets/our_text.dart';
import '../../views/home_screens/home_screen.dart';
import 'edit_person_details_controller.dart';


class EditPersonDetailScreen extends StatelessWidget {
  final DonationCampaignModel campaign;

  const EditPersonDetailScreen({super.key, required this.campaign});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(EditPersonController());

    controller.setInitialData(
      id: campaign.id,
      title: campaign.title,
      shortDesc: campaign.shortDescription,
      longDesc: campaign.fullDescription,
      name: campaign.needyName,
      images: List<String>.from(campaign.imageUrls ?? []),
    );

    return Scaffold(


      appBar: AppBar(
        backgroundColor: yellowColor,
        centerTitle: true,
        title: ourText(color: blackColor, title: edit_Campaign, textSize: 17),
        leading: ourBackButton(context),

      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            ourTextField(controller: controller.nameController,title: name),



            const SizedBox(height: 15),

            ourTextField(controller: controller.titleController,title: title),

            const SizedBox(height: 15),

            ourTextField(controller: controller.shortDescController,title: short_Des),


            const SizedBox(height: 15),
            ourMultilineTextField(title: long_Des, hint: long_Des_Hint,controller: controller.longDescController),



            const SizedBox(height: 20),

            /// Show existing images and allow to replace
            Obx(() =>
                Wrap(
                  spacing: 10,
                  children: List.generate(controller.imageUrls.length, (index) {
                    final currentUrl = controller.imageUrls[index];
                    final updatedImage = controller.selectedImages[index];

                    return GestureDetector(
                      onTap: () => controller.pickAndReplaceImage(index),
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: updatedImage != null
                                ? Image.file(
                              updatedImage,
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            )
                                : Image.network(
                              currentUrl,
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const Positioned(
                            right: 4,
                            top: 4,
                            child: Icon(Icons.edit, color: Colors.white),
                          )
                        ],
                      ),
                    );
                  }),
                )),
            const SizedBox(height: 20),

            Center(
              child: Obx(() =>
                  ElevatedButton(

                    onPressed: controller.isLoading.value
                        ? null
                        : controller.updateCampaign,
                    child: controller.isLoading.value
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text('Update'),
                  )

              ),
            ),
          ],
        ),
      ),
    );
  }
}