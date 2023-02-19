import 'package:flutter/material.dart';
import 'package:fyp_recipe_app/app_properties.dart';
import 'package:fyp_recipe_app/forgot_pw_page.dart';
import 'package:fyp_recipe_app/register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
            color: Colors.white70, borderRadius: BorderRadius.circular(30)),
        child: Form(
            child: Column(children: <Widget>[
          Container(
            // alignment: Alignment.center,
            child: const Text(
              "Login",
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
              decoration: const InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(width: 2, color: AppColor.secondary)),
                  labelText: 'Email',
                  hintText: 'Enter valid email id as abc@gmail.com'),
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: TextFormField(
              decoration: const InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(width: 2, color: AppColor.secondary)),
                  labelText: 'Password',
                  hintText: 'Enter secure password'),
            ),
          ),
          Container(
            child: ElevatedButton(
              child: Text("Login"),
              onPressed: () {},
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ForgotPassword(),
                ),
              );
            },
            child: const Text("Forgot Password"),
          ),
          const Text("Dont have an account?"),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const RegisterPage(),
                ),
              );
            },
            child: const Text("Register Here."),
          ),
        ])),
      )),
    );
  }
}
