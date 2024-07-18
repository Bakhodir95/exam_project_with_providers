import 'package:easy_localization/easy_localization.dart';
import 'package:exam_project_with_providers/controllers/user_registration_controller.dart';
import 'package:exam_project_with_providers/models/event.dart';
import 'package:exam_project_with_providers/services/location_service.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

class EvenDetailsScreen extends StatefulWidget {
  final Event event;
  const EvenDetailsScreen({super.key, required this.event});

  @override
  State<EvenDetailsScreen> createState() => _EvenDetailsScreenState();
}

class _EvenDetailsScreenState extends State<EvenDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.favorite_outlined))
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Satellite mega festival for\ndesigners",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
            Row(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.green.shade100),
                  child: const Icon(
                    Icons.calendar_today_outlined,
                    color: Colors.black87,
                  ),
                ),
                const Gap(20),
                Text(DateFormat("E, d MMM yyyy HH:mm:ss")
                    .format(widget.event.date))
              ],
            ),
            Row(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.green.shade100),
                  child: const Icon(
                    Icons.location_on_rounded,
                    color: Colors.black87,
                  ),
                ),
                const Gap(20),
                Expanded(
                  child: FutureBuilder(
                      future: GooleMapService.getLocationInformation(
                          widget.event.location.latitude,
                          widget.event.location.longitude),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Text("Loading...");
                        }
                        if (snapshot.hasError) {
                          return const Text("Error occured");
                        }
                        if (!snapshot.hasData || snapshot.data == null) {
                          return const Text("No information yet");
                        }
                        return Text(snapshot.data!);
                      }),
                ),
              ],
            ),
            Row(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.green.shade100),
                  child: const Icon(
                    Icons.person,
                    color: Colors.black87,
                  ),
                ),
                const Gap(20),
                Column(
                  children: [
                    Text(
                        "${widget.event.membersList.length.toString()} ta odam qatnashmoqda"),
                    const Text("Siz ham ro'yxatdan o'ting"),
                  ],
                )
              ],
            ),
            FutureBuilder(
                future:
                    UserRegistrationController.getUser(widget.event.organiser),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Text("Loading...");
                  }
                  if (snapshot.hasError) {
                    return const Text("Error occured");
                  }
                  if (!snapshot.hasData || snapshot.data == null) {
                    return const Text("No information yet");
                  }
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListTile(
                        tileColor: Colors.green.shade100,
                        leading: Image.network(snapshot.data!.imageUrl!),
                        title: Text(snapshot.data!.name),
                        subtitle: Text(snapshot.data!.surname),
                        trailing: Text(snapshot.data!.email),
                      ),
                    ],
                  );
                }),
            Column(
              children: [
                Text(
                  "tadbir_haqida".tr(),
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                ),
                const Gap(10),
                Text(widget.event.description),
                const Gap(10),
              ],
            ),
            const Gap(10),
            SizedBox(
              width: double.infinity,
              height: 300,
              child: GoogleMap(
                initialCameraPosition: CameraPosition(
                    target: LatLng(widget.event.location.latitude,
                        widget.event.location.longitude),
                    zoom: 14),
                markers: {
                  Marker(
                      markerId: const MarkerId("qqq"),
                      position: LatLng(widget.event.location.latitude,
                          widget.event.location.longitude)),
                },
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
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange.shade300,
                ),
                child: Text(
                  "royxatdan_otish".tr(),
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
