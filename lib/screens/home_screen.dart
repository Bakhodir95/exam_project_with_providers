import 'package:exam_project_with_providers/controllers/user_registration_controller.dart';
import 'package:exam_project_with_providers/providers/theme_provider.dart';
import 'package:exam_project_with_providers/providers/user_provider.dart';
import 'package:exam_project_with_providers/screens/events_screen.dart';
import 'package:exam_project_with_providers/screens/favourite_screen.dart';
import 'package:exam_project_with_providers/screens/profile_screen.dart';
import 'package:exam_project_with_providers/widgets/drawe_widget.dart';
import 'package:exam_project_with_providers/widgets/search_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
        body: const Padding(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          child: Column(
            children: [
              SearchWidget(),
            ],
          ),
        ));
  }
}
