import 'package:easy_localization/easy_localization.dart';
import 'package:exam_project_with_providers/controllers/user_registration_controller.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formkey = GlobalKey<FormState>();
  final registerController = UserRegistrationController();

  String? email;
  String? password;

  submitLogin() async {
    if (formkey.currentState!.validate()) {
      formkey.currentState!.save();

      try {
        await registerController.login(email!, password!);
        Navigator.pushNamed(context, "/home");
      } catch (e) {
        print(e);
        showDialog(
            context: context,
            builder: (context) => const AlertDialog(
                  content: Text("Invalid email or password! Try again"),
                ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
          key: formkey,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "tizimga_kirish".tr(),
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const Gap(20),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Please enter a email";
                    }
                    return null;
                  },
                  onSaved: (newValue) {
                    email = newValue;
                  },
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), label: Text("Enter Login")),
                ),
                const Gap(10),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "royxatdan_otish".tr();
                    }
                    return null;
                  },
                  onSaved: (newValue) {
                    password = newValue;
                  },
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text("royxatdan_otish").tr()),
                ),
                const Gap(10),
                FilledButton(
                    onPressed: submitLogin,
                    child: Padding(
                      padding: EdgeInsets.all(5),
                      child: Text("topshirish").tr(),
                    )),
                TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/registration');
                    },
                    child: const Text("ro'yxatdan_o'tish").tr()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
