import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exam_project_with_providers/controllers/event_controller.dart';
import 'package:exam_project_with_providers/models/event.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';

class AddEventScreen extends StatefulWidget {
  const AddEventScreen({super.key});

  @override
  State<AddEventScreen> createState() => _AddEventScreenState();
}

class _AddEventScreenState extends State<AddEventScreen> {
  final _eventController = EventController();
  final _nomi = TextEditingController();
  final _kuni = TextEditingController();
  final _vaqti = TextEditingController();
  final _info = TextEditingController();
  LatLng? selected;
  LatLng _myCurrentLocation = LatLng(41.2856806, 69.2034646);
  late GoogleMapController mapController;
  File? _getImageFile;

  @override
  void initState() {
    super.initState();
    // Additional initialization if needed
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void _onLongPress(LatLng location) {
    setState(() {
      selected = location;
    });
  }

  void openGallery() async {
    final imagePicker = ImagePicker();
    final XFile? pickedImage = await imagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
      requestFullMetadata: false,
    );
    if (pickedImage != null) {
      setState(() {
        _getImageFile = File(pickedImage.path);
      });
      Navigator.pop(context);
    }
  }

  void openCamera() async {
    final imagePicker = ImagePicker();
    final XFile? pickedImage = await imagePicker.pickImage(
      source: ImageSource.camera,
      imageQuality: 50,
      requestFullMetadata: false,
    );
    if (pickedImage != null) {
      setState(() {
        _getImageFile = File(pickedImage.path);
      });
      Navigator.pop(context);
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != DateTime.now()) {
      setState(() {
        _kuni.text = "${picked.toLocal()}".split(' ')[0];
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        _vaqti.text = picked.format(context);
      });
    }
  }

  void _submitForm() async {
    if (_nomi.text.isEmpty ||
        _kuni.text.isEmpty ||
        _vaqti.text.isEmpty ||
        _info.text.isEmpty ||
        selected == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Har bir maydon to'ldirilishi shart"),
        ),
      );
      return;
    } else {
      GeoPoint(selected!.latitude, selected!.longitude);

      String? imageUrl = await EventController.uploadImage(
        _getImageFile!,
        _nomi.text,
      );
      await _eventController.addEvent(
        Event(
          id: '',
          name: _nomi.text,
          organiser: FirebaseAuth.instance.currentUser!.uid,
          date: DateTime.parse(_kuni.text),
          time: TimeOfDay(
            hour: int.parse(_vaqti.text.split(':')[0]),
            minute: int.parse(_vaqti.text.split(':')[1]),
          ),
          description: _info.text,
          imageUrl: imageUrl.toString(),
          location: GeoPoint(selected!.latitude, selected!.longitude),
          membersList: [],
        ),
      );
    }

    _nomi.clear();
    _kuni.clear();
    _vaqti.clear();
    _info.clear();
    setState(() {
      selected = null;
      _getImageFile = null;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Event added successfully!'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tadbir Qo'shish"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _nomi,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.orange,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.orange,
                    width: 3,
                  ),
                ),
                labelText: "Nomi",
              ),
            ),
            TextField(
              controller: _kuni,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  onPressed: () => _selectDate(context),
                  icon: const Icon(Icons.calendar_today_outlined),
                ),
                border: const OutlineInputBorder(
                  borderSide: BorderSide(),
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.orange,
                    width: 3,
                  ),
                ),
                labelText: "Kuni",
              ),
            ),
            TextField(
              controller: _vaqti,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  onPressed: () => _selectTime(context),
                  icon: const Icon(Icons.watch_later_outlined),
                ),
                border: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.orange,
                  ),
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.orange,
                    width: 3,
                  ),
                ),
                labelText: "Vaqti",
              ),
            ),
            TextField(
              controller: _info,
              minLines: 5,
              maxLines: 7,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.orange,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.orange,
                    width: 3,
                  ),
                ),
                labelText: "Tadbir haqidagi ma'lumot:",
              ),
            ),
            const Text("Rasm yoki video yuklash"),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                GestureDetector(
                                  onTap: openCamera,
                                  child: const Row(
                                    children: [
                                      Icon(Icons.camera_alt),
                                      Gap(10),
                                      Text("From Camera"),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 16),
                                GestureDetector(
                                  onTap: openGallery,
                                  child: const Row(
                                    children: [
                                      Icon(Icons.camera),
                                      Gap(10),
                                      Text("From Gallery"),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 16),
                                GestureDetector(
                                  onTap: () => Navigator.pop(context),
                                  child: const Row(
                                    children: [
                                      Icon(Icons.close),
                                      Gap(10),
                                      Text("Cancel"),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    child: Container(
                      clipBehavior: Clip.hardEdge,
                      height: 150,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        shape: BoxShape.rectangle,
                        border: Border.all(),
                      ),
                      child: _getImageFile != null
                          ? Image.file(
                              _getImageFile!,
                              fit: BoxFit.cover,
                            )
                          : const Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.photo_camera,
                                    size: 30,
                                  ),
                                  Text("Rasm"),
                                ],
                              ),
                            ),
                    ),
                  ),
                ),
                const Gap(15),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      shape: BoxShape.rectangle,
                      border: Border.all(),
                    ),
                    child: const Column(
                      children: [
                        Icon(
                          Icons.video_camera_back,
                          size: 30,
                        ),
                        Text("Video"),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const Text("Manzilni belgilash"),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              height: 300,
              width: double.infinity,
              child: GoogleMap(
                onMapCreated: _onMapCreated,
                onLongPress: _onLongPress,
                initialCameraPosition: CameraPosition(
                  target: _myCurrentLocation,
                  zoom: 14,
                ),
                markers: selected != null
                    ? {
                        Marker(
                          markerId: const MarkerId("selectedLocation"),
                          position: selected!,
                          infoWindow: const InfoWindow(
                            title: 'Selected Location',
                          ),
                        ),
                      }
                    : {},
              ),
            ),
            Container(
              alignment: Alignment.center,
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.orange.shade300,
                borderRadius: BorderRadius.circular(10),
                shape: BoxShape.rectangle,
              ),
              child: ElevatedButton(
                onPressed: _submitForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange.shade300,
                ),
                child: const Text(
                  "Qo'shish",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
