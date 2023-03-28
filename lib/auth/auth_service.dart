import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lol/page/instructor.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Authentication {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  FirebaseUsers? _firebaseUser(User? user) {
    return user != null
        ? FirebaseUsers(id: user.uid, email: '', name: '', userId: '')
        : null;
  }

  Stream<FirebaseUsers?> get user {
    return auth.authStateChanges().map(_firebaseUser);
  }

  Future login(email, password, BuildContext context) async {
    try {
      User userCred = (await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      )) as User;
      _firebaseUser(userCred);
      debugPrint("Signed in as: $User ");
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        print(e);
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future register(email, password, BuildContext context) async {
    try {
      UserCredential userCred = (await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      ));
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCred.user!.uid)
          .set({'name': email, 'email': email});
      _firebaseUser(userCred.user!);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        if (kDebugMode) {
          print('The password provided is too weak.');
        }
      } else if (e.code == 'email-already-in-use') {
        if (kDebugMode) {
          print('The account already exists for that email.');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future logout() async {
    try {
      await googleSignIn.disconnect().whenComplete(() async {
        await auth.signOut();
      });
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return null;
    }
  }

  Future<void> signInWithGoogle() async {
    final googleAccount = await googleSignIn.signIn();
    if (googleAccount != null) {
      final googleAuth = await googleAccount.authentication;
      if (googleAuth.accessToken != null && googleAuth.idToken != null) {
        try {
          UserCredential googleUser = await auth.signInWithCredential(
              GoogleAuthProvider.credential(
                  idToken: googleAuth.idToken,
                  accessToken: googleAuth.accessToken));
          _firebaseUser(googleUser.user);
        } on FirebaseAuthException catch (error) {
          if (kDebugMode) {
            print(error);
          }
        } catch (error) {
          if (kDebugMode) {
            print(error);
          }
        } finally {}
      }
    }
  }
}
