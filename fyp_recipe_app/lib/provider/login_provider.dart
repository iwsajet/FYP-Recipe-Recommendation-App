import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../screens/home_page.dart';

class LoginProvider with ChangeNotifier{
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  Future logIn(BuildContext context) async {
    const url = "http://192.168.1.11:3000/logIn";
    final email = emailController.text;
    final password = passwordController.text;
    final body = jsonEncode({
      'email': email,
      'password': password,
    });
    final response = await http.post(Uri.parse(url),
        headers: {'Content-Type': 'application/json'}, body: body);
    debugPrint(response.body);
    if (response.statusCode == 200) {
      final user = jsonDecode(response.body)['user'];
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: const Text("Success"),
                content: Text("Logged in as ${user['username']}"),
                actions: [
                  TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text("Ok"))
                ],
              ));
    } else if (response.statusCode == 401) {
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
    } else if (response.statusCode == 404) {
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
        context, MaterialPageRoute(builder: (context) => const HomePage()));
  }
  
}

