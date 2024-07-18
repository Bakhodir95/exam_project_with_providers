import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Event {
  String id;
  String name;
  String organiser;
  DateTime date;
  TimeOfDay time;
  String description;
  String imageUrl;
  bool isLike;
  GeoPoint location;
  List membersList;

  Event({
    required this.id,
    required this.name,
    required this.organiser,
    required this.date,
    required this.time,
    required this.description,
    required this.imageUrl,
    this.isLike = false,
    required this.location,
    required this.membersList,
  });

  Map<String, dynamic> toMap() {
    return {
      'event-name': name,
      'event-organiser': organiser,
      'event-date': Timestamp.fromDate(date),
      'event-time': {'hour': time.hour, 'minute': time.minute},
      'event-description': description,
      'event-imageUrl': imageUrl,
      'event-location': location,
      'event-membersList': membersList,
    };
  }

  factory Event.fromMap(QueryDocumentSnapshot query) {
    return Event(
      id: query.id,
      name: query['event-name'],
      organiser: query['event-organiser'],
      date: (query['event-date'] as Timestamp).toDate(),
      time: TimeOfDay(
        hour: query['event-time']['hour'],
        minute: query['event-time']['minute'],
      ),
      description: query['event-description'],
      imageUrl: query['event-imageUrl'],
      location: query['event-location'],
      membersList: query['event-membersList'],
    );
  }
}
