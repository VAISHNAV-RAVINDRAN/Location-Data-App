import 'package:flutter/material.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Set background to black
      appBar: AppBar(
        title: const Text('Settings',style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold, // Bold text
            color: Colors.white,         // Make text visible on black background
          ),),
        backgroundColor: Colors.black, // Optional: Match AppBar color
      ),
      body: const Center(
        child: Text(
          'This is Settings Page',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold, // Bold text
            color: Colors.white,         // Make text visible on black background
          ),
        ),
      ),
    );
  }
}
