import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import '../consts/consts.dart';
import '../consts/firebase_const.dart';

class EventsRegisterController extends GetxController{

  var isloading=false.obs;

  var titleController=TextEditingController();
  var desController=TextEditingController();


  var rImagesLinks=[];// it imgs links
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
        var destination = 'images/events/$uid/$filename';
        Reference ref = FirebaseStorage.instance.ref().child(destination);
        await ref.putFile(item);
        var downloadUrl = await ref.getDownloadURL();
        rImagesLinks.add(downloadUrl);


      }
    }
  }
  uploadProducts(context) async {
    try {
      var store = fireFirestore.collection('events').doc();
      await store.set({
        'title': titleController.text,
        'des': desController.text,
        'images': rImagesLinks,
        'created_at': FieldValue.serverTimestamp(), // Firestore server time
        'created_date': DateFormat('dd MMMM yyyy').format(DateTime.now()), // Human-readable date
      });

      isloading(false);
      Fluttertoast.showToast(msg: registered_Successfully);
    } catch (e) {
      isloading(false);
      Fluttertoast.showToast(msg: "Error: $e");

    }
  }



}