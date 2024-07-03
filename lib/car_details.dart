import 'package:flutter/material.dart';

class CarDetails extends StatelessWidget {
  final Map<String, dynamic> car;

  CarDetails({required this.car});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Car Details'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: 'carImage${car['name']}', // Unique tag for each car
              child: Image.asset(
                car['image'],
                height: 200.0,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 16.0),
                  Text(
                    car['name'],
                    style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8.0),
                  Text('Type: ${car['type']}'),
                  SizedBox(height: 8.0),
                  Text('Price: \$${car['price']}'),
                  // Add more details as needed
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
