import 'package:cloud_firestore/cloud_firestore.dart';

class UserFirerbaseService {
  final _userCollection = FirebaseFirestore.instance.collection('users');

  Stream<QuerySnapshot> getUsers() async* {
    yield* _userCollection.snapshots();
  }

  addUser(
      {required String name,
      required String surname,
      required String email,
      required String id,
      String? imageUrl}) async {
    Map<String, dynamic> data = {
      'user-name': name,
      'user-surname': surname,
      'user-email': email,
      'user-imageUrl': imageUrl,
    };
    await _userCollection.doc(id).set(data);
  }
}
