import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import '../models/task.dart';

class TaskDetailScreen extends StatefulWidget {
  @override
  _TaskDetailScreenState createState() => _TaskDetailScreenState();
}

class _TaskDetailScreenState extends State<TaskDetailScreen> {
  final List<String> statusOptions = ['To-Do', 'In-Progress', 'Done'];

  Future<void> sendEmail(String status) async {
    // Configure your email settings here
    final smtpServer = gmail('your-email@gmail.com', 'your-password');
    
    final message = Message()
      ..from = Address('your-email@gmail.com', 'Task Management')
      ..recipients.add('user@example.com')
      ..subject = 'Task Status Update'
      ..text = 'Task status has been updated to: $status';

    try {
      await send(message, smtpServer);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Status update email sent')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to send email notification')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final task = ModalRoute.of(context)!.settings.arguments as Task;

    return Scaffold(
      appBar: AppBar(
        title: Text('Task Details'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Title',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(task.title),
            SizedBox(height: 16),
            Text(
              'Description',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(task.description),
            SizedBox(height: 16),
            Text(
              'Status',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            DropdownButton<String>(
              value: task.status,
              items: statusOptions.map((String status) {
                return DropdownMenuItem<String>(
                  value: status,
                  child: Text(status),
                );
              }).toList(),
              onChanged: (String? newValue) async {
                if (newValue != null) {
                  setState(() {
                    task.status = newValue;
                  });
                  await sendEmail(newValue);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
