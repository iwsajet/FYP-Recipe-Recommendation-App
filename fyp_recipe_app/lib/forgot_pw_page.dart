import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

import 'app_properties.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final TextEditingController _confirmpwController;
  var _isObscured;

  @override
  void initState() {
    _emailController = TextEditingController();

    _isObscured = true;
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();

    super.dispose();
  }

  Future passwordReset() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: _emailController.text);
          showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            content: Text(
              "Password reset email has been sent to your email, Please check."
            ),
          );
        },
      );
    } on FirebaseAuthException catch (e) {
      print(e);
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text(
              e.message.toString(),
            ),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(right: 60),
          margin: const EdgeInsets.all(20),
          height: MediaQuery.of(context).size.height / 2,
          width: MediaQuery.of(context).size.height / 2,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.white70,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Form(
            child: Column(
              children: [
                Container(
                  // alignment: Alignment.center,
                  child: const Text(
                    "Forgot Password",
                    style: TextStyle(
                      color: AppColor.textColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  child: TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                width: 2, color: AppColor.secondary)),
                        labelText: 'Email',
                        hintText: 'Enter valid email id as abc@gmail.com'),
                    validator: MultiValidator([
                      RequiredValidator(errorText: "Required"),
                      EmailValidator(errorText: "Not a Valid Email"),
                    ]),
                  ),
                ),
                Container(
                  child: ElevatedButton(
                    child: const Text("Reset Password"),
                    onPressed: passwordReset,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
