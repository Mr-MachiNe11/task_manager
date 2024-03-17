import 'package:flutter/material.dart';
import 'package:task_manager/presentation/screens/cancel_task_screen.dart';
import 'package:task_manager/presentation/screens/complete_task_screen.dart';
import 'package:task_manager/presentation/screens/new_task_screen.dart';
import 'package:task_manager/presentation/screens/progress_task_screen.dart';
import 'package:task_manager/presentation/utils/app_colors.dart';

class BottomNavScreen extends StatefulWidget {
  const BottomNavScreen({super.key});

  @override
  State<BottomNavScreen> createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  int _currentSelectedIndex = 0;

  final List<Widget> _screen = [
    const NewTaskScreen(),
    const CompleteTaskScreen(),
    const ProgressTaskScreen(),
    const CancelTaskScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screen[_currentSelectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: AppColors.themeColor,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        currentIndex: _currentSelectedIndex,
        onTap: (index) {
          _currentSelectedIndex = index;
          if (mounted) {
            setState(() {});
          }
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.file_copy_outlined), label: 'New Task'),
          BottomNavigationBarItem(
              icon: Icon(Icons.done_all_outlined), label: 'Completed'),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_balance_outlined), label: 'Progress'),
          BottomNavigationBarItem(
              icon: Icon(Icons.close_rounded), label: 'Cancelled')
        ],
      ),
    );
  }
}
