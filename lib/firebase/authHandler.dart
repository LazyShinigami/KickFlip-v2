import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kickflip/models.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;
  final _store = FirebaseFirestore.instance.collection('UsersDB');

  // function to generate UID - used while signing up a user
  int generateUID() {
    Random random = Random();
    String number = '';
    for (int i = 0; i < 10; i++) {
      number += random.nextInt(10).toString();
    }
    return int.parse(number);
  }

  // MyUser stream - used directly in root file
  Stream<User?> get userStream {
    var result = _auth.authStateChanges();
    print('RESULT IN FIREBASE FUNC: ${result.first}');
    return result;

    // await for (var user in result) {
    //   if (user != null) {
    //     // Wait for getOtherUserDetails() to complete before continuing
    //     Map deets = await getOtherUserDetails(user.email!);
    //     // print(deets);
    //     yield KFUser(
    //       email: user.email!,
    //       type: deets['type'],
    //       name: deets['name'],
    //       uID: deets['uID'],
    //     );
    //   }
    // }
  }

  // Auxiliary function to fetch all of a user's details from firestore
  Future<KFUser> getUserDetails(String email) async {
    var x = await _store.doc(email).get();
    KFUser user = KFUser(
        uID: x.data()!['uID'],
        name: x.data()!['name'],
        email: email,
        type: x.data()!['type']);
    return user;
  }

  // create acc - email, pwd, name, type
  Future<String> signUpWithUserCredentials({
    required String name,
    required String type,
    required String email,
    required String password,
  }) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      await _store.doc(email).set({
        'name': name,
        'pwd': password,
        'email': email,
        'type': type,
        'uID': generateUID(),
      });
      return '';
    } on FirebaseAuthException catch (e) {
      return e.message.toString();
    }
  }

  // sign in - email, pwd, type
  Future signInWithEmailAndPassword({String? email, String? password}) async {
    try {
      return await _auth.signInWithEmailAndPassword(
          email: email!, password: password!);
    } on FirebaseAuthException catch (e) {
      return e.message.toString();
    }
  }

  // edit details

  // reset pwd
  Future resetPassword({required String email}) async {
    try {
      return await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      return e.message.toString();
    }
  }

  // get all user data - if acc exists

  // logout

  Future logout() async {
    _auth.signOut();
  }

  // delete acc
  Future deleteAcc() async {
    final user = FirebaseAuth.instance.currentUser;
    await user?.delete();
  }
}
