import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../consts/consts.dart';
import '../consts/firebase_const.dart';



class ProfileEditController extends GetxController{

  late QueryDocumentSnapshot snapshotData;

  var profileImagePath=''.obs;


  var profileImageLink='';

  var nameController=TextEditingController();
  var oldpassController=TextEditingController();
  var newpassController=TextEditingController();




  updateProfile({
    //name
    password,})async{
    var strore=fireFirestore.collection(userCollection).doc(currentUser!.uid);
    await strore.set({
      //'name':name,
      'password':password,
      //'imageUrl': imageUrl
    },SetOptions(merge: true));


  }


  //change pass
  changeAuthPassword({email,password,newPassword})async{
    final cred=EmailAuthProvider.credential(email: email, password: password);
    //again login user
    await currentUser!.reauthenticateWithCredential(cred).then((value){

      //change pass
      currentUser!.updatePassword(newPassword);
    }).catchError((error){
     // print(error..toString());
    });

  }



  // Image Picker
  pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      profileImagePath.value = pickedFile.path;
    }
  }


// upload and update img
  Future<void> uploadProfileImage(File image) async {
    try {
      final ref = FirebaseStorage.instance
          .ref()
          .child('profileImages')
          .child("${currentUser!.uid}.jpg");
      UploadTask uploadTask = ref.putFile(image);
      TaskSnapshot snapshot = await uploadTask;

      profileImageLink = await snapshot.ref.getDownloadURL();

      // Save image URL to Firestore
      await fireFirestore.collection(userCollection).doc(currentUser!.uid).set({
        'imgUrl': profileImageLink,
      }, SetOptions(merge: true));
      profileImagePath.value = ''; // Clear picked file
      profileImagePath.refresh();


      Fluttertoast.showToast(msg: image_uploaded_successfully);
    } catch (e) {
      Fluttertoast.showToast(msg: image_upload_failed);

    }
  }




}