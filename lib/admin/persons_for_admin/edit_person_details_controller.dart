import 'dart:ffi';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import '../../consts/colors.dart';

class EditPersonController extends GetxController {
  final titleController = TextEditingController();
  final shortDescController = TextEditingController();
  final longDescController = TextEditingController();


  final needAmountController = TextEditingController();
  final nameController = TextEditingController();

  var isLoading = false.obs;
  var imageUrls = <String>[].obs; // stores Firebase URLs
  var selectedImages = <int, File>{}.obs; // index:File for updated images

  late String campaignId;

  void setInitialData({
    required String id,
    required String title,
    required String shortDesc,
    required String longDesc,


    required String name,



    List<String>? images,
  }) {
    campaignId = id;
    titleController.text = title;
    shortDescController.text = shortDesc;
    longDescController.text = longDesc ?? '';

    nameController.text=name;


    imageUrls.value = images ?? [];
  }

  Future<void> pickAndReplaceImage(int index) async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) {
      selectedImages[index] = File(picked.path);
    }
  }

  Future<List<String>> uploadAllSelectedImages() async {
    List<String> finalUrls = List.from(imageUrls);

    for (var entry in selectedImages.entries) {
      int index = entry.key;
      File file = entry.value;

      String fileName = basename(file.path);
      final ref = FirebaseStorage.instance
          .ref()
          .child('campaign_images')
          .child('$campaignId-$index-$fileName');

      await ref.putFile(file);
      final url = await ref.getDownloadURL();
      finalUrls[index] = url; // Replace at that index
    }

    return finalUrls;
  }

  Future<void> updateCampaign() async {
    isLoading.value = true;
    try {
      final updatedUrls = await uploadAllSelectedImages();

      await FirebaseFirestore.instance
          .collection('donation_compaigns')
          .doc(campaignId)
          .update({
        'title': titleController.text.trim(),
        'short_description': shortDescController.text.trim(),
        'full_description': longDescController.text.trim(),

        'needy_name': nameController.text.trim(),


        'image': updatedUrls, // Note: your field must be named "images"
      });

      Fluttertoast.showToast(msg: 'Campaign updated successfully!');
      Get.back();
    } catch (e) {
      Get.snackbar('Error', e.toString(),
          backgroundColor: Colors.red, colorText: whiteColor);
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    titleController.dispose();
    shortDescController.dispose();
    longDescController.dispose();
    super.onClose();
  }




}
