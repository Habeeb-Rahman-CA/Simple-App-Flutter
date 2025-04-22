import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: TodoScreen());
  }
}

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<StatefulWidget> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  final _controller = TextEditingController();

  final List<String> _task = [];

  void _addTask() {
    if (_controller.text.trim().isNotEmpty) {
      setState(() {
        _task.add(_controller.text.trim());
        _controller.text = '';
      });
    }
  }

  void _deleteTask(int index) {
    setState(() {
      _task.removeAt(index);
    });
  }

  void _editTask(int index) {
    _controller.text = _task[index];
    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            title: Text("Edit Task"),
            content: TextField(
              controller: _controller,
              autofocus: true,
              decoration: InputDecoration(hintText: 'Update Task'),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  _controller.clear();
                },
                child: Text('cancel'),
              ),
              ElevatedButton(
                onPressed: () {
                  if (_controller.text.trim().isNotEmpty) {
                    setState(() {
                      _task[index] = _controller.text.trim();
                      _controller.clear();
                    });
                    Navigator.pop(context);
                  }
                },
                child: Text('Update'),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Todo App')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(hintText: 'Enter a Task'),
                  ),
                ),
                IconButton(onPressed: _addTask, icon: Icon(Icons.add)),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _task.length,
                itemBuilder:
                    (_, index) => ListTile(
                      title: Text(_task[index]),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () => _deleteTask(index),
                            icon: Icon(Icons.delete),
                          ),
                          IconButton(
                            onPressed: () => _editTask(index),
                            icon: Icon(Icons.edit),
                          ),
                        ],
                      ),
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
