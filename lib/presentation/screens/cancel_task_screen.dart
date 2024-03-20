import 'package:flutter/material.dart';
import 'package:task_manager/presentation/widgets/app_background.dart';
import 'package:task_manager/presentation/widgets/profile_app_bar.dart';
import 'package:task_manager/presentation/widgets/task_card.dart';

class CancelTaskScreen extends StatelessWidget {
  const CancelTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: profileAppBar,
      body: AppBackground(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  return  TaskCard(refreshList: () {  }, taskItem: null,);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
