import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import '../consts/consts.dart';
import '../consts/firebase_const.dart';

class RequesterRegisterController extends GetxController{

  var isloading=false.obs;

  var rNameController=TextEditingController();
  var rTitleController=TextEditingController();
  var rDaysController=TextEditingController();
  var rAmountController=TextEditingController();
  var rShortDesController=TextEditingController();
  var rLongDesController=TextEditingController();


  var rImagesLinks = <String>[];// it imgs links
  var rImagesList=RxList<dynamic>.generate(3, (index)=>null);




  pickImage(index,context)async{
    try{
      final img=await ImagePicker().pickImage(source: ImageSource.gallery,imageQuality: 80);
      if(img==null){
        return;
      }else{
        rImagesList[index]=File(img.path);
      }
    }catch(e){
      Fluttertoast.showToast(msg: e.toString());

    }
  }



  uploadImages() async {
    rImagesLinks.clear();
    User? currentUser = FirebaseAuth.instance.currentUser;
    var uid = currentUser?.uid ?? "guest";

    for (var item in rImagesList) {
      if (item != null) {
        var filename = basename(item.path);
        var destination = 'images/needy_person/$uid/$filename';
        Reference ref = FirebaseStorage.instance.ref().child(destination);
        await ref.putFile(item);
        var downloadUrl = await ref.getDownloadURL();
        rImagesLinks.add(downloadUrl);
        //print("Image uploaded: $downloadUrl");

      }
    }
  }

  uploadProducts(context) async {
    try {
      isloading(true);
      await uploadImages(); // Step 1: upload images first

      var store = fireFirestore.collection('donation_compaigns').doc(); // Step 2: create doc reference
      await store.set({
        'days_left': rDaysController.text,
        'full_description': rLongDesController.text,
        'need_amount': rAmountController.text,
        'needy_name': rNameController.text,
        'short_description': rShortDesController.text,
        'title': rTitleController.text,
        'image': rImagesLinks,
        'created_at': DateTime.now(),
      });

      await saveNotificationToFirestore(store.id); // Step 3 & 4

      isloading(false);
      Fluttertoast.showToast(msg: registered_Successfully);
    } catch (e) {
      isloading(false);
      Fluttertoast.showToast(msg: "Error: $e");
    }
  }


/*  uploadProducts(context) async {
    try {
      var store = fireFirestore.collection('donation_compaigns').doc();
      await store.set({
        'days_left': rDaysController.text,
        'full_description': rLongDesController.text,
        'need_amount': rAmountController.text,
        'needy_name': rNameController.text,
        'short_description': rShortDesController.text,
        'title': rTitleController.text,
       // 'image': FieldValue.arrayUnion(rImagesLinks),
        'image':rImagesLinks,
      });
      isloading(false);
      Fluttertoast.showToast(msg: registered_Successfully);
    } catch (e) {
      isloading(false);
      Fluttertoast.showToast(msg: "Error: $e");
     // print("Upload error: $e");
    }
  }*/
/*  Future<void> saveNotificationToFirestore() async {
    try {
      await FirebaseFirestore.instance.collection('notifications').add({
        'title': rTitleController.text,
        'short_description': rShortDesController.text,
        'time': DateTime.now(),
        'status': 'approved', // You can use pending/approved/etc.
        'isRead': false,

      });
    } catch (e) {
      debugPrint('Error saving notification: $e');
    }
  }*/

  Future<void> saveNotificationToFirestore(String campaignId) async {
    try {
      await FirebaseFirestore.instance.collection('notifications').add({
        'title': rTitleController.text,
        'subtitle': rShortDesController.text,
        'time': DateTime.now(),
        'status': 'approved',
        'isRead': false,
        'donationId': campaignId, // ✅ VERY IMPORTANT
      });
    } catch (e) {
      debugPrint('Error saving notification: $e');
    }
  }



}