import 'package:easy_localization/easy_localization.dart';
import 'package:exam_project_with_providers/controllers/event_controller.dart';
import 'package:exam_project_with_providers/controllers/user_registration_controller.dart';
import 'package:exam_project_with_providers/l10n/app_localizations.dart';
import 'package:exam_project_with_providers/providers/theme_provider.dart';
import 'package:exam_project_with_providers/providers/user_provider.dart';
import 'package:exam_project_with_providers/screens/login_screen.dart';
import 'package:exam_project_with_providers/services/users_firbase_service.dart.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:exam_project_with_providers/firebase_options.dart';
import 'package:exam_project_with_providers/screens/home_screen.dart';
import 'package:exam_project_with_providers/screens/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
      supportedLocales: [Locale('en'), Locale('uz')],
      path: 'assets/translations',
      fallbackLocale: const Locale('uz'),
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => UserRegistrationController()),
          ChangeNotifierProvider(create: (_) => UserProvider()),
          ChangeNotifierProvider(create: (_) => EventController()),
          ChangeNotifierProvider(create: (_) => ThemeProvider()),
          ChangeNotifierProvider(create: (_) => UserFirerbaseService()),
        ],
        child: MyApp(),
      ),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _locale = const Locale('uz');

  void _setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme:
              themeProvider.isDarkMode ? ThemeData.dark() : ThemeData.light(),
          home: StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return const Center(child: Text("Error occurred"));
              } else if (snapshot.hasData) {
                return HomeScreen();
              } else {
                return const LoginScreen();
              }
            },
          ),
          routes: {
            '/registration': (context) => const RegisterScreen(),
            '/login': (context) => const LoginScreen(),
            '/home': (context) => HomeScreen(),
          },
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
        );
      },
    );
  }
}
