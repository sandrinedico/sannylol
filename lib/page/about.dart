import 'package:flutter/material.dart';

class AboutApp extends StatefulWidget {
  const AboutApp({Key? key}) : super(key: key);

  @override
  State<AboutApp> createState() => _AboutAppState();
}

class _AboutAppState extends State<AboutApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "About InforDent",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/icon/icon_launcher.png'),
                ),
              ),
              alignment: Alignment.topCenter,
              height: 300,
              width: 400,
            ),
            ListTile(
              title: Text(
                "InforDent",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            ListTile(
              title: Text(
                "The InforDent is a mobile application designed to provide a user-friendly interface for managing and viewing information about students. The application allows users to store and access various types of data related to students, such as their name, ID number, address, contact information, and any other relevant information. ",
                style: TextStyle(
                  fontSize: 18,
                ),
                textAlign: TextAlign.justify,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
