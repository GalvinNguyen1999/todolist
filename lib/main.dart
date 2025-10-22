import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';

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
  String title;
  bool isCompleted;

  Todo({required this.id, required this.title, this.isCompleted = false});

  // Parse JSON to Todo object
  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      id: json['id'].toString(),
      title: json['title'],
      isCompleted: json['isCompleted'] ?? false,
    );
  }

  // Convert Todo object to JSON
  Map<String, dynamic> toJson() {
    return {'title': title, 'isCompleted': isCompleted};
  }
}

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({super.key});

  @override
  State<TodoListScreen> createState() {
    return _TodoListScreenState();
  }
}

class _TodoListScreenState extends State<TodoListScreen> {
  List<Todo> todos = [];
  bool isLoading = false;

  final String apiUrl = 'https://68f88645deff18f212b661e3.mockapi.io/todos';

  @override
  void initState() {
    super.initState();
    _fetchTodos();
  }

  // Get todos from API
  Future<void> _fetchTodos() async {
    setState(() {
      isLoading = true;
    });

    try {
      final response = await get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);

        setState(() {
          todos = jsonData.map((json) => Todo.fromJson(json)).toList();
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load todos');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _addTodo(String title) async {
    try {
      final res = await post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'title': title,
          'isCompleted': false,
        })
      );

      if (res.statusCode == 201) {
        _fetchTodos();
        _showSuccessSnackBar('Đã thêm todo');
      } else {
        throw Exception('Failed to add todo');
      }
    } catch (e) {
      _showErrorSnackBar('Lỗi: ${e.toString()}');
    }
  }

  void _deleteTodo(String id) {
    setState(() {
      todos.removeWhere((todo) => todo.id == id);
    });
  }

  void _editTodo(String id, String title) {
    setState(() {
      final todo = todos.firstWhere((todo) => todo.id == id);
      todo.title = title;
    });
  }

  void _showDeleteTodoDialog(String id) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Xóa todo'),
          content: const Text('Bạn có chắc chắn muốn xóa todo này không?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Hủy'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                _deleteTodo(id);
              },
              child: const Text('Xóa'),
            ),
          ],
        );
      },
    );
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

  void _showEditTodoDiaLog(String id, String title) {
    final TextEditingController controller = TextEditingController(text: title);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Chỉnh sửa todo'),
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
                  _editTodo(id, controller.text.trim());
                  Navigator.pop(context);
                  controller.clear();
                }
              },
              child: const Text('Lưu'),
            ),
          ],
        );
      },
    );
  }

  void _showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 3),
      )
    );
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 3),
      )
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
                      onPressed: () => _showEditTodoDiaLog(todo.id, todo.title),
                      icon: Icon(Icons.edit, color: Colors.blue),
                    ),
                    IconButton(
                      onPressed: () => _showDeleteTodoDialog(todo.id),
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
