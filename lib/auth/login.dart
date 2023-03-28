import 'package:firebase_auth/firebase_auth.dart';
import 'package:lol/auth/register.dart';
import 'package:lol/page/navigation.dart';
import 'package:lol/auth/auth_service.dart';
import 'package:lol/home_page.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool passwordVisible = true;
  final formKey = GlobalKey<FormState>();

  bool loading = false;

  @override
  void initState() {
    super.initState();
    passwordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.pink.shade50,
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
                          image: AssetImage('asset/image/EmergencyLogo.png')),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Emergency Details',
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
                                return 'Input your email.';
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
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Input your password.';
                            } else {
                              return null;
                            }
                          },
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
                        Icons.login_outlined,
                        size: 20,
                        color: Colors.black54,
                      ),
                      label: const Text(
                        'Login',
                        style: TextStyle(fontSize: 20, color: Colors.black),
                      ),
                      onPressed: () async {
                        setState(() {
                          loading = true;
                        });
                        if (emailController.text == "" ||
                            passwordController == "") {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text("All fields are required!"),
                            backgroundColor: Colors.red,
                          ));
                        } else {
                          User? result = await Authentication().login(
                              emailController.text,
                              passwordController.text,
                              context);
                          if (result != null) {
                            print("Logged In");
                            print(result.email);
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomePage(result)),
                                (route) => false);
                          }
                        }
                        setState(() {
                          loading = false;
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Not Registered? '),
                      InkWell(
                        onTap: () {
                          context.to(const RegisterPage());
                        },
                        child: const Text(
                          'Create an account',
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
