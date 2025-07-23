import 'package:charity_app/consts/consts.dart';
import 'package:charity_app/consts/firebase_const.dart';


class FiretoreServices{

     static getUser(uid){
          return fireFirestore.collection(userCollection)
              .where('id',isEqualTo: uid).snapshots();
     }

}