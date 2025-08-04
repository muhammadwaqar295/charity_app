import 'package:get/get.dart';
import '../../consts/consts.dart';
import '../../reusable_widgets/our_back_button.dart';
import '../../reusable_widgets/our_text.dart';
import '../../reusable_widgets/our_textField.dart';
import '../../reusable_widgets/our_multi_line_textfield.dart';
import '../../reusable_widgets/requester_imgs.dart';
import '../../reusable_widgets/our_button.dart';
import '../../views/events/components/event_model.dart';
import 'edit_event_controller.dart';


class EditEventScreen extends StatelessWidget {
  final EventModel event;

  const EditEventScreen({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(EditEventController());
    controller.setInitialData(event);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: yellowColor,
        elevation: 0,
        leading: ourBackButton(context, iconColor: blackColor),
        title: ourText(color: whiteColor, title: edit_Event, textSize: 20),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Obx(() => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 60),
                ourTextField(
                    title: title,
                    hint: title_Hint,
                    controller: controller.titleController,
                    isPass: false),
                const SizedBox(height: 15),
                ourMultilineTextField(
                    title: addDetails,
                    controller: controller.desController,
                    hint: addDetailsHint),
                const SizedBox(height: 15),
                ourText(color: blackColor, title: add_Images, textSize: 16),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: List.generate(3, (index) {
                    final selected = controller.rImagesList[index];
                    final oldUrl = controller.existingImageUrls.length > index
                        ? controller.existingImageUrls[index]
                        : null;

                    if (selected != null) {
                      return GestureDetector(
                        onTap: () => controller.pickImage(index),
                        child: Image.file(selected, width: 100, height: 150),
                      );
                    } else if (oldUrl != null && oldUrl.isNotEmpty) {
                      return GestureDetector(
                        onTap: () => controller.pickImage(index),
                        child: Image.network(oldUrl,
                            width: 100, height: 150, fit: BoxFit.cover),
                      );
                    } else {
                      return RequesterImages(
                        label: "${index + 1}",
                        onPress: () => controller.pickImage(index),
                      );
                    }
                  }),
                ),
                const SizedBox(height: 20),
                controller.isloading.value
                    ? const Center(child: CircularProgressIndicator())
                    : Center(
                  child: ourButton(
                      onPress: () => controller.updateEvent(context),
                      color: yellowColor,
                      textColor: whiteColor,
                      title: submit),
                ),
                const SizedBox(height: 20),
              ],
            )),
          ),
        ),
      ),
    );
  }
}
