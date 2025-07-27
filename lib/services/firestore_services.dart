
import 'package:charity_app/consts/firebase_const.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class FiretoreServices{

    /* static getUser(uid){
          return fireFirestore.collection(userCollection)
              .where('id',isEqualTo: uid).snapshots();
     }*/
     static Stream<DocumentSnapshot> getUser(String uid) {
          return fireFirestore.collection(userCollection).doc(uid).snapshots();
     }

}