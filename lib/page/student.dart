import 'package:cloud_firestore/cloud_firestore.dart';

class TodoModel {
  String id;
  String correlation;
  String name;
  String age;
  String birthdate;
  String address;
  String contactNum;

  TodoModel({
    required this.id,
    required this.correlation,
    required this.name,
    required this.age,
    required this.birthdate,
    required this.contactNum,
    required this.address,
  });

  factory TodoModel.fromJson(DocumentSnapshot snapshot) {
    return TodoModel(
      id: snapshot.id,
      correlation: snapshot['correlation'],
      name: snapshot['name'],
      age: snapshot['age'],
      birthdate: snapshot['birthdate'],
      contactNum: snapshot['contactNum'],
      address: snapshot['address'],
    );
  }
}
