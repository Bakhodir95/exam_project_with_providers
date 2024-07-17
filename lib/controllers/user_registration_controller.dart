import 'dart:io';

import 'package:exam_project_with_providers/services/users_firbase_service.dart.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserRegistrationController with ChangeNotifier {
  String _email = '';
  String _name = '';
  String _surname = '';
  String _imageUrl = "";

  String get email => _email;
  String get name => _name;
  String get surname => _surname;
  String get imageUrl => _imageUrl;

  final fireAuth = FirebaseAuth.instance;
  final userService = UserFirerbaseService();

  Future<void> saveUsersInfo() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    _email = pref.getString('email') ?? " No Email";
    _name = pref.getString('name') ?? " No Name";
    _surname = pref.getString('surname') ?? " No Surname";
    _imageUrl = pref.getString('imageUrl') ?? " No imageUrl";
  }

  Future<void> updateUsersInfo(String newEmail, String newName,
      String newSurname, File? newImageFIle) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString('email', newEmail);
    await pref.setString('name', newName);
    await pref.setString('surname', newSurname);

    String imageUrl = _imageUrl;
    if (newImageFIle != null) {
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('user_images')
          .child('$newEmail.jpg');
      await storageRef.putFile(newImageFIle);
      imageUrl = await storageRef.getDownloadURL();
      await pref.setString('userImageUrl', imageUrl);
    }

    _email = newEmail;
    _name = newName;
    _surname = newSurname;
    _imageUrl = imageUrl;
    notifyListeners();
  }

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
    } catch (e) {
      rethrow;
    }
  }
}
