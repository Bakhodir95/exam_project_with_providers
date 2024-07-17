import 'package:exam_project_with_providers/controllers/user_registration_controller.dart';
import 'package:exam_project_with_providers/providers/theme_provider.dart';
import 'package:exam_project_with_providers/providers/user_provider.dart';
import 'package:exam_project_with_providers/screens/events_screen.dart';
import 'package:exam_project_with_providers/screens/favourite_screen.dart';
import 'package:exam_project_with_providers/screens/profile_screen.dart';
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
            Consumer<UserProvider>(
              builder: (context, userProvider, child) {
                return UserAccountsDrawerHeader(
                  accountName: Text(userProvider.name ?? 'No Name'),
                  accountEmail: Text(userProvider.email ?? 'No Email'),
                  currentAccountPicture: CircleAvatar(
                    backgroundImage: userProvider.imageUrl != null &&
                            userProvider.imageUrl!.isNotEmpty
                        ? NetworkImage(userProvider.imageUrl!)
                        : const NetworkImage(
                            "https://static.vecteezy.com/system/resources/thumbnails/019/900/322/small/happy-young-cute-illustration-face-profile-png.png",
                          ),
                  ),
                );
              },
            ),
            ListTile(
              trailing: const Icon(Icons.arrow_forward_ios_outlined),
              leading: const Icon(CupertinoIcons.tickets),
              title: const Text('Mening tadbirlarim'),
              onTap: () {
                Navigator.push(context,
                    CupertinoPageRoute(builder: (ctx) => const MyEvents()));
              },
            ),
            ListTile(
              trailing: const Icon(Icons.arrow_forward_ios_outlined),
              leading: const Icon(Icons.person_2_outlined),
              title: const Text("Profil Ma'lumotlari"),
              onTap: () {
                Navigator.push(
                    context,
                    CupertinoPageRoute(
                        builder: (ctx) => const ProfileScreen()));
              },
            ),
            Consumer<ThemeProvider>(
              builder: (context, themeProvider, child) {
                return ListTile(
                  trailing: Switch(
                    value: themeProvider.isDarkMode,
                    onChanged: (value) {
                      themeProvider.toggleTheme();
                    },
                  ),
                  leading: Image.asset(
                    "assets/icons/theme_mode.png",
                    width: 23,
                  ),
                  title: const Text("Tungi / kunduzgi holat"),
                );
              },
            ),
            ListTile(
              trailing: const Icon(Icons.arrow_forward_ios_outlined),
              leading: const Icon(CupertinoIcons.heart_circle_fill),
              title: const Text("Sevimlilar"),
              onTap: () {
                Navigator.push(
                    context,
                    CupertinoPageRoute(
                        builder: (ctx) => const FavouriteScreen()));
              },
            ),
          ],
        ),
      ),
      body: const Center(
        child: Text('Welcome to the Home Screen'),
      ),
    );
  }
}
