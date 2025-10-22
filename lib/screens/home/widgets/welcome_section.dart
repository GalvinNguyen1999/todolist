import 'package:flutter/material.dart';

/// Welcome section with "Hello World" text
class WelcomeSection extends StatelessWidget {
  const WelcomeSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Main title
        const Text(
          'Hello World',
          style: TextStyle(
            fontSize: 48,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
        
        const SizedBox(height: 20),
        
        // Subtitle
        Text(
          'Chào mừng đến với Todo App!',
          style: TextStyle(
            fontSize: 18,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }
}

