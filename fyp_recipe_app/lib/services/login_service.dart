import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../home_page.dart';

class FirebaseSignInMethod {
  late final FirebaseAuth _firebaseAuth;
  FirebaseSignInMethod(this._firebaseAuth);
  Future<void> signInWithEmail({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => HomePage()),
          (route) => false);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Colors.red,
            content: Text("No user found for that email.")));
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.red,
            content: Text("Wrong password provided for that user."),
          ),
        );
      }
    }
  }
}
