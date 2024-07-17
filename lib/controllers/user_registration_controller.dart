import 'package:exam_project_with_providers/services/users_firbase_service.dart.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserRegistrationController with ChangeNotifier {
  final fireAuth = FirebaseAuth.instance;
  final userService = UserFirerbaseService();

  login(String email, String password) async {
    try {
      await fireAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      rethrow;
    }
  }

  register({
    required String name,
    required String surname,
    required String email,
    required String password,
    required String? imageUrl,
  }) async {
    try {
      // print(email);
      // print(password);
      final userdata = await fireAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await userService.addUser(
        name: name,
        surname: surname,
        email: email,
        imageUrl: imageUrl,
        id: userdata.user!.uid,
      );
      print("passwoerrd3defdercvr4c");
    } catch (e) {
      rethrow;
    }
  }
}
