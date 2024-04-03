import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task_manager/data/models/user_data.dart';
import 'package:task_manager/data/services/network_caller.dart';
import 'package:task_manager/data/utility/urls.dart';
import 'package:task_manager/presentation/controllers/auth_controller.dart';
import 'package:task_manager/presentation/screens/bottom_nav_screen.dart';
import 'package:task_manager/presentation/widgets/app_background.dart';
import 'package:task_manager/presentation/widgets/profile_app_bar.dart';
import 'package:task_manager/presentation/widgets/snack_bar_message.dart';

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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  XFile? _pickedImage;
  bool _updateProfileInProgress = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _emailController.text = AuthController.userData?.email ?? '';
    _firstNameController.text = AuthController.userData?.firstName ?? '';
    _lastNameController.text = AuthController.userData?.lastName ?? '';
    _mobileController.text = AuthController.userData?.mobile ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: profileAppBar,
      body: AppBackground(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 32,
                  ),
                  Text(
                    'Update Profile',
                    style: Theme
                        .of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(fontSize: 24),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  imagePickerButton(),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(hintText: 'Email'),
                    enabled: false,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    controller: _firstNameController,
                    decoration: const InputDecoration(hintText: 'First Name'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter your first name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    controller: _lastNameController,
                    decoration: const InputDecoration(hintText: 'Last Name'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter your last name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    controller: _mobileController,
                    decoration: const InputDecoration(hintText: 'Mobile'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter your mobile number';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    controller: _passwordController,
                    decoration: const InputDecoration(hintText: 'Password'),
                    /*validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter your password';
                      }
                      return null;
                    },*/
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Visibility(
                      visible: _updateProfileInProgress == false,
                      replacement: const Center(
                          child: CircularProgressIndicator()),
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _updateProfile();
                          }
                        },
                        child: const Icon(Icons.arrow_circle_right_outlined),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget imagePickerButton() {
    return GestureDetector(
      onTap: () {
        _pickImageFromGallery();
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            width: 1,
            color: Colors.black,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  bottomLeft: Radius.circular(8),
                ),
                color: Colors.black54,
              ),
              child: const Text(
                'Photo',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            Expanded(
              child: Text(
                _pickedImage?.name ?? '',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickImageFromGallery() async {
    ImagePicker imagePicker = ImagePicker();
    _pickedImage = await imagePicker.pickImage(source: ImageSource.camera);
    setState(() {});
  }

  Future<void> _updateProfile() async {
    String? photo;
    _updateProfileInProgress = true;
    setState(() {});

    Map<String, dynamic> inputParams = {
      "email": _emailController.text,
      "firstName": _firstNameController.text.trim(),
      "lastName": _lastNameController.text.trim(),
      "mobile": _mobileController.text.trim(),
    };

    if (_passwordController.text.isNotEmpty) {
      inputParams['password'] = _passwordController.text;
    }
    if (_pickedImage != null) {
      List<int> bytes = File(_pickedImage!.path).readAsBytesSync();
      photo = base64UrlEncode(bytes);
      inputParams['photo'] = photo;
    }

    final response =
    await NetworkCaller.postRequest(Urls.updateProfile, inputParams);

    _updateProfileInProgress = false;
    if (response.isSuccess) {
      if (response.responseBody['status'] == 'success') {
        UserData userData = UserData(
            email: _emailController.text,
            firstName: _firstNameController.text.trim(),
            lastName: _lastNameController.text.trim(),
            mobile: _mobileController.text.trim(),
            photo: photo);
        await AuthController.saveUserData(userData);
      }
      setState(() {});
      if (mounted) {
        Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (context) => const BottomNavScreen(),), (
                route) => false);
      }
    } else {
      setState(() {});
      if (mounted) {
        showSnackBarMessage(
            context, response.errorMessage ?? 'Update failed, try again!');
      }
    }
  }
}
