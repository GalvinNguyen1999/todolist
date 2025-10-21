# 📚 HƯỚNG DẪN LÀM TODO LIST FLUTTER - TỪNG BƯỚC

## 🎯 Mục tiêu
Xây dựng app Todo List từ đầu để hiểu các khái niệm cốt lõi của Flutter

---

## 📋 FLOW TỔNG QUAN

```
BƯỚC 1: Setup cơ bản (MyApp)
   ↓
BƯỚC 2: Tạo Model (Todo class)
   ↓
BƯỚC 3: Tạo StatefulWidget (TodoListPage)
   ↓
BƯỚC 4: Tạo State và danh sách todos
   ↓
BƯỚC 5: Xây dựng UI cơ bản (Scaffold, AppBar)
   ↓
BƯỚC 6: Hiển thị Empty State
   ↓
BƯỚC 7: Hiển thị danh sách todos (ListView)
   ↓
BƯỚC 8: Thêm todo mới (Dialog + TextField)
   ↓
BƯỚC 9: Đánh dấu hoàn thành (Checkbox)
   ↓
BƯỚC 10: Xóa todo
   ↓
BƯỚC 11: Chỉnh sửa todo
   ↓
BƯỚC 12: Hoàn thiện UI
```

---

## 🚀 BƯỚC 1: SETUP CƠ BẢN

**Mục tiêu:** Tạo app Flutter đơn giản nhất

**Khái niệm:** 
- `main()` - Điểm bắt đầu của app
- `StatelessWidget` - Widget không đổi
- `MaterialApp` - Root widget của app

**Code:**

```dart
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
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Todo List'),
        ),
        body: const Center(
          child: Text('Hello Flutter!'),
        ),
      ),
    );
  }
}
```

**Test:** Chạy `flutter run` - Thấy màn hình với chữ "Hello Flutter!"

---

## 🗂️ BƯỚC 2: TẠO MODEL (TODO CLASS)

**Mục tiêu:** Định nghĩa cấu trúc dữ liệu Todo

**Khái niệm:**
- `class` - Tạo kiểu dữ liệu riêng
- `constructor` - Hàm khởi tạo object
- `required` - Tham số bắt buộc
- `default value` - Giá trị mặc định

**Code:** Thêm class này TRƯỚC class MyApp

```dart
class Todo {
  String title;
  bool isCompleted;

  Todo({
    required this.title,
    this.isCompleted = false,
  });
}
```

**Giải thích:**
- `String title` - Tên công việc
- `bool isCompleted` - Đã hoàn thành chưa? (true/false)
- `required this.title` - Bắt buộc phải có title
- `this.isCompleted = false` - Mặc định chưa hoàn thành

**Test tạo Todo:**
```dart
Todo todo1 = Todo(title: 'Làm bài tập');
print(todo1.title);        // "Làm bài tập"
print(todo1.isCompleted);  // false
```

---

## 🏗️ BƯỚC 3: TẠO STATEFULWIDGET

**Mục tiêu:** Tạo widget có thể thay đổi state

**Khái niệm:**
- `StatefulWidget` - Widget có state thay đổi
- `State<T>` - Class chứa dữ liệu và logic
- `createState()` - Tạo State object

**Code:** Thay thế phần `home:` trong MaterialApp

```dart
// Trong MaterialApp
home: const TodoListPage(),

// Thêm 2 class này ở cuối file:

class TodoListPage extends StatefulWidget {
  const TodoListPage({super.key});

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: const Center(
        child: Text('Todo List Page'),
      ),
    );
  }
}
```

**Test:** Chạy lại - Thấy "Todo List Page"

---

## 📦 BƯỚC 4: TẠO STATE VÀ DANH SÁCH TODOS

**Mục tiêu:** Lưu trữ danh sách todos trong State

**Khái niệm:**
- `List<T>` - Danh sách (mảng)
- `final` - Biến không thể gán lại
- `TextEditingController` - Quản lý input text

**Code:** Thêm vào trong class `_TodoListPageState`

```dart
class _TodoListPageState extends State<TodoListPage> {
  // Danh sách todos
  final List<Todo> _todos = [];
  
  // Controller cho TextField
  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // ... code cũ
  }
  
  // Dọn dẹp khi widget bị hủy
  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }
}
```

**Giải thích:**
- `_todos` - Dấu `_` nghĩa là private (chỉ dùng trong file này)
- `_textController` - Dùng để lấy text từ TextField
- `dispose()` - Dọn dẹp tài nguyên khi không dùng nữa

---

## 🎨 BƯỚC 5: XÂY DỰNG UI CƠ BẢN

**Mục tiêu:** Tạo layout cơ bản với AppBar và FloatingActionButton

**Khái niệm:**
- `Scaffold` - Bộ khung cơ bản
- `AppBar` - Thanh tiêu đề
- `FloatingActionButton` - Nút tròn góc dưới

**Code:** Cập nhật hàm `build()` trong `_TodoListPageState`

