import 'package:flutter/material.dart';

class TaskDetails extends StatelessWidget {
  const TaskDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task Details'),
      ),
      body: Column(
        children: <Widget>[
          Text(
            'Task Details',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Icon(Icons.title),
                  Text(
                    'Status',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
              SizedBox(
                width: 20,
              ),
              Text(
                'Completed',
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
