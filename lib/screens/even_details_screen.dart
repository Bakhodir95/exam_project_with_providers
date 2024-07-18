import 'package:flutter/material.dart';

class EvenDetailsScreen extends StatefulWidget {
  const EvenDetailsScreen({super.key});

  @override
  State<EvenDetailsScreen> createState() => _EvenDetailsScreenState();
}

class _EvenDetailsScreenState extends State<EvenDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.favorite_outlined))
        ],
      ),
      body: const Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Satellite mega festival for\ndesigners",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            )
          ],
        ),
      ),
    );
  }
}
