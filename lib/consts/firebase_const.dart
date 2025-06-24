import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

FirebaseAuth auth=FirebaseAuth.instance;




FirebaseFirestore fireFirestore=FirebaseFirestore.instance;


//get all user data
User? currentUser =auth.currentUser;
//collections
const userCollection='users';
