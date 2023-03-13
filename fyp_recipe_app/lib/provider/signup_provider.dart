import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fyp_recipe_app/network/api_response.dart';
import 'package:http/http.dart' as http;

import '../screens/login_page.dart';
import '../services/auth_service.dart';

// class SignupProvider with ChangeNotifier{
//   TextEditingController emailController = TextEditingController();
//   TextEditingController passwordController = TextEditingController();
//    TextEditingController fullnameController = TextEditingController();

//   Future signUP(BuildContext context) async {
//     const url = "http://192.168.1.11:3000/signUp";
//     final email = emailController.text;
//     final password = passwordController.text;
//     final fullname = fullnameController.text;
//     final body = jsonEncode({
//       'email': email,
//       'password': password,
//       'fullname': fullname,
//     });
//     final response = await http.post(Uri.parse(url),
//         headers: {'Content-Type': 'application/json'}, body: body);
//     debugPrint(response.body);
//     if (response.statusCode == 200) {
//       showDialog(
//           context: context,
//           builder: (context) => AlertDialog(
//                 title: const Text("Sucess"),
//                 content: const Text("Your account has been created"),
//                 actions: [
//                   TextButton(
//                       onPressed: () => Navigator.pop(context),
//                       child: const Text("Ok"))
//                 ],
//               ));
//     } else if (response.statusCode == 409) {
//       final message = jsonDecode(response.body)['message'];
//       showDialog(
//           context: context,
//           builder: (context) => AlertDialog(
//                 title: const Text("Error"),
//                 content: Text(message),
//                 actions: [
//                   TextButton(
//                       onPressed: () => Navigator.pop(context),
//                       child: const Text("Ok"))
//                 ],
//               ));
//     } else {
//       final message = jsonDecode(response.body)['message'];
//       print('Error occurred: $message');
//       showDialog(
//         context: context,
//         builder: (context) => AlertDialog(
//           title: const Text("Error"),
//           content: Text(message),
//           actions: [
//             TextButton(
//                 onPressed: () => Navigator.pop(context),
//                 child: const Text("Ok"))
//           ],
//         ),
//       );
//     }
//     Navigator.push(
//         context, MaterialPageRoute(builder: (context) => const LoginPage()));
//   }
// }

class SignUpProvider with ChangeNotifier {
  late final AuthService _authService;

  SignUpProvider({required AuthService authService}) {
    _authService = authService;
  }

  ApiResponse<void> apiResponse = ApiResponse.loading();

  Future<void> signUp({
    required String email,
    required String password,
  }) async {
    try {
      await _authService.signUp(
        email: email,
        password: password,
      );

      apiResponse = ApiResponse.success(null);
      notifyListeners();
    } catch (e) {
      apiResponse = ApiResponse.error(e.toString());
      notifyListeners();
    }
  }
}
