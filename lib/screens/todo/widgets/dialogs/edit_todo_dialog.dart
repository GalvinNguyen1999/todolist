import 'package:flutter/material.dart';

/// Dialog for editing an existing todo
class EditTodoDialog extends StatefulWidget {
  final String currentTitle;
  final Function(String) onEdit;

  const EditTodoDialog({
    super.key,
    required this.currentTitle,
    required this.onEdit,
  });

  @override
  State<EditTodoDialog> createState() => _EditTodoDialogState();
}

class _EditTodoDialogState extends State<EditTodoDialog> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.currentTitle);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleEdit() {
    if (_controller.text.trim().isNotEmpty) {
      widget.onEdit(_controller.text.trim());
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Sửa Todo'),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      content: TextField(
        controller: _controller,
        decoration: const InputDecoration(
          hintText: 'Nhập tên công việc...',
          border: OutlineInputBorder(),
        ),
        autofocus: true,
        onSubmitted: (value) => _handleEdit(),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Hủy'),
        ),
        ElevatedButton(
          onPressed: _handleEdit,
          child: const Text('Lưu'),
        ),
      ],
    );
  }
}

