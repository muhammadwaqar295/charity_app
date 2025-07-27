import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../consts/consts.dart';
import '../consts/firebase_const.dart';

class ProfileEditController extends GetxController {
  late QueryDocumentSnapshot snapshotData;

  var profileImagePath = ''.obs;
  var profileImageLink = '';
  var isloading2 = false.obs;
  var isloadingSave = false.obs;

  var nameController = TextEditingController();
  var oldpassController = TextEditingController();
  var newpassController = TextEditingController();

  // Update profile
  updateProfile({password}) async {
    try {
      isloadingSave(true);

      var store = fireFirestore.collection(userCollection).doc(currentUser!.uid);
      await store.set({
        'password': password,
      }, SetOptions(merge: true));


    } catch (e) {
      Fluttertoast.showToast(msg: "Failed to update profile");
    } finally {
      isloadingSave(false);
    }
  }


  // Change auth password
  changeAuthPassword({email, password, newPassword}) async {
    final cred = EmailAuthProvider.credential(email: email, password: password);
    await currentUser!.reauthenticateWithCredential(cred).then((value) {
      currentUser!.updatePassword(newPassword);
    }).catchError((error) {
      // Handle error
    });
  }

  // Image Picker
  pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImagePath.value = pickedFile.path;
    }
  }

  // Upload and update profile image
  Future<void> uploadProfileImage(File image) async {
    try {
      isloading2(true);

      final ref = FirebaseStorage.instance
          .ref()
          .child('profileImages')
          .child("${currentUser!.uid}.jpg");

      UploadTask uploadTask = ref.putFile(image);
      TaskSnapshot snapshot = await uploadTask;

      profileImageLink = await snapshot.ref.getDownloadURL();

      await fireFirestore.collection(userCollection).doc(currentUser!.uid).set({
        'imgUrl': profileImageLink,
      }, SetOptions(merge: true));

      profileImagePath.value = '';
      profileImagePath.refresh();

      Fluttertoast.showToast(msg: image_uploaded_successfully);
    } catch (e) {
      Fluttertoast.showToast(msg: image_upload_failed);
    } finally {
      isloading2(false);
    }
  }
}
