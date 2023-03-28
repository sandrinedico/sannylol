import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FirebaseUsers {
  String id;
  String name;
  String email;
  String userId;

  FirebaseUsers(
      {required this.id,
      required this.name,
      required this.email,
      required this.userId});

  factory FirebaseUsers.fromJson(DocumentSnapshot snapshot) {
    return FirebaseUsers(
      id: snapshot.id,
      email: snapshot['email'],
      name: snapshot['name'],
      userId: snapshot['userId'],
    );
  }
}
