import 'package:flutter/material.dart';
import 'package:fyp_recipe_app/custom_widget/top_bar.dart';

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
      // appBar: AppBar(
      //   iconTheme: const IconThemeData(
      //     color: Colors.white,
      //   ),
      // ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                const TopBar(),
                Container(
                  padding: const EdgeInsets.all(30),
                  margin: const EdgeInsets.only(
                      top: 120, left: AppSizes.s20, right: AppSizes.s20),
                  height: MediaQuery.of(context).size.height / 1.8,
                  //width: MediaQuery.of(context).size.height / 2.5,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30)),
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
                                    borderSide: BorderSide(
                                        width: 2, color: AppColor.secondary)),
                                labelText: 'Full Name',
                                hintText: 'Enter Full Name'),
                          ),
                        ),
                        Container(
                          child: TextFormField(
                            decoration: const InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 2, color: AppColor.secondary)),
                                labelText: 'Username',
                                hintText: 'Enter valid username'),
                          ),
                        ),
                        Container(
                          child: TextFormField(
                            decoration: const InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 2, color: AppColor.secondary)),
                                labelText: 'Email',
                                hintText:
                                    'Enter valid email id as abc@gmail.com'),
                          ),
                        ),
                        Container(
                          child: TextFormField(
                            decoration: const InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 2, color: AppColor.secondary)),
                                labelText: 'Password',
                                hintText: 'Enter strong password'),
                          ),
                        ),
                        Container(
                          child: TextFormField(
                            decoration: const InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 2, color: AppColor.secondary)),
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
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
