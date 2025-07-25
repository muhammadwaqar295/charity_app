import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../consts/consts.dart';
import '../consts/firebase_const.dart';

class ProfileEditController extends GetxController{



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


  //login with old pass
  changeAuthPassword({email,password,newPassword})async{
    final cred=EmailAuthProvider.credential(email: email, password: password);
    //again login user
    await currentUser!.reauthenticateWithCredential(cred).then((value){

      //change pass
      currentUser!.updatePassword(newPassword);
    }).catchError((error){
      print(error..toString());
    });

  }


}