```dart
@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text('Todo List'),
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      actions: [
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              '0/${_todos.length}',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    ),
    body: Center(
      child: Text('Có ${_todos.length} công việc'),
    ),
    floatingActionButton: FloatingActionButton(
      onPressed: () {
        print('Pressed!'); // Test xem nút có hoạt động không
      },
      tooltip: 'Thêm Todo',
      child: const Icon(Icons.add),
    ),
  );
}
```

**Test:** Nhấn nút + và xem console có "Pressed!" không

---

## 🎭 BƯỚC 6: HIỂN THỊ EMPTY STATE

**Mục tiêu:** Hiển thị thông báo khi chưa có todo

**Khái niệm:**
- Conditional rendering (`? :`)
- `Column` - Sắp xếp theo chiều dọc
- `SizedBox` - Khoảng cách

**Code:** Tạo hàm mới trong `_TodoListPageState`

```dart
// Thêm hàm này
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

// Cập nhật body trong build():
@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(...),
    body: _todos.isEmpty 
        ? _buildEmptyState()  // Nếu rỗng, hiển thị empty state
        : Text('Có ${_todos.length} todos'),  // Nếu có, hiển thị số lượng
    floatingActionButton: FloatingActionButton(...),
  );
}
```

**Test:** Chạy lại - Thấy icon và text "Chưa có công việc nào"

---

## 📜 BƯỚC 7: HIỂN THỊ DANH SÁCH TODOS

**Mục tiêu:** Hiển thị danh sách todos động

**Khái niệm:**
- `ListView.builder` - Tạo list động
- `itemBuilder` - Hàm tạo từng item
- `Card` & `ListTile` - UI component

**Code:** Thêm 2 hàm mới

```dart
// Hàm 1: Build danh sách
Widget _buildTodoList() {
  return ListView.builder(
    itemCount: _todos.length,
    padding: const EdgeInsets.all(8),
    itemBuilder: (context, index) {
      return _buildTodoItem(index);
    },
  );
}

// Hàm 2: Build từng todo item
Widget _buildTodoItem(int index) {
  final todo = _todos[index];
  
  return Card(
    margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
    elevation: 2,
    child: ListTile(
      title: Text(
        todo.title,
        style: const TextStyle(fontSize: 16),
      ),
    ),
  );
}

// Cập nhật body:
body: _todos.isEmpty 
    ? _buildEmptyState()
    : _buildTodoList(),  // Hiển thị danh sách
```

**Test tạm thời:** Thêm dữ liệu mẫu để test

```dart
// Trong class _TodoListPageState, thêm:
final List<Todo> _todos = [
  Todo(title: 'Làm bài tập'),
  Todo(title: 'Đi chợ'),
  Todo(title: 'Nấu cơm'),
];
```

**Test:** Chạy lại - Thấy 3 todo items

---

## ➕ BƯỚC 8: THÊM TODO MỚI

**Mục tiêu:** Tạo dialog để thêm todo

**Khái niệm:**
- `showDialog()` - Hiển thị popup
- `AlertDialog` - Dialog chuẩn Material
- `TextField` - Ô nhập text
- `setState()` - Cập nhật UI

**Code:** Thêm 2 hàm mới

```dart
// Hàm 1: Thêm todo vào list
void _addTodo() {
  if (_textController.text.isNotEmpty) {
    setState(() {
      _todos.add(Todo(title: _textController.text));
      _textController.clear();
    });
  }
}

// Hàm 2: Hiển thị dialog
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

// Cập nhật FloatingActionButton:
floatingActionButton: FloatingActionButton(
  onPressed: _showAddTodoDialog,  // Gọi hàm này
  tooltip: 'Thêm Todo',
  child: const Icon(Icons.add),
),
```

**Xóa dữ liệu test:**
```dart
final List<Todo> _todos = [];  // Để rỗng
```

**Test:** 
1. Nhấn nút + 
2. Nhập text
3. Nhấn "Thêm"
4. Thấy todo xuất hiện trong list!

---

## ✅ BƯỚC 9: ĐÁNH DẤU HOÀN THÀNH

**Mục tiêu:** Thêm checkbox để đánh dấu hoàn thành

**Khái niệm:**
- `Checkbox` widget
- `TextDecoration.lineThrough` - Gạch ngang text
- Conditional styling

**Code:** Thêm hàm toggle và cập nhật UI

```dart
// Hàm toggle trạng thái
void _toggleTodoStatus(int index) {
  setState(() {
    _todos[index].isCompleted = !_todos[index].isCompleted;
  });
}

// Cập nhật _buildTodoItem():
Widget _buildTodoItem(int index) {
  final todo = _todos[index];
  
  return Card(
    margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
    elevation: 2,
    child: ListTile(
      leading: Checkbox(
        value: todo.isCompleted,
        onChanged: (_) => _toggleTodoStatus(index),
      ),
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
      onTap: () => _toggleTodoStatus(index),
    ),
  );
}
```

**Cập nhật AppBar để hiển thị số đã hoàn thành:**

```dart
appBar: AppBar(
  title: const Text('Todo List'),
  backgroundColor: Theme.of(context).colorScheme.inversePrimary,
  actions: [
    Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Text(
          '${_todos.where((todo) => todo.isCompleted).length}/${_todos.length}',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ),
  ],
),
```

