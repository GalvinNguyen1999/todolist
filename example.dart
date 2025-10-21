import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// KHÁI NIỆM 1: StatelessWidget - Widget không có state thay đổi
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo List App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue, // Thử đổi màu này để test Hot Reload
        useMaterial3: true,
      ),
      home: const TodoListPage(),
    );
  }
}

// KHÁI NIỆM 2: Model - Cấu trúc dữ liệu để lưu thông tin Todo
class Todo {
  String title;
  bool isCompleted;

  Todo({
    required this.title,
    this.isCompleted = false,
  });
}

// KHÁI NIỆM 3: StatefulWidget - Widget có state thay đổi được
class TodoListPage extends StatefulWidget {
  const TodoListPage({super.key});

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

// KHÁI NIỆM 4: State - Nơi chứa dữ liệu và logic của StatefulWidget
class _TodoListPageState extends State<TodoListPage> {
  // Danh sách các todo items
  final List<Todo> _todos = [];
  
  // Controller để lấy text từ TextField
  final TextEditingController _textController = TextEditingController();

  // KHÁI NIỆM 5: setState() - Hàm để cập nhật UI khi dữ liệu thay đổi
  void _addTodo() {
    if (_textController.text.isNotEmpty) {
      setState(() {
        _todos.add(Todo(title: _textController.text));
        _textController.clear();
      });
    }
  }

  void _toggleTodoStatus(int index) {
    setState(() {
      _todos[index].isCompleted = !_todos[index].isCompleted;
    });
  }

  void _deleteTodo(int index) {
    setState(() {
      _todos.removeAt(index);
    });
  }

  void _editTodo(int index) {
    // Set text hiện tại vào controller
    _textController.text = _todos[index].title;
    
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Chỉnh sửa Todo'),
          content: TextField(
            controller: _textController,
            decoration: const InputDecoration(
              hintText: 'Nhập công việc...',
              border: OutlineInputBorder(),
            ),
            autofocus: true,
            onSubmitted: (_) {
              if (_textController.text.isNotEmpty) {
                setState(() {
                  _todos[index].title = _textController.text;
                  _textController.clear();
                });
                Navigator.pop(context);
              }
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _textController.clear();
              },
              child: const Text('Hủy'),
            ),
            ElevatedButton(
              onPressed: () {
                if (_textController.text.isNotEmpty) {
                  setState(() {
                    _todos[index].title = _textController.text;
                    _textController.clear();
                  });
                  Navigator.pop(context);
                }
              },
              child: const Text('Lưu'),
            ),
          ],
        );
      },
    );
  }

  // KHÁI NIỆM 6: Dialog - Hiển thị popup để thêm todo
  void _showAddTodoDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Thêm Todo mới'),
          content: TextField(
            controller: _textController,
            decoration: const InputDecoration(
              hintText: 'Nhập công việc...',
              border: OutlineInputBorder(),
            ),
            autofocus: true,
            onSubmitted: (_) {
              _addTodo();
              Navigator.pop(context);
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _textController.clear();
              },
              child: const Text('Hủy'),
            ),
            ElevatedButton(
              onPressed: () {
                _addTodo();
                Navigator.pop(context);
              },
              child: const Text('Thêm'),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    // Dọn dẹp controller khi widget bị destroy
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Tính toán số lượng todo đã hoàn thành
    int completedCount = _todos.where((todo) => todo.isCompleted).length;
    
    return Scaffold(
      // AppBar - Thanh tiêu đề trên cùng
      appBar: AppBar(
        title: const Text('Todo List'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        elevation: 2,
        actions: [
          // Hiển thị thống kê
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                '$completedCount/${_todos.length}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
      
      // Body - Nội dung chính
      body: _todos.isEmpty
          ? _buildEmptyState()
          : _buildTodoList(),
      
      // FloatingActionButton - Nút để thêm todo
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddTodoDialog,
        tooltip: 'Thêm Todo',
        child: const Icon(Icons.add),
      ),
    );
  }

  // Widget hiển thị khi danh sách rỗng
  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.checklist,
            size: 100,
            color: Colors.grey[300],
          ),
          const SizedBox(height: 16),
          Text(
            'Chưa có công việc nào',
            style: TextStyle(
              fontSize: 20,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Nhấn nút + để thêm công việc mới',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }

  // KHÁI NIỆM 7: ListView.builder - Hiển thị danh sách động
  Widget _buildTodoList() {
    return ListView.builder(
      itemCount: _todos.length,
      padding: const EdgeInsets.all(8),
      itemBuilder: (context, index) {
        return _buildTodoItem(index);
      },
    );
  }

  // Widget hiển thị từng todo item
  Widget _buildTodoItem(int index) {
    final todo = _todos[index];
    
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      elevation: 2,
      child: ListTile(
        // KHÁI NIỆM 8: Checkbox - Widget để đánh dấu hoàn thành
        leading: Checkbox(
          value: todo.isCompleted,
          onChanged: (_) => _toggleTodoStatus(index),
        ),
        
        // Hiển thị tiêu đề với style khác nhau tùy trạng thái
        title: Text(
          todo.title,
          style: TextStyle(
            decoration: todo.isCompleted 
                ? TextDecoration.lineThrough 
                : null,
            color: todo.isCompleted 
                ? Colors.grey 
                : Colors.black,
            fontSize: 16,
          ),
        ),
        
        // KHÁI NIỆM 9: GestureDetector - Xử lý sự kiện chạm
        onTap: () => _toggleTodoStatus(index),
        
        // Các nút hành động
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Nút chỉnh sửa
            IconButton(
              icon: const Icon(Icons.edit, color: Colors.blue),
              onPressed: () => _editTodo(index),
              tooltip: 'Chỉnh sửa',
            ),
            // Nút xóa
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () => _deleteTodo(index),
              tooltip: 'Xóa',
            ),
          ],
        ),
      ),
    );
  }
}
