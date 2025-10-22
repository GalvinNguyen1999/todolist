import 'package:flutter/material.dart';

/// Dialog for adding a new todo
class AddTodoDialog extends StatefulWidget {
  final Function(String) onAdd;

  const AddTodoDialog({super.key, required this.onAdd});

  @override
  State<AddTodoDialog> createState() => _AddTodoDialogState();
}

class _AddTodoDialogState extends State<AddTodoDialog> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleAdd() {
    if (_controller.text.trim().isNotEmpty) {
      widget.onAdd(_controller.text.trim());
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Thêm Todo mới'),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      content: TextField(
        controller: _controller,
        decoration: const InputDecoration(
          hintText: 'Nhập công việc...',
          border: OutlineInputBorder(),
        ),
        autofocus: true,
        onSubmitted: (value) => _handleAdd(),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Hủy'),
        ),
        ElevatedButton(
          onPressed: _handleAdd,
          child: const Text('Thêm'),
        ),
      ],
    );
  }
}

