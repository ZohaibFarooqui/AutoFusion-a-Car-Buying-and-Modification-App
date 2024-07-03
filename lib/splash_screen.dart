import 'package:flutter/material.dart';
import 'car_list.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);

    // Simulate some initialization process, e.g., loading data, setting up resources
    Future.delayed(Duration(seconds: 2), () {
      _controller.forward();
      _controller.addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (_, __, ___) => CarList(),
              transitionsBuilder: (_, animation, __, child) {
                return FadeTransition(
                  opacity: animation,
                  child: child,
                );
              },
            ),
          );
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FadeTransition(
          opacity: _animation,
          child: Image.asset('lib/assets/logo.png'), // Replace with your splash image
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
