import 'dart:io';
import 'package:exam_project_with_providers/controllers/user_registration_controller.dart';
import 'package:exam_project_with_providers/models/user.dart';
import 'package:exam_project_with_providers/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final formkey = GlobalKey<FormState>();
  final registerController = UserRegistrationController();
  File? imageFile;
  User user = User(
      id: '', deviceId: '', name: '', surname: '', email: '', imageUrl: '');
  String? password;
  String? confirmedPassword;

  void openGallery() async {
    final imagePicker = ImagePicker();
    final XFile? pickedImage = await imagePicker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 50,
        requestFullMetadata: false);
    if (pickedImage != null) {
      setState(() {
        imageFile = File(pickedImage.path);
      });
    }
  }

  void openCamera() async {
    final imagePicker = ImagePicker();
    final XFile? pickedImage = await imagePicker.pickImage(
        source: ImageSource.camera,
        imageQuality: 50,
        requestFullMetadata: false);
    if (pickedImage != null) {
      setState(() {
        imageFile = File(pickedImage.path);
      });
    }
  }

  submit() async {
    if (formkey.currentState!.validate() && confirmedPassword == password) {
      formkey.currentState!.save();
      try {
        await registerController.register(
          user.email,
          user.name,
          user.surname,
          user.imageUrl!,
          user.deviceId,
          user.id,
        );
        Navigator.pop(context);
      } catch (e) {
        print(e);
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "Registration",
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const Gap(20),
                Stack(children: [
                  InkWell(
                    onTap: openGallery,
                    child: Container(
                      clipBehavior: Clip.hardEdge,
                      height: 200,
                      width: 200,
                      decoration: const BoxDecoration(shape: BoxShape.circle),
                      child: imageFile != null
                          ? Image.file(
                              imageFile!,
                              fit: BoxFit.cover,
                            )
                          : const SizedBox(),
                    ),
                  ),
                  const Positioned(
                    bottom: 0,
                    right: 20,
                    child: Icon(
                      Icons.add_circle_outline_sharp,
                      size: 40,
                    ),
                  ),
                ]),
                const Gap(20),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Please enter an email";
                    }
                    return null;
                  },
                  onSaved: (newValue) {
                    user.email = newValue!;
                  },
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), label: Text("Enter Email")),
                ),
                const Gap(10),
                TextFormField(
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Please enter a password";
                    }
                    return null;
                  },
                  onSaved: (newValue) {
                    password = newValue;
                  },
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text("Enter Password")),
                ),
                const Gap(10),
                TextFormField(
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Please confirm your password";
                    }
                    // if (value != password) {
                    //   return "Passwords do not match";
                    // }
                    return null;
                  },
                  onSaved: (newValue) {
                    confirmedPassword = newValue;
                  },
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text("Confirm Password")),
                ),
                const Gap(10),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Please enter your name";
                    }
                    return null;
                  },
                  onSaved: (newValue) {
                    user.name = newValue!;
                  },
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), label: Text("Enter Name")),
                ),
                const Gap(10),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Please enter your surname";
                    }
                    return null;
                  },
                  onSaved: (newValue) {
                    user.surname = newValue!;
                  },
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text("Enter Surname")),
                ),
                const Gap(20),
                FilledButton(
                    onPressed: () {
                      submit();
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(5),
                      child: Text("Submit"),
                    )),
                OutlinedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, "/login");
                    },
                    child: const Text("Log In"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
