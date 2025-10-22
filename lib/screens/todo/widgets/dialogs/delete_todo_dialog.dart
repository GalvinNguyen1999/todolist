import 'package:flutter/material.dart';

/// Dialog for confirming todo deletion
class DeleteTodoDialog extends StatelessWidget {
  final VoidCallback onDelete;

  const DeleteTodoDialog({super.key, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Xóa Todo'),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      content: const Text(
        'Bạn có chắc chắn muốn xóa todo này không?',
        style: TextStyle(fontSize: 16),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Hủy'),
        ),
        ElevatedButton(
          onPressed: () {
            onDelete();
            Navigator.pop(context);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
          ),
          child: const Text('Xóa'),
        ),
      ],
    );
  }
}

