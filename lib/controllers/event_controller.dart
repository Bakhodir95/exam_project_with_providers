import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exam_project_with_providers/models/event.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class EventController with ChangeNotifier {
  final _eventFirebase = FirebaseFirestore.instance.collection("events");
  static final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  File? file;
  Stream<QuerySnapshot> getEvents() async* {
    yield* _eventFirebase.snapshots();
  }

  Future<void> addEvent(Event event) async {
    // Unikalniy id yaratish
    DocumentReference docRef = _eventFirebase.doc();
    event.id = docRef.id;

    // Firestorega saqlash
    await docRef.set(event.toMap());
  }

  static Future<String?> uploadImage(File imageFile, String path) async {
    try {
      Reference storageReference = _firebaseStorage.ref().child('$path.jpg');

      UploadTask uploadTask = storageReference.putFile(imageFile);
      TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => {});

      String downloadURL = await taskSnapshot.ref.getDownloadURL();

      return downloadURL;
    } catch (e) {
      print("Error uploading image: $e");
      return null;
    }
  }

  Stream<QuerySnapshot<Object?>> getEventsWithinNextWeek() {
    DateTime now = DateTime.now();
    DateTime nextWeek = now.add(const Duration(days: 7));

    return _eventFirebase
        .where('event-date', isGreaterThanOrEqualTo: Timestamp.fromDate(now))
        .where('event-date', isLessThanOrEqualTo: Timestamp.fromDate(nextWeek))
        .orderBy('event-date')
        .snapshots();
  }

  Future<void> delete(String eventId) async {
    await _eventFirebase.doc(eventId).delete();
  }
}
