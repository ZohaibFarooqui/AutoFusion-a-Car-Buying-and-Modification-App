import 'package:flutter/material.dart';
import 'splash_screen.dart';
import 'car_list.dart';  // Assuming you have a 'CarList' screen
import 'favourites_screen.dart';  // Assuming you have a 'FavoritesScreen' screen
import 'about_screen.dart';  // Assuming you have an 'AboutScreen' screen

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Car Customization App',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.light, // Initial theme mode
      home: SplashScreen(),
    );
  }
}
class MyAppHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CarList();  // Redirect to your initial screen (CarList in this case)
  }
}