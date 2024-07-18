import 'package:easy_localization/easy_localization.dart';
import 'package:exam_project_with_providers/providers/user_provider.dart';
import 'package:exam_project_with_providers/widgets/created_events_widget.dart';
import 'package:exam_project_with_providers/widgets/drawe_widget.dart';
import 'package:exam_project_with_providers/widgets/events_within_next_week_widget.dart';
import 'package:exam_project_with_providers/widgets/search_widget.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<UserProvider>().saveUsersInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text("bosh_sahifa").tr(),
            centerTitle: true,
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.notification_add_rounded),
              ),
            ]),
        drawer: const AddDrawer(),
        body: const Padding(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SearchWidget(),
              Gap(10),
              Text(
                "Yaqin 7 kun ichida",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
              Padding(
                  padding: EdgeInsets.all(20),
                  child: EventsWithinNextWeekWidget()),
              Text(
                "Barcha Tadbirlar",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
              CreatedEventsWidget(),
            ],
          ),
        ));
  }
}
