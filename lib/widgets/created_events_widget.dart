import 'package:exam_project_with_providers/controllers/event_controller.dart';
import 'package:exam_project_with_providers/models/event.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CreatedEventsWidget extends StatefulWidget {
  const CreatedEventsWidget({super.key});

  @override
  State<CreatedEventsWidget> createState() => _CreatedEventsWidgetState();
}

class _CreatedEventsWidgetState extends State<CreatedEventsWidget> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: context.read<EventController>().getEvents(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text("Nimadir xato bo'ldi: ${snapshot.error}"));
        } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text('Tadbirlar topilmadi.'));
        } else {
          List<Event> events = snapshot.data!.docs.map((doc) {
            return Event.fromMap(doc);
          }).toList();

          return ListView.builder(
            itemCount: events.length,
            itemBuilder: (context, index) {
              Event event = events[index];
              return ListTile(
                title: Text(event.name),
                subtitle: Text(event.description),
                trailing: Text(event.date.toIso8601String()),
                onTap: () {},
              );
            },
          );
        }
      },
    );
  }
}
