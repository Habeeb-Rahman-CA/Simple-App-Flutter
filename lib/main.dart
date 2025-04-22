import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: TodoScreen());
  }
}

class TodoScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  final _controller = TextEditingController();

  List<String> _task = [];

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
                      trailing: IconButton(
                        onPressed: () => _deleteTask(index),
                        icon: Icon(Icons.delete),
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
