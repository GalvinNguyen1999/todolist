import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/todo.dart';
import '../config/constants.dart';

class TodoApiService {
  // GET - Lấy tất cả todos
  Future<List<Todo>> fetchTodos() async {
    print('🚀 Fetching todos from API...');
    print('📍 URL: ${AppConstants.todosEndpoint}');

    final response = await http.get(Uri.parse(AppConstants.todosEndpoint));

    print('📊 Status: ${response.statusCode}');

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      print('✅ Fetched ${jsonData.length} todos');
      return jsonData.map((json) => Todo.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load todos');
    }
  }

  // POST - Thêm todo mới
  Future<Todo> addTodo(String title) async {
    print('📝 Adding new todo: $title');

    final response = await http.post(
      Uri.parse(AppConstants.todosEndpoint),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'title': title,
        'isCompleted': false,
      }),
    );

    if (response.statusCode == 201) {
      print('✅ Todo added successfully');
      return Todo.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to add todo');
    }
  }

  // PUT - Sửa todo
  Future<Todo> updateTodo(String id, String newTitle) async {
    print('✏️ Updating todo $id: $newTitle');

    final response = await http.put(
      Uri.parse('${AppConstants.todosEndpoint}/$id'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'title': newTitle}),
    );

    if (response.statusCode == 200) {
      print('✅ Todo updated successfully');
      return Todo.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to update todo');
    }
  }

  // PUT - Toggle isCompleted
  Future<Todo> toggleTodoComplete(String id, bool isCompleted) async {
    print('🔄 Toggling todo $id: $isCompleted');

    final response = await http.put(
      Uri.parse('${AppConstants.todosEndpoint}/$id'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'isCompleted': !isCompleted}),
    );

    if (response.statusCode == 200) {
      print('✅ Todo toggled successfully');
      return Todo.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to toggle todo');
    }
  }

  // DELETE - Xóa todo
  Future<void> deleteTodo(String id) async {
    print('🗑️ Deleting todo $id');

    final response =
        await http.delete(Uri.parse('${AppConstants.todosEndpoint}/$id'));

    if (response.statusCode == 200) {
      print('✅ Todo deleted successfully');
    } else {
      throw Exception('Failed to delete todo');
    }
  }
}
