import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../consts/strings.dart';

class ItemDonationController extends GetxController {
  // TextEditingControllers
  final titleController = TextEditingController();
  final timeController = TextEditingController();
  final descriptionController = TextEditingController();
  final addressController = TextEditingController();

  var isLoading = false.obs;

  // Common method to upload data
  Future<void> addDonation({
    required String type,
  }) async {
    if (titleController.text.isEmpty ||
        timeController.text.isEmpty ||
        descriptionController.text.isEmpty ||
        addressController.text.isEmpty) {
      Get.snackbar("Error", "Please fill all fields");
      return;
    }

    try {
      isLoading.value = true;

      await FirebaseFirestore.instance.collection('itemsDonation').add({
        'title': titleController.text,
        'availabilityTime': timeController.text,
        'description': descriptionController.text,
        'address': addressController.text,
        'type': type,
        'timestamp': Timestamp.now(),
      });

      Get.back();
      Fluttertoast.showToast(msg:donation_Added_Successfully);
    //  Get.snackbar("Success", "Donation Added Successfully");
      clearFields();
    } catch (e) {
      Fluttertoast.showToast(msg:please_fill_all_fields);
     // Get.snackbar("Error", "Failed to add donation");
    } finally {
      isLoading.value = false;
    }
  }

  void clearFields() {
    titleController.clear();
    timeController.clear();
    descriptionController.clear();
    addressController.clear();
  }

  @override
  void onClose() {
    titleController.dispose();
    timeController.dispose();
    descriptionController.dispose();
    addressController.dispose();
    super.onClose();
  }
}
