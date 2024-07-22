import 'package:easy_localization/easy_localization.dart';
import 'package:exam_project_with_providers/providers/user_provider.dart';
import 'package:exam_project_with_providers/widgets/created_events_widget.dart';
import 'package:exam_project_with_providers/widgets/drawe_widget.dart';
import 'package:exam_project_with_providers/widgets/seven_week.dart.dart';
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
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SearchWidget(),
              Gap(10),
              Text(
                "yaqin_7_kun_ichida".tr(),
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
              const Padding(
                  padding: EdgeInsets.all(20),
                  child: EventsWithinNextWeekWidget()),
              Text(
                "barcha_tadbirlar".tr(),
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
              const CreatedEventsWidget(),
            ],
          ),
        ));
  }
}
