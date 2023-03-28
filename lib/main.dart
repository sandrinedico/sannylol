import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:lol/auth/register.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Emergency Details',
      theme: ThemeData(
          primarySwatch: Colors.blueGrey,
          scaffoldBackgroundColor: const Color(0xFF323232)),
      home: const RegisterPage(),
    );
  }
}
