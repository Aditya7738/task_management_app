import 'package:flutter/material.dart';

class TaskList extends StatelessWidget {
  const TaskList({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text('Task $index'),
              subtitle: Text('Description of task $index'),
              trailing: Icon(Icons.arrow_forward_ios),
            ),
          );
        },
      ),
    );
  }
}
