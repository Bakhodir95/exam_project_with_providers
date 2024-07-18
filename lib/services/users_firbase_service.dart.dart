import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

class UserFirerbaseService with ChangeNotifier {
  final _userCollection = FirebaseFirestore.instance.collection('users');
  final _fireStorage = FirebaseStorage.instance.ref();
  final _auth = FirebaseAuth.instance;
  Stream<QuerySnapshot> getUsers() async* {
    yield* _userCollection.snapshots();
  }

  addUser(
      {required String name,
      required String surname,
      required String email,
      required String id,
      String? imageUrl,
      required File file}) async {
    final _getImage = _fireStorage.child(UniqueKey().toString());
    final _data = await _getImage.putFile(file);
    final url = await _getImage.getDownloadURL();
    Map<String, dynamic> data = {
      'user-name': name,
      'user-surname': surname,
      'user-email': email,
      'user-imageUrl': url,
      'user-id': id
    };
    await _userCollection.doc(id).set(data);
  }
}
