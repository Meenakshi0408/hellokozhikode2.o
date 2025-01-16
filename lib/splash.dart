import 'package:flutter/material.dart';
import 'package:minions/page1.dart';
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Use Future.delayed to wait for 5 seconds before navigating to the next screen
    Future.delayed(Duration(seconds: 5), () {
      // Navigate to the next screen after the delay
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => TouristPlacesScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Background color of splash screen
      body: Center(
        child: Image.asset('assets/WhatsApp Image 2025-01-16 at 08.06.43_3b2bd998.jpg'), // Replace with your image path
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
      ),
      body: Center(
        child: Text(
          'Welcome to the Home Screen!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
