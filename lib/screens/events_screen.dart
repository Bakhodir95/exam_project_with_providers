import 'package:easy_localization/easy_localization.dart';
import 'package:exam_project_with_providers/screens/add_event_screen.dart';
import 'package:exam_project_with_providers/widgets/drawe_widget.dart';
import 'package:flutter/material.dart';

class MyEvents extends StatefulWidget {
  const MyEvents({super.key});

  @override
  State<MyEvents> createState() => _MyEventsState();
}

class _MyEventsState extends State<MyEvents> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        drawer: const AddDrawer(),
        appBar: AppBar(
          title: const Text("mening_tadbirlarim").tr(),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.notification_add_rounded),
            ),
          ],
          bottom: TabBar(
            tabs: [
              Tab(text: 'tashkil_qilganlarim'.tr()),
              Tab(text: 'yaqinda'.tr()),
              Tab(text: 'ishtirok_etganlarim'.tr()),
              Tab(text: 'bekor_qilganlarim'.tr()),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Center(child: Text('barcha_tadbirlar').tr()),
            Center(child: Text('Search Tab')),
            Center(
              child: Text('Notifications Tab'),
            ),
            Center(child: Text('Notifications Tab')),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (ctx) => const AddEventScreen()));
              },
              icon: const Icon(Icons.add)),
        ),
      ),
    );
  }
}
