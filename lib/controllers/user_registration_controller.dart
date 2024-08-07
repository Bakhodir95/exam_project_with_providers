import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exam_project_with_providers/models/user.dart';
import 'package:exam_project_with_providers/services/users_firbase_service.dart.dart';
import 'package:firebase_auth/firebase_auth.dart' as ath;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserRegistrationController with ChangeNotifier {
  User? user;
  String _email = '';
  String _name = '';
  String _surname = '';
  String _imageUrl = "";

  String get email => _email;
  String get name => _name;
  String get surname => _surname;
  String get imageUrl => _imageUrl;

  final fireAuth = ath.FirebaseAuth.instance;
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

  static Future<User> getUser(String userId) async {
    final _getUSer =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();
    return User(
        id: _getUSer.id,
        email: _getUSer.data()?["user-email"],
        deviceId: _getUSer.data()?["user-deviceId"] ?? "nodevise",
        name: _getUSer.data()?["user-name"],
        surname: _getUSer.data()?['user-surname'],
        imageUrl: _getUSer.data()?['user-imageUrl']);
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
    required File file,
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
        file: file,
      );
    } catch (e) {
      rethrow;
    }
  }
}
