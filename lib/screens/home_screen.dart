import 'package:exam_project_with_providers/providers/user_provider.dart';
import 'package:exam_project_with_providers/widgets/created_events_widget.dart';
import 'package:exam_project_with_providers/widgets/drawe_widget.dart';
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
            title: const Text("Bosh Sahifa"),
            centerTitle: true,
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.notification_add_rounded),
              ),
            ]),
        drawer: const AddDrawer(),
        body: Padding(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SearchWidget(),
              const Gap(10),
              const Text(
                "Yaqin 7 kun ichida",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Container(
                  width: 400,
                  height: 250,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.amber,
                  ),
                ),
              ),
              const Text(
                "Barcha Tadbirlar",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
              const CreatedEventsWidget(),
            ],
          ),
        ));
  }
}
