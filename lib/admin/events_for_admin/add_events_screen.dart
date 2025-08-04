import 'package:charity_app/consts/consts.dart';
import 'package:charity_app/reusable_widgets/our_back_button.dart';
import 'package:charity_app/reusable_widgets/our_text.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import '../../controllers/event_register_controller.dart';
import '../../reusable_widgets/our_button.dart';
import '../../reusable_widgets/our_multi_line_textfield.dart';
import '../../reusable_widgets/our_textField.dart';
import '../../reusable_widgets/requester_imgs.dart';


class AddEventsScreen extends StatelessWidget {
  const AddEventsScreen({super.key});

  @override
  Widget build(BuildContext context) {

    var controller=Get.put(EventsRegisterController());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: yellowColor,
        elevation: 0,
        centerTitle: true,
        leading: ourBackButton(context,iconColor: blackColor),
        title: ourText(color: whiteColor, title: add_events, textSize: 22),
      ),
      body: SafeArea(
          child: SingleChildScrollView(

            child: Padding(

              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 60),

                  //name TextField
                  ourTextField(
                    title: title,
                    hint: title_Hint,
                    controller: controller.titleController,
                    isPass: false,
                  ),

                  const SizedBox(height: 15),


                  ourMultilineTextField(
                      title: addDetails,
                      controller: controller.desController,
                      hint: addDetailsHint),

                  const SizedBox(height: 15),


                  ourText(color: blackColor, title: add_Images, textSize: 16),
                  const SizedBox(height: 10),
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

                  const SizedBox(height: 15),

                  Obx(() => controller.isloading.value
                      ? const Center(child: CircularProgressIndicator())
                      : Center(
                    child: ourButton(
                      onPress: () async {
                        if (controller.titleController.text.isEmpty ||
                            controller.desController.text.isEmpty
                            ) {
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
          )),
    );
  }
}
