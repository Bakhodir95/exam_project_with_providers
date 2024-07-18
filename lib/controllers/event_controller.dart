import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exam_project_with_providers/models/event.dart';
import 'package:flutter/material.dart';

class EventController with ChangeNotifier {
  final _eventFirebase = FirebaseFirestore.instance.collection("events");

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

  // getAllEvents() async {

  // }
}
