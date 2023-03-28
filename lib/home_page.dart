import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lol/auth/login.dart';
import 'page/navigation.dart';
import 'page/student.dart';
import 'firestore_service.dart';
import 'page/about.dart';
import 'page/details.dart';
import 'model/add.dart';

class HomePage extends StatefulWidget {
  User user;
  HomePage(this.user);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Emergency Information'),
        actions: [
          IconButton(
            color: Colors.black,
            onPressed: () async {
              await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AddUser(widget.user)));
            },
            icon: const Icon(
              Icons.add_circle_outline_sharp,
              size: 35,
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(color: Colors.blue),
              child: Column(
                children: <Widget>[
                  Flexible(
                    child: Container(
                      width: 100,
                      height: 100,
                      margin: const EdgeInsets.only(bottom: 5),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage(
                            'asset/image/EmergencyLogo.png',
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Text(
                    "${widget.user.email}",
                    style: const TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                  ),
                ],
              ),
            ),
            ListTile(
                leading:
                    const Icon(Icons.info_outline_rounded, color: Colors.black),
                title: const Text(
                  'About App',
                  style: TextStyle(color: Colors.black),
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const AboutApp()),
                  );
                }),
            ListTile(
                leading: const Icon(Icons.logout_rounded, color: Colors.black),
                title: const Text(
                  'Logout',
                  style: TextStyle(color: Colors.black),
                ),
                onTap: () {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()),
                      (route) => false);
                }),
            const AboutListTile(
              icon: Icon(Icons.help, color: Colors.black),
              applicationIcon: Icon(
                Icons.local_play,
                color: Colors.black,
              ),
              applicationName: 'Emergency Details',
              applicationVersion: '1.0.0',
              applicationLegalese: '© 2023 Sy Company',
              child: Text('About', style: TextStyle(color: Colors.black)),
            )
          ],
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
              Colors.pink.shade50,
              Colors.blue.shade100,
              Colors.green.shade50,
              Colors.white10
            ])),
        child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('todo')
                .where('userId', isEqualTo: widget.user.uid)
                .snapshots(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data.docs.length > 0) {
                  return ListView.builder(
                      padding: const EdgeInsets.all(7),
                      itemCount: snapshot.data.docs.length,
                      itemBuilder: (context, index) {
                        TodoModel todo =
                            TodoModel.fromJson(snapshot.data.docs[index]);
                        return Card(
                          elevation: 10,
                          shadowColor: Colors.blueAccent,
                          margin: const EdgeInsets.all(7),
                          child: ListTile(
                            leading: const Icon(Icons.account_box_rounded),
                            title: Text(todo.name),
                            subtitle: Text(todo.contactNum),
                            trailing: IconButton(
                                onPressed: () async {
                                  await showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return const AlertDialog(
                                          icon: Icon(
                                            Icons.delete_forever_rounded,
                                            color: Colors.black54,
                                            size: 100,
                                          ),
                                          iconColor: Colors.redAccent,
                                          title: Text("Delete"),
                                          content: Text(
                                              "Are you sure you want to delete this item?"),
                                        );
                                      });
                                },
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.black54,
                                )),
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      DetailsPage(UserDetails: todo)));
                            },
                          ),
                        );
                      });
                } else {
                  return const Center(child: Text("No List of Information"));
                }
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            }),
      ),
    );
  }
}
