import 'package:flutter/material.dart';

import 'app_properties.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(
            color: Colors.white,
          ),
        ),
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
              child: Column(
            children: [
              Container(
                // alignment: Alignment.center,
                child: const Text(
                  "Register",
                  style: TextStyle(
                    color: AppColor.textColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              Container(
                child: TextFormField(
                  decoration: const InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(width: 2, color: AppColor.secondary)),
                      labelText: 'Full Name',
                      hintText: 'Enter Full Name'),
                ),
              ),
              Container(
                child: TextFormField(
                  decoration: const InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(width: 2, color: AppColor.secondary)),
                      labelText: 'Username',
                      hintText: 'Enter valid username'),
                ),
              ),
              Container(
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
                child: TextFormField(
                  decoration: const InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(width: 2, color: AppColor.secondary)),
                      labelText: 'Password',
                      hintText: 'Enter strong password'),
                ),
              ),
              Container(
                child: TextFormField(
                  decoration: const InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(width: 2, color: AppColor.secondary)),
                      labelText: 'Confirm Password',
                      hintText: 'Confirm Password'),
                ),
              ),
              Container(
                child: ElevatedButton(
                  child: const Text("Register"),
                  onPressed: () {},
                ),
              ),
            ],
          )),
        )));
  }
}
