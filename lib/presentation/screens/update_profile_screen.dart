import 'package:flutter/material.dart';
import 'package:task_manager/presentation/widgets/app_background.dart';
import 'package:task_manager/presentation/widgets/profile_app_bar.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: profileAppBar,
      body: AppBackground(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 32,
                ),
                Text(
                  'Update Profile',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(fontSize: 24),
                ),
                const SizedBox(
                  height: 16,
                ),
                Container(
                  color: Colors.white,
                  height: 50,
                  width: double.infinity,
                  child: InputDecorator(
                    decoration: InputDecoration(
                      //contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                          color: Colors.black, // You can change the color of the border here
                          width: 1.0, // You can adjust the width of the border here
                        ),
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 120,
                          height: 70,
                          color: Colors.black26,
                          child: Center(child: Text('Photo')),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  decoration: const InputDecoration(hintText: 'Email'),
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  decoration: const InputDecoration(hintText: 'First Name'),
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  decoration: const InputDecoration(hintText: 'Last Name'),
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  decoration: const InputDecoration(hintText: 'Mobile'),
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  decoration: const InputDecoration(hintText: 'Password'),
                ),
                const SizedBox(
                  height: 16,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () {},
                      child: const Icon(Icons.arrow_circle_right_outlined)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