**Test:**
1. Thêm vài todos
2. Nhấn checkbox
3. Thấy text bị gạch ngang và đổi màu xám
4. AppBar hiển thị "1/3" (1 hoàn thành / 3 tổng)

---

## 🗑️ BƯỚC 10: XÓA TODO

**Mục tiêu:** Thêm nút xóa cho mỗi todo

**Khái niệm:**
- `IconButton` - Nút với icon
- `List.removeAt()` - Xóa phần tử khỏi list

**Code:** Thêm hàm xóa và cập nhật UI

```dart
// Hàm xóa
void _deleteTodo(int index) {
  setState(() {
    _todos.removeAt(index);
  });
}

// Cập nhật _buildTodoItem() - thêm trailing:
Widget _buildTodoItem(int index) {
  final todo = _todos[index];
  
  return Card(
    margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
    elevation: 2,
    child: ListTile(
      leading: Checkbox(
        value: todo.isCompleted,
        onChanged: (_) => _toggleTodoStatus(index),
      ),
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
      onTap: () => _toggleTodoStatus(index),
      trailing: IconButton(
        icon: const Icon(Icons.delete, color: Colors.red),
        onPressed: () => _deleteTodo(index),
      ),
    ),
  );
}
```

**Test:**
1. Tạo vài todos
2. Nhấn icon thùng rác đỏ
3. Todo biến mất!

---

## ✏️ BƯỚC 11: CHỈNH SỬA TODO

**Mục tiêu:** Thêm nút edit để sửa todo

**Khái niệm:**
- Reuse dialog cho nhiều mục đích
- `Row` widget - Sắp xếp ngang

**Code:** Thêm hàm edit

```dart
// Hàm edit
void _editTodo(int index) {
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

// Cập nhật _buildTodoItem() - thay trailing bằng Row:
trailing: Row(
  mainAxisSize: MainAxisSize.min,
  children: [
    IconButton(
      icon: const Icon(Icons.edit, color: Colors.blue),
      onPressed: () => _editTodo(index),
      tooltip: 'Chỉnh sửa',
    ),
    IconButton(
      icon: const Icon(Icons.delete, color: Colors.red),
      onPressed: () => _deleteTodo(index),
      tooltip: 'Xóa',
    ),
  ],
),
```

**Test:**
1. Tạo todo
2. Nhấn icon bút chì xanh
3. Sửa text
4. Nhấn "Lưu"
5. Thấy todo cập nhật!

---

## 🎨 BƯỚC 12: HOÀN THIỆN

**Mục tiêu:** Refactor và thêm comments

**Code cuối cùng hoàn chỉnh:** Xem file `lib/main.dart`

**Checklist hoàn thiện:**
- ✅ Thêm todo mới
- ✅ Hiển thị danh sách
- ✅ Đánh dấu hoàn thành
- ✅ Xóa todo
- ✅ Chỉnh sửa todo
- ✅ Empty state
- ✅ UI đẹp mắt

---

## 🎯 KIỂM TRA HIỂU BIẾT

Sau khi làm xong, hãy tự hỏi:

1. **StatelessWidget vs StatefulWidget:** Khác nhau như thế nào?
2. **setState():** Tại sao phải gọi hàm này?
3. **ListView.builder:** Lợi ích so với ListView thường?
4. **TextEditingController:** Dùng để làm gì?
5. **dispose():** Tại sao cần dọn dẹp?

---

## 🚀 THÁCH THỨC THÊM

Nếu em muốn học thêm:

### Level 1 (Dễ):
- [ ] Thêm timestamp cho mỗi todo
- [ ] Đếm số todo chưa hoàn thành
- [ ] Thêm màu sắc khác nhau cho từng todo

### Level 2 (Trung bình):
- [ ] Lưu todos vào SharedPreferences (lưu trữ local)
- [ ] Thêm category cho todo (Công việc, Cá nhân, Mua sắm)
- [ ] Thêm filter (Tất cả, Đã xong, Chưa xong)
- [ ] Thêm search bar

### Level 3 (Khó):
- [ ] Sắp xếp todos (drag & drop)
- [ ] Thêm due date với DatePicker
- [ ] Animation khi thêm/xóa
- [ ] Dark mode

---

## 📚 TÀI LIỆU THAM KHẢO

- [Flutter Documentation](https://docs.flutter.dev/)
- [Dart Language Tour](https://dart.dev/guides/language/language-tour)
- [Flutter Widget Catalog](https://docs.flutter.dev/development/ui/widgets)

---

## 💡 MẸO HỌC TỐT

1. **Đừng copy-paste:** Gõ từng dòng code bằng tay
2. **Thử nghiệm:** Đổi màu, text, thêm widget mới
3. **Debug:** Dùng `print()` để hiểu flow
4. **Hot Reload:** Lợi dụng tối đa để test nhanh
5. **Đọc errors:** Học từ lỗi là cách học nhanh nhất

---

**Chúc em học tốt! 🎉**

Nếu gặp khó khăn ở bước nào, cứ hỏi anh nhé!

