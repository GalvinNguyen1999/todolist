import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo List App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.brown, useMaterial3: true),
      home: const TodoListScreen(),
    );
  }
}

class Todo {
  final String id;
  final String title;
  bool isCompleted;

  Todo({required this.id, required this.title, this.isCompleted = false});
}

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({super.key});

  @override
  State<TodoListScreen> createState() {
    return _TodoListScreenState();
  }
}

class _TodoListScreenState extends State<TodoListScreen> {
  List<Todo> todos = [
    Todo(id: '1', title: 'Học Flutter', isCompleted: true),
    Todo(id: '2', title: 'Làm bài tập về nhà', isCompleted: false),
    Todo(id: '3', title: 'Đi chợ mua rau', isCompleted: false),
    Todo(id: '4', title: 'Tập thể dục', isCompleted: true),
    Todo(id: '5', title: 'Đọc sách', isCompleted: false),
  ];

  void _addTodo(String title) {
    setState(() {
      todos.add(
        Todo(
          id: (todos.length + 1).toString(),
          title: title,
          isCompleted: false,
        ),
      );
    });
  }

  void _showAddTodoDialog() {
    final TextEditingController controller = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Thêm todo mới'),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(
              hintText: 'Nhập công việc...',
              border: OutlineInputBorder(),
            ),
            autofocus: true,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                controller.clear();
              },
              child: const Text('Hủy'),
            ),
            ElevatedButton(
              onPressed: () {
                if (controller.text.trim().isNotEmpty) {
                  _addTodo(controller.text.trim());
                  Navigator.pop(context);
                  controller.clear();
                }
              },
              child: const Text('Thêm'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List'),
        backgroundColor: Colors.brown,
        leading: const IconButton(
          onPressed: null,
          icon: const Icon(Icons.menu),
        ),
        actions: [
          IconButton(
            onPressed: _showAddTodoDialog,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView.builder(
          itemCount: todos.length,
          itemBuilder: (context, index) {
            final todo = todos[index];

            return Card(
              margin: const EdgeInsets.only(bottom: 12),
              child: ListTile(
                title: Text(
                  todo.title,
                  style: TextStyle(
                    decoration: todo.isCompleted
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                  ),
                ),
                leading: Checkbox(
                  value: todo.isCompleted,
                  onChanged: (value) {
                    setState(() {
                      todo.isCompleted = value ?? false;
                    });
                  },
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: null,
                      icon: Icon(Icons.edit, color: Colors.blue),
                    ),
                    IconButton(
                      onPressed: null,
                      icon: Icon(Icons.delete, color: Colors.red),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
