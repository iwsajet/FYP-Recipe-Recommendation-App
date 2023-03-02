
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fyp_recipe_app/screens/login_page.dart';


class FirebaseAuthMethod {
  late final FirebaseAuth _firebaseAuth;
  FirebaseAuthMethod(this._firebaseAuth);
  
  Future<void> signUpWithEmail({
    required String fullname,
    required String email,
    required String password,
    required String username,
    required BuildContext context,
  }) async {
    
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await sendEmailVerification(context);
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) {
        return const LoginPage();
      }), (route) => false);
      final users = <String, dynamic>{
         'Full Name': fullname,
        'username': username,
        'email': email,
        'password': password
      };
      
      FirebaseFirestore.instance
          .collection('users')
          .doc()
          .set(users)
          .onError((e, _) => print("Error writing document: $e"));
          
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> sendEmailVerification(BuildContext context) async {
    try {
      _firebaseAuth.currentUser!.sendEmailVerification();
      showSnackBar(context, 'Email verification sent!');
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!);
    }
  }
}

void showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
}
