import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exam_project_with_providers/models/event.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart' as geoposition;

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
      // Create a reference to the Firebase Storage location
      Reference storageReference = _firebaseStorage.ref().child('$path.jpg');

      // Upload the file
      UploadTask uploadTask = storageReference.putFile(imageFile);
      TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => {});

      // Get the download URL
      String downloadURL = await taskSnapshot.ref.getDownloadURL();

      return downloadURL;
    } catch (e) {
      print("Error uploading image: $e");
      return null;
    }
  }

  static Future<String> getLocationInformation(
      double latitude, double longitude) async {
    try {
      List<geoposition.Placemark> placemarks =
          await geoposition.placemarkFromCoordinates(latitude, longitude);

      if (placemarks.isNotEmpty) {
        final geoposition.Placemark place = placemarks[0];
        return "${place.street}, ${place.locality}, ${place.administrativeArea}, ${place.country}";
      } else {
        return "No address available";
      }
    } catch (e) {
      return "Error: $e";
    }
  }
}
