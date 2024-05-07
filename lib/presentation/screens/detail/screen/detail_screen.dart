import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  final String title;
  final String body;

  const DetailScreen({super.key, required this.title, required this.body});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Card(
            child: ListTile(
              title: Text(
                title,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
          ),
          Card(
            child: ListTile(
              title: Text(body),
            ),
          ),
        ],
      ),
    );
  }
}
