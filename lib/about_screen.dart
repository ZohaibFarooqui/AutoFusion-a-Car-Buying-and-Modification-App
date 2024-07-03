import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Car Customization App',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            Text(
              'Version: 1.0.0',
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(height: 16.0),
            Text(
              'Description: Your go-to app for exploring and customizing different car models.',
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(height: 16.0),
            Text(
              'Developed by: Your Name',
              style: TextStyle(fontSize: 18.0),
            ),
          ],
        ),
      ),
    );
  }
}
