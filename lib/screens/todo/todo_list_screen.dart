import 'package:flutter/material.dart';
import '../../models/todo.dart';
import '../../services/todo_api_service.dart';
import '../../widgets/common/loading_indicator.dart';
import 'widgets/todo_item.dart';
import 'widgets/todo_empty_state.dart';
import 'widgets/dialogs/add_todo_dialog.dart';
import 'widgets/dialogs/edit_todo_dialog.dart';
import 'widgets/dialogs/delete_todo_dialog.dart';

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({super.key});

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  final TodoApiService _apiService = TodoApiService();
  List<Todo> todos = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadTodos();
  }

  // Load todos từ API
  Future<void> _loadTodos() async {
    setState(() => isLoading = true);

    try {
      final fetchedTodos = await _apiService.fetchTodos();
      setState(() {
        todos = fetchedTodos;
        isLoading = false;
      });
    } catch (e) {
      setState(() => isLoading = false);
      _showErrorSnackBar('Không thể tải dữ liệu: $e');
    }
  }

  // Thêm todo
  Future<void> _addTodo(String title) async {
    try {
      await _apiService.addTodo(title);
      _loadTodos(); // Refresh
      _showSuccessSnackBar('Đã thêm todo!');
    } catch (e) {
      _showErrorSnackBar('Không thể thêm todo: $e');
    }
  }

  // Sửa todo
  Future<void> _editTodo(String id, String newTitle) async {
    try {
      await _apiService.updateTodo(id, newTitle);
      _loadTodos(); // Refresh
      _showSuccessSnackBar('Đã cập nhật todo!');
    } catch (e) {
      _showErrorSnackBar('Không thể cập nhật: $e');
    }
  }

  // Toggle complete
  Future<void> _toggleTodo(Todo todo) async {
    try {
      await _apiService.toggleTodoComplete(todo.id, todo.isCompleted);
      _loadTodos(); // Refresh
    } catch (e) {
      _showErrorSnackBar('Không thể cập nhật trạng thái: $e');
    }
  }

  // Xóa todo
  Future<void> _deleteTodo(String id) async {
    try {
      await _apiService.deleteTodo(id);
      _loadTodos(); // Refresh
      _showSuccessSnackBar('Đã xóa todo!');
    } catch (e) {
      _showErrorSnackBar('Không thể xóa: $e');
    }
  }

  // Show dialogs
  void _showAddDialog() {
    showDialog(
      context: context,
      builder: (context) => AddTodoDialog(onAdd: _addTodo),
    );
  }

  void _showEditDialog(String id, String currentTitle) {
    showDialog(
      context: context,
      builder: (context) => EditTodoDialog(
        currentTitle: currentTitle,
        onEdit: (newTitle) => _editTodo(id, newTitle),
      ),
    );
  }

  void _showDeleteDialog(String id) {
    showDialog(
      context: context,
      builder: (context) => DeleteTodoDialog(
        onDelete: () => _deleteTodo(id),
      ),
    );
  }

  // SnackBars
  void _showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List'),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            onPressed: _loadTodos,
            icon: const Icon(Icons.refresh),
            tooltip: 'Refresh',
          ),
          IconButton(
            onPressed: _showAddDialog,
            icon: const Icon(Icons.add),
            tooltip: 'Thêm todo',
          ),
        ],
      ),
      body: isLoading
          ? const LoadingIndicator(message: 'Đang tải todos...')
          : todos.isEmpty
              ? const TodoEmptyState()
              : Padding(
                  padding: const EdgeInsets.all(16),
                  child: ListView.builder(
                    itemCount: todos.length,
                    itemBuilder: (context, index) {
                      final todo = todos[index];
                      return TodoItem(
                        todo: todo,
                        onToggle: () => _toggleTodo(todo),
                        onEdit: () => _showEditDialog(todo.id, todo.title),
                        onDelete: () => _showDeleteDialog(todo.id),
                      );
                    },
                  ),
                ),
    );
  }
}
