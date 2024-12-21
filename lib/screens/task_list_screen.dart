import 'package:flutter/material.dart';
import '../models/task.dart';

class TaskListScreen extends StatefulWidget {
  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  List<Task> tasks = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task Management'),
      ),
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              title: Text(tasks[index].title),
              subtitle: Text(tasks[index].description),
              trailing: Chip(
                label: Text(tasks[index].status),
                backgroundColor: _getStatusColor(tasks[index].status),
              ),
              onTap: () {
                Navigator.pushNamed(
                  context,
                  '/taskDetail',
                  arguments: tasks[index],
                ).then((_) => setState(() {}));
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, '/createTask')
              .then((_) => setState(() {}));
        },
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'To-Do':
        return Colors.grey;
      case 'In-Progress':
        return Colors.blue;
      case 'Done':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }
}