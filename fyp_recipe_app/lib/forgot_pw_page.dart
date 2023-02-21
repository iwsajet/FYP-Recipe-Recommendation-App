import 'package:flutter/material.dart';

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
    _passwordController = TextEditingController();
    _confirmpwController = TextEditingController();
    _isObscured = true;
    super.initState();
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
                  ),
                ),
                Container(
                  child: TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _isObscured = !_isObscured;
                              });
                            },
                            icon: _isObscured
                                ? const Icon(Icons.visibility)
                                : const Icon(Icons.visibility_off)),
                        enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                                width: 2, color: AppColor.secondary)),
                        labelText: 'Password',
                        hintText: 'Enter strong password'),
                  ),
                ),
                Container(
                  child: TextFormField(
                    controller: _confirmpwController,
                    decoration: InputDecoration(
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _isObscured = !_isObscured;
                              });
                            },
                            icon: _isObscured
                                ? const Icon(Icons.visibility)
                                : const Icon(Icons.visibility_off)),
                        enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                                width: 2, color: AppColor.secondary)),
                        labelText: 'Confirm Password',
                        hintText: 'Confirm Password'),
                  ),
                ),
                Container(
                  child: ElevatedButton(
                    child: const Text("Change Password"),
                    onPressed: () {},
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
