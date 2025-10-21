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
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Todo List'),
          backgroundColor: Colors.brown,
          leading: const IconButton(
            onPressed: null,
            icon: const Icon(Icons.menu),
          ),
          actions: [
            const IconButton(onPressed: null, icon: const Icon(Icons.add)),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Card(
            child: ListTile(
              title: Text('Todo 1'),
              leading: Checkbox(value: false, onChanged: (value) {}),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(onPressed: null, icon: Icon(Icons.edit, color: Colors.blue,)),
                  IconButton(onPressed: null, icon: Icon(Icons.delete, color: Colors.red,))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
