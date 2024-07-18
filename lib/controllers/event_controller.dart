import 'package:cloud_firestore/cloud_firestore.dart';

class EventController {
  final _eventFirebase = FirebaseFirestore.instance.collection("events");
}
