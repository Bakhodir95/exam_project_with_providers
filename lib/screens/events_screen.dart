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
          title: const Text("Mening tadbirlarim"),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.notification_add_rounded),
            ),
          ],
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Tashkil qilganraim'),
              Tab(text: 'Yaqinda'),
              Tab(text: 'Ishtirok etganlarim'),
              Tab(text: 'Bekor qilganlarim'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            Center(child: Text('Home Tab')),
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
