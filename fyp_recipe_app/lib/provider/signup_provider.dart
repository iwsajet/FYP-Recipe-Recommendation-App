import 'dart:convert';
import 'package:flutter/material.dart';
 import 'package:http/http.dart' as http;

import '../screens/login_page.dart';

class SignupProvider with ChangeNotifier{
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
   TextEditingController fullnameController = TextEditingController();

  Future signUP(BuildContext context) async {
    const url = "http://192.168.1.11:3000/signUp";
    final email = emailController.text;
    final password = passwordController.text;
    final fullname = fullnameController.text;
    final body = jsonEncode({
      'email': email,
      'password': password,
      'fullname': fullname,
    });
    final response = await http.post(Uri.parse(url),
        headers: {'Content-Type': 'application/json'}, body: body);
    debugPrint(response.body);
    if (response.statusCode == 200) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: const Text("Sucess"),
                content: const Text("Your account has been created"),
                actions: [
                  TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text("Ok"))
                ],
              ));
    } else if (response.statusCode == 409) {
      final message = jsonDecode(response.body)['message'];
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: const Text("Error"),
                content: Text(message),
                actions: [
                  TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text("Ok"))
                ],
              ));
    } else {
      final message = jsonDecode(response.body)['message'];
      print('Error occurred: $message');
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Error"),
          content: Text(message),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Ok"))
          ],
        ),
      );
    }
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const LoginPage()));
  }
}
 
 