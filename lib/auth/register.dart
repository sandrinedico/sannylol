import 'package:firebase_auth/firebase_auth.dart';
import 'package:lol/home_page.dart';
import 'package:lol/page/navigation.dart';
import 'package:lol/auth/auth_service.dart';
import 'login.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  bool passwordVisible = true;
  bool confirmPasswordVisible = true;

  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    passwordVisible = false;
    confirmPasswordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue.shade200,
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.fromLTRB(0, 40, 0, 10),
                    child: SizedBox(
                      height: 200,
                      child: Image(
                        image: AssetImage('assets/icon/studentlogo.png'),
                      ),
                    ),
                  ),
                  const Text(
                    'Welcome!',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 40,
                        color: Colors.black),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: TextFormField(
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            decoration: const InputDecoration(
                                labelText: 'Email',
                                border: InputBorder.none,
                                icon: Icon(Icons.alternate_email_outlined)),
                            validator: (email) {
                              if (email!.isEmpty ||
                                  !RegExp(r'[a-z0-9]+@[a-z]+\.[a-z]{2,3}')
                                      .hasMatch(email)) {
                                return 'Please enter valid email.';
                              } else {
                                return null;
                              }
                            }),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: TextFormField(
                          controller: passwordController,
                          obscureText: !passwordVisible,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            border: InputBorder.none,
                            icon: const Icon(Icons.key_outlined),
                            suffixIcon: IconButton(
                              icon: Icon(
                                  passwordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.grey),
                              onPressed: () {
                                setState(() {
                                  passwordVisible = !passwordVisible;
                                });
                              },
                            ),
                          ),
                          validator: (val) => val!.length < 6
                              ? 'Required at least 6 characters.'
                              : null,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: TextFormField(
                          controller: confirmPasswordController,
                          obscureText: !confirmPasswordVisible,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.done,
                          decoration: InputDecoration(
                            labelText: 'Confirm Password',
                            border: InputBorder.none,
                            icon: const Icon(Icons.key_outlined),
                            suffixIcon: IconButton(
                              icon: Icon(
                                  confirmPasswordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.grey),
                              onPressed: () {
                                setState(() {
                                  confirmPasswordVisible =
                                      !confirmPasswordVisible;
                                });
                              },
                            ),
                          ),
                          validator: (val) => val != passwordController.text
                              ? 'Confirm Password does not match.'
                              : val!.length < 6
                                  ? 'Required at least 6 characters.'
                                  : null,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 110.0),
                      child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                              minimumSize: const Size.fromHeight(50),
                              backgroundColor: Colors.blueAccent,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20))),
                          icon: const Icon(
                            Icons.app_registration_outlined,
                            size: 20,
                            color: Colors.black54,
                          ),
                          label: const Text(
                            'Register',
                            style: TextStyle(fontSize: 20, color: Colors.black),
                          ),
                          onPressed: () async {
                            if (emailController.text == "" ||
                                passwordController.text == "") {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('All fields are required.'),
                                      backgroundColor: Colors.red));
                            } else if (passwordController.text !=
                                confirmPasswordController.text) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text("Passwords don't match."),
                                      backgroundColor: Colors.red));
                            } else {
                              User? result = await Authentication().register(
                                emailController.text,
                                passwordController.text,
                                context,
                              );
                              if (result != null) {
                                print("Registered");
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => HomePage(result)),
                                    (route) => false);
                              }
                            }
                          })),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Already have an account? '),
                      InkWell(
                        onTap: () {
                          context.to(const LoginPage());
                        },
                        child: const Text(
                          'Login',
                          style:
                              TextStyle(decoration: TextDecoration.underline),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
