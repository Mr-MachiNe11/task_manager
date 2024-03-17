import 'package:flutter/material.dart';

class TaskCard extends StatelessWidget {
  const TaskCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.symmetric(vertical: 4,horizontal: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Title',style: TextStyle(fontWeight: FontWeight.bold),),
            const Text('Description'),
            const Text('Date'),
            Row(
              children: [
                const Chip(label: Text('New')),
                const Spacer(),
                IconButton(
                  onPressed: () {
                    // Add onPressed functionality
                  },
                  icon: const Icon(Icons.edit),
                ),
                IconButton(
                  onPressed: () {
                    // Add onPressed functionality
                  },
                  icon: const Icon(Icons.delete_outline),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
