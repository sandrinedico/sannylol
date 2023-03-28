import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future insertTodo(
    String correlation,
    String name,
    String age,
    String birthdate,
    String contactNum,
    String address,
  ) async {
    try {
      await firestore.collection('todo').add({
        'idNum': correlation,
        'name': name,
        'birthdate': age,
        'course': birthdate,
        'section': contactNum,
        'address': address,
      });
    } catch (e) {
      print(e);
    }
  }

  Future insertUsers(String email, String userId) async {
    try {
      await firestore
          .collection('users')
          .add({'email': email, 'userId': userId});
    } catch (e) {
      print(e);
    }
  }

  Future updateTodo(
    String docId,
    String correlation,
    String name,
    String age,
    String birthdate,
    String contactNum,
    String address,
  ) async {
    try {
      await firestore.collection('todo').doc(docId).update({
        'idNum': correlation,
        'name': name,
        'birthdate': age,
        'course': birthdate,
        'section': contactNum,
        'address': address,
      });
    } catch (e) {
      print(e);
    }
  }

  Future deleteTodo(String docId) async {
    try {
      await firestore.collection('todo').doc(docId).delete();
    } catch (e) {
      print(e);
    }
  }
}
