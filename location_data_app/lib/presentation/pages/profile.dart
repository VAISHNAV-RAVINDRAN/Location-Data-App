import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Set background to black
      appBar: AppBar(
        title: const Text('Profile',style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold, // Bold text
            color: Colors.white,         // Make text visible on black background
          ),),
        backgroundColor: Colors.black, // Optional: Match AppBar color
      ),
      body: const Center(
        child: Text(
          'This is Profile Page',
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
