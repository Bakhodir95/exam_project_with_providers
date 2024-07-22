import 'package:carousel_slider/carousel_slider.dart';
import 'package:exam_project_with_providers/controllers/event_controller.dart';
import 'package:exam_project_with_providers/models/event.dart';
import 'package:exam_project_with_providers/screens/even_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EventsWithinNextWeekWidget extends StatefulWidget {
  const EventsWithinNextWeekWidget({super.key});

  @override
  State<EventsWithinNextWeekWidget> createState() =>
      _EventsWithinNextWeekWidgetState();
}

class _EventsWithinNextWeekWidgetState
    extends State<EventsWithinNextWeekWidget> {
  @override
  Widget build(BuildContext context) {
    final eventController = context.read<EventController>();
    return StreamBuilder(
      stream: eventController.getEventsWithinNextWeek(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.hasError) {
          return const Center(
            child: Text("Ma'lumot olishda hato bor"),
          );
        }
        if (!snapshot.hasData ||
            snapshot.data == null ||
            snapshot.data!.docs.isEmpty) {
          return const Center(
            child: Text("Malumot mavjud emas"),
          );
        }

        final events = snapshot.data!.docs;

        return CarouselSlider.builder(
          itemCount: events.length,
          itemBuilder: (context, index, realIndex) {
            final event = Event.fromMap(events[index]);

            return Stack(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EvenDetailsScreen(event: event),
                      ),
                    );
                  },
                  child: Container(
                    clipBehavior: Clip.hardEdge,
                    margin: const EdgeInsets.all(10),
                    height: 250,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        color: Colors.black,
                      ),
                    ),
                    child: FadeInImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(event.imageUrl),
                      placeholder: const AssetImage('images/day.png'),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 20,
                  left: 20,
                  child: Text(
                    event.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                Positioned(
                  top: 20,
                  left: 20,
                  child: Container(
                    height: 55,
                    width: 50,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 46, 45, 45),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          event.date.day.toString(),
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          DateFormat('MMMM').format(event.date),
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
          options: CarouselOptions(
            animateToClosest: true,
            autoPlay: true,
          ),
        );
      },
    );
  }
}
