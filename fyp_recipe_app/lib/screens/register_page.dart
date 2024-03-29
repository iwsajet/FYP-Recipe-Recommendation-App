import 'package:flutter/material.dart';
import 'package:fyp_recipe_app/custom_widget/top_bar.dart';
import 'package:fyp_recipe_app/provider/signup_provider.dart';
import 'package:fyp_recipe_app/screens/login_page.dart';
import 'package:provider/provider.dart';
import '../app_properties.dart';
import 'package:form_field_validator/form_field_validator.dart';
import '../network/api_response.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final TextEditingController _fullnameController;
  late final TextEditingController _usernameController;
  late final TextEditingController _confirmpwController;
  var _isObscured;
  late final SignUpProvider signUpProvider;

  void signUpListner() {
    if (signUpProvider.apiResponse.status == Status.error) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(signUpProvider.apiResponse.error.toString())));
    } else if (signUpProvider.apiResponse.status == Status.success) {
      Navigator.of(context).pop();
    }
  }

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _fullnameController = TextEditingController();
    _usernameController = TextEditingController();
    _confirmpwController = TextEditingController();
    _isObscured = true;
    signUpProvider = context.read<SignUpProvider>();
    signUpProvider.addListener(signUpListner);
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _fullnameController.dispose();
    _usernameController.dispose();
   // signUpProvider.dispose();
   signUpProvider.removeListener(signUpListner);

    super.dispose();
  }

  bool passwordConfirmed() {
    if (_passwordController.text == _confirmpwController.text) {
      return true;
    } else {
      return false;
    }
  }

  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                const TopBar(
                  title: "SignUp Here.",
                ),
                Container(
                  padding: const EdgeInsets.all(30),
                  margin: const EdgeInsets.only(
                      top: 120, left: AppSizes.s20, right: AppSizes.s20),
                  height: MediaQuery.of(context).size.height / 1.3,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30)),
                  child: Form(
                    autovalidateMode: AutovalidateMode.always,
                    key: formkey,
                    child: Column(
                      children: [
                        const Text(
                          "Register",
                          style: TextStyle(
                            color: AppColor.textColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        TextFormField(
                          controller: _fullnameController,
                          decoration: const InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 2, color: AppColor.secondary)),
                              labelText: 'Full Name',
                              hintText: 'Enter Full Name'),
                        ),
                 
                        TextFormField(
                          controller: _emailController,
                          decoration: const InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 2, color: AppColor.secondary)),
                              labelText: 'Email',
                              hintText:
                                  'Enter valid email id as abc@gmail.com'),
                          validator: MultiValidator([
                            RequiredValidator(errorText: "Required"),
                            EmailValidator(errorText: "Not a Valid Email"),
                          ]),
                        ),
                        TextFormField(
                          controller: _passwordController,
                          obscureText: _isObscured,
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
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Required";
                            } else {
                              return null;
                            }
                          },
                        ),
                    
                        const SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              fixedSize: const Size(300, 50)),
                          child: const Text("Register"),
                          onPressed: () async {
                            context.read<SignUpProvider>().signUp(
                                email: _emailController.text,
                                password: _passwordController.text,
                                fullname: _fullnameController.text);
                          },
                        
                        ),
                        Container(
                          padding: const EdgeInsets.all(10),
                          child: TextButton(
                            child: const Text("Already Registered? Login Now."),
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => const LoginPage(),
                                ),
                              );
                            },
                          ),
                        )
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
