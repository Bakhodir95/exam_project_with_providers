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
  String location;
  int memberCount;

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
    required this.memberCount,
  });

  factory Event.fromMap(QueryDocumentSnapshot query) {
    return Event(
      id: query.id,
      name: query['event-name'],
      organiser: query['event-organiser'],
      date: query['event-date'],
      time: query['event-time'],
      description: query['event-description'],
      imageUrl: query['event-imageUrl'],
      isLike: query['event-isLike'],
      location: query['event-location'],
      memberCount: query["event-memberCount"],
    );
  }
}
