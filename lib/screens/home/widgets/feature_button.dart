import 'package:flutter/material.dart';
import '../../todo/todo_list_screen.dart';

/// Button to navigate to Todo List screen
class FeatureButton extends StatelessWidget {
  const FeatureButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const TodoListScreen(),
          ),
        );
      },
      icon: const Icon(Icons.checklist, size: 30),
      label: const Text(
        'Xem Todo List',
        style: TextStyle(fontSize: 18),
      ),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(
          horizontal: 40,
          vertical: 20,
        ),
        backgroundColor: Colors.brown,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}

