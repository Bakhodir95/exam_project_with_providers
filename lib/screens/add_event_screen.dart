import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddEventScreen extends StatefulWidget {
  const AddEventScreen({super.key});

  @override
  State<AddEventScreen> createState() => _AddEventScreenState();
}

class _AddEventScreenState extends State<AddEventScreen> {
  @override
  final _nomi = TextEditingController();
  final _kuni = TextEditingController();
  final _vaqti = TextEditingController();
  final _info = TextEditingController();
  LatLng? selected;
  late GoogleMapController mapController;
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tadbir Qo'shish"),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
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
                  )),
                  labelText: "Nomi"),
            ),
            TextField(
              controller: _nomi,
              decoration: const InputDecoration(
                  suffixIcon: Icon(Icons.calendar_today_outlined),
                  border: OutlineInputBorder(borderSide: BorderSide()),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                    color: Colors.orange,
                    width: 3,
                  )),
                  labelText: "Kuni"),
            ),
            TextField(
              controller: _nomi,
              decoration: const InputDecoration(
                  suffixIcon: Icon(Icons.watch_later_outlined),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(
                    color: Colors.orange,
                  )),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                    color: Colors.orange,
                    width: 3,
                  )),
                  labelText: "Vaqti"),
            ),
            TextField(
              controller: _nomi,
              minLines: 5,
              maxLines: 7,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(
                      borderSide: BorderSide(
                    color: Colors.orange,
                  )),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                    color: Colors.orange,
                    width: 3,
                  )),
                  labelText: "Tadbir haqidagi ma'lumot:"),
            ),
            const Text("Rasm yoki video yuklash"),
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        // color: Colors.green,
                        borderRadius: BorderRadius.circular(10),
                        shape: BoxShape.rectangle,
                        border: Border.all()),
                    child: const Column(
                      children: [
                        Icon(
                          Icons.photo_camera,
                          size: 30,
                        ),
                        Text("Rasm")
                      ],
                    ),
                  ),
                ),
                const Gap(15),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        // color: Colors.green,
                        borderRadius: BorderRadius.circular(10),
                        shape: BoxShape.rectangle,
                        border: Border.all()),
                    child: const Column(
                      children: [
                        Icon(
                          Icons.video_camera_back,
                          size: 30,
                        ),
                        Text("Rasm")
                      ],
                    ),
                  ),
                )
              ],
            ),
            const Text("Manzilni belgilash"),
            const SizedBox(
              height: 200,
              width: double.infinity,
              child: GoogleMap(
                  initialCameraPosition: CameraPosition(
                      target: LatLng(41.2856806, 69.2034646), zoom: 14)),
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
              child: const Text(
                "Qo'shish",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
