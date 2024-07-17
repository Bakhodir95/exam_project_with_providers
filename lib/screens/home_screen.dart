import 'package:exam_project_with_providers/controllers/user_registration_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
    // Initialize user info when the screen is created
    context.read<UserRegistrationController>().saveUsersInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Screen"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notification_add_rounded),
          ),
          IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            Consumer<UserRegistrationController>(
              builder: (context, userRegistrationController, child) {
                return UserAccountsDrawerHeader(
                  accountName: Text(userRegistrationController.name),
                  accountEmail: Text(userRegistrationController.email),
                  currentAccountPicture: CircleAvatar(
                    backgroundImage:
                        userRegistrationController.imageUrl.isNotEmpty
                            ? NetworkImage(userRegistrationController.imageUrl)
                            : const NetworkImage(
                                "https://static.vecteezy.com/system/resources/thumbnails/019/900/322/small/happy-young-cute-illustration-face-profile-png.png",
                              ),
                  ),
                );
              },
            ),
            // Add more items to the Drawer if needed
          ],
        ),
      ),
      body: const Center(
        child: Text('Welcome to the Home Screen'),
      ),
    );
  }
}
