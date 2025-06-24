import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class AuthController extends GetxController {
  var isloading = false.obs;

  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  // ✅ Login Method
  Future<UserCredential?> loginMethod({required BuildContext context}) async {
    UserCredential? userCredential;
    try {
      userCredential = await auth.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      print("LOGIN: user ID = ${userCredential.user?.uid}");
    } on FirebaseAuthException catch (e) {
      print("LOGIN ERROR: ${e.message}");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message ?? "Login failed")),
      );
    }
    return userCredential;
  }

  // ✅ Signup Method (Fixed with logging)
  Future<UserCredential?> signupMethod({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      print("SIGNUP: User created = ${userCredential.user?.uid}");

      if (userCredential.user == null) {
        throw FirebaseAuthException(
            code: 'null-user', message: "User is null after signup");
      }

      return userCredential;
    } on FirebaseAuthException catch (e) {
      print("SIGNUP ERROR: ${e.message}");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message ?? "Signup failed")),
      );
    } catch (e) {
      print("SIGNUP EXCEPTION: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Unexpected error: $e")),
      );
    }
    return null;
  }

  // ✅ Store User Data
  Future<void> storeUserData(String name, String password, String email) async {
    User? currentUser = auth.currentUser;

    print("STORE USER: current user = ${currentUser?.uid}");

    if (currentUser != null) {
      await firestore.collection("users").doc(currentUser.uid).set({
        'name': name,
        'password': password,
        'email': email,
        'imageUrl': '',
        'id': currentUser.uid,
        'cart_count': "00",
        'wishlist_count': "00",
        'order_count': "00",
      });
      print("STORE USER: Data saved for ${currentUser.uid}");
    } else {
      throw Exception("User is null while storing data");
    }
  }
}
