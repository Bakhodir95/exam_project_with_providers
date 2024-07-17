import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String id;
  String deviceId;
  String name;
  String surname;
  String email;
  String? imageUrl;

  User(
      {required this.id,
      required this.deviceId,
      required this.name,
      required this.surname,
      required this.email,
      required this.imageUrl});

  factory User.fromMap(QueryDocumentSnapshot query) {
    return User(
      id: query.id,
      name: query['user-name'],
      deviceId: query['user-deviceId'],
      email: query['user-email'],
      surname: query['user-surname'],
      imageUrl: query['user-imageUrl'],
    );
  }
}
