import 'package:flutter/material.dart';
import 'package:task_manager/app.dart';
import 'package:task_manager/presentation/controllers/auth_controller.dart';
import 'package:task_manager/presentation/screens/auth/sign_in_screen.dart';
import 'package:task_manager/presentation/screens/update_profile_screen.dart';
import 'package:task_manager/presentation/utils/app_colors.dart';

PreferredSizeWidget get profileAppBar {
  return AppBar(
    automaticallyImplyLeading: false,
    backgroundColor: AppColors.themeColor,
    title: InkWell(
      onTap: () {
        // Get the current route name
        String currentRoute = TaskManager
            .navigatorKey.currentState!.context.widget.runtimeType
            .toString();

        // Check if the current route is not UpdateProfileScreen
        if (currentRoute != 'UpdateProfileScreen') {
          Navigator.push(
            TaskManager.navigatorKey.currentState!.context,
            MaterialPageRoute(
              builder: (context) => const UpdateProfileScreen(),
            ),
          );
        }
      },
      child: Row(
        children: [
          const CircleAvatar(),
          const SizedBox(
            width: 12,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AuthController.userData?.fullName ?? '',
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      ),
                ),
                Text(AuthController.userData?.email ?? '',
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w400)),
              ],
            ),
          ),
          IconButton(
            onPressed: () async {
              await AuthController.clearUserData();
              Navigator.pushAndRemoveUntil(
                  TaskManager.navigatorKey.currentState!.context,
                  MaterialPageRoute(
                    builder: (context) => const SignInScreen(),
                  ),
                  (route) => false);
            },
            icon: const Icon(Icons.logout_outlined),
          )
        ],
      ),
    ),
  );
}
