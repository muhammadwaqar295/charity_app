import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../../views/events/components/event_model.dart';
import '../../consts/consts.dart';

class EditEventController extends GetxController {
  late EventModel event;

  final titleController = TextEditingController();
  final desController = TextEditingController();

  RxList<File?> rImagesList = RxList.generate(3, (index) => null);
  List<String> existingImageUrls = [];

  var isloading = false.obs;

  void setInitialData(EventModel data) {
    event = data;
    titleController.text = event.title;
    desController.text = event.details;
    existingImageUrls = List.from(event.imageUrls);
  }

  Future<void> pickImage(int index) async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) {
      rImagesList[index] = File(picked.path);
      rImagesList.refresh();
    }
  }

  Future<void> updateEvent(BuildContext context) async {
    if (titleController.text.isEmpty || desController.text.isEmpty) {
      Get.snackbar("Error", please_fill_all_fields,
          backgroundColor: Colors.red, colorText: whiteColor);
      return;
    }

    isloading.value = true;

    List<String> updatedImageUrls = [];

    for (int i = 0; i < 3; i++) {
      if (rImagesList[i] != null) {
        final ref = FirebaseStorage.instance
            .ref("event_images/${event.id}/image_$i.jpg");
        await ref.putFile(rImagesList[i]!);
        final url = await ref.getDownloadURL();
        updatedImageUrls.add(url);
      } else {
        updatedImageUrls.add(
            existingImageUrls.length > i ? existingImageUrls[i] : '');
      }
    }

    await FirebaseFirestore.instance.collection('events').doc(event.id).update({
      'title': titleController.text,
      'des': desController.text,
      'images': updatedImageUrls,
    });

    isloading.value = false;
    Get.back();
    Fluttertoast.showToast(msg: event_updated_successfully);

  }
}
