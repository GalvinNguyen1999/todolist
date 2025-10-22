import 'package:flutter/material.dart';
import 'widgets/welcome_section.dart';
import 'widgets/feature_button.dart';
import 'widgets/info_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              // Welcome text "Hello World"
              WelcomeSection(),
              
              SizedBox(height: 60),
              
              // Button to Todo List
              FeatureButton(),
              
              // Info card
              InfoCard(),
            ],
          ),
        ),
      ),
    );
  }
}
