import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:task_manager/app.dart';
import 'package:task_manager/presentation/controllers/auth_controller.dart';
import 'package:task_manager/presentation/screens/auth/sign_in_screen.dart';
import 'package:task_manager/presentation/screens/update_profile_screen.dart';
import 'package:task_manager/presentation/utils/app_colors.dart';

PreferredSizeWidget get profileAppBar {
  final userData = AuthController.userData;

  return AppBar(
    automaticallyImplyLeading: false,
    backgroundColor: AppColors.themeColor,
    title: GestureDetector(
      onTap: () {
        Navigator.push(
            TaskManager.navigatorKey.currentState!.context,
            MaterialPageRoute(
                builder: (context) => const UpdateProfileScreen()));
      },
      child: Row(
        children: [
          if (userData != null && userData.photo != null) // Add null check here
            CircleAvatar(
              backgroundImage: MemoryImage(base64Decode(userData.photo!)),
            ),
          const SizedBox(
            width: 12,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  userData?.fullName ?? '',
                  style: const TextStyle(fontSize: 16, color: Colors.white),
                ),
                Text(
                  userData?.email ?? '',
                  style: const TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                      fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ),
          IconButton(
              onPressed: () async {
                await AuthController.clearUserData();
                Navigator.pushAndRemoveUntil(
                    TaskManager.navigatorKey.currentState!.context,
                    MaterialPageRoute(builder: (context) => const SignInScreen()),
                        (route) => false);
              },
              icon: const Icon(Icons.logout))
        ],
      ),
    ),
  );
}

