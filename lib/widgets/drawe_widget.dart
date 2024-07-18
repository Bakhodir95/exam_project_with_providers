import 'package:easy_localization/easy_localization.dart';
import 'package:exam_project_with_providers/controllers/user_registration_controller.dart';
import 'package:exam_project_with_providers/providers/theme_provider.dart';
import 'package:exam_project_with_providers/screens/events_screen.dart';
import 'package:exam_project_with_providers/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddDrawer extends StatelessWidget {
  const AddDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Consumer<UserRegistrationController>(
            builder: (context, userProvider, child) {
              return UserAccountsDrawerHeader(
                accountName: Text(userProvider.name),
                accountEmail: Text(userProvider.email),
                currentAccountPicture: CircleAvatar(
                  backgroundImage: userProvider.imageUrl.isNotEmpty
                      ? NetworkImage(userProvider.imageUrl)
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
            title: Text('mening_tadbirlarim'.tr()),
            onTap: () {
              Navigator.pushReplacement(context,
                  CupertinoPageRoute(builder: (ctx) => const MyEvents()));
            },
          ),
          ListTile(
            trailing: const Icon(Icons.arrow_forward_ios_outlined),
            leading: const Icon(Icons.person_2_outlined),
            title: Text("profil_malumotlari".tr()),
            onTap: () {
              Navigator.push(context,
                  CupertinoPageRoute(builder: (ctx) => const HomeScreen()));
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
                  "images/day.png",
                  width: 23,
                ),
                title: Text("tungi_kunduzgi_holat".tr()),
              );
            },
          ),
          ListTile(
            trailing: const Icon(Icons.arrow_forward_ios_outlined),
            leading: const Icon(CupertinoIcons.heart_circle_fill),
            title: Text("sevimlilar".tr()),
            onTap: () {
              Navigator.push(context,
                  CupertinoPageRoute(builder: (ctx) => const HomeScreen()));
            },
          ),
          ListTile(
            trailing: PopupMenuButton<Locale>(
              onSelected: (locale) {
                context.setLocale(locale);
              },
              itemBuilder: (context) => [
                const PopupMenuItem<Locale>(
                  value: Locale('en'),
                  child: Text('English'),
                ),
                const PopupMenuItem<Locale>(
                  value: Locale('uz'),
                  child: Text('Uzbek'),
                ),
              ],
            ),
            leading: const Icon(Icons.language),
            title: Text("tillarni_ozgartirish".tr()),
          ),
          const Spacer(),
          Row(
            children: [
              IconButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                },
                icon: const Icon(
                  Icons.logout,
                  size: 25,
                ),
              ),
              Text(
                "chiqish".tr(),
                style: const TextStyle(
                  color: Colors.red,
                  fontSize: 20,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
