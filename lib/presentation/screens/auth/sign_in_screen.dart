//sign_in_screen
import 'package:flutter/material.dart';
import 'package:task_manager/data/models/login_response.dart';
import 'package:task_manager/data/models/response_object.dart';
import 'package:task_manager/data/services/network_caller.dart';
import 'package:task_manager/data/utility/urls.dart';
import 'package:task_manager/presentation/controllers/auth_controller.dart';
import 'package:task_manager/presentation/screens/auth/email_verification_screen.dart';
import 'package:task_manager/presentation/screens/auth/sign_up_screen.dart';
import 'package:task_manager/presentation/screens/bottom_nav_screen.dart';
import 'package:task_manager/presentation/widgets/app_background.dart';
import 'package:task_manager/presentation/widgets/snack_bar_message.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isLoginInProgress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBackground(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 100),
                  Text(
                    'Get Started With',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      hintText: 'Email',
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter your mobile number';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.visiblePassword,
                    controller: _passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      hintText: 'Password',
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter your mobile number';
                      }
                      if (value.length <= 6) {
                        return 'Password must be at least 6 characters long';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Visibility(
                      visible: _isLoginInProgress == false,
                      replacement: const Center(
                        child: CircularProgressIndicator(),
                      ),
                      child: Visibility(
                        visible: _isLoginInProgress == false,
                        replacement: const Center(
                          child: CircularProgressIndicator(),
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _signIn();
                            }
                          },
                          child: const Icon(Icons.arrow_circle_right_outlined),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                  Center(
                    child: TextButton(
                      style: TextButton.styleFrom(
                          foregroundColor: Colors.grey,
                          textStyle: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          )),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const EmailVerificationScreen()));
                      },
                      child: const Text(
                        'Forgot Password?',
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Don't have an account?",
                        style: TextStyle(fontSize: 16, color: Colors.black54),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SignUpScreen()));
                        },
                        child: const Text(
                          'Sign up',
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _signIn() async {
    _isLoginInProgress = true;
    setState(() {});
    Map<String, dynamic> inputParams = {
      'email': _emailController.text.trim(),
      'password': _passwordController.text,
    };
    final ResponseObject response =
        await NetworkCaller.postRequest(Urls.login, inputParams);
    _isLoginInProgress = false;
    setState(() {});

    if (response.isSuccess) {
      if (!mounted) {
        return;
      }

      LoginResponse loginResponse =
          LoginResponse.fromJson(response.responseBody);

      await AuthController.saveUserData(loginResponse.userData!);
      await AuthController.saveUserToken(loginResponse.token!);

      if (mounted) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const BottomNavScreen()),
            (route) => false);
      }
    } else {
      if (mounted) {
        showSnackBarMessage(
            context, response.errorMessage ?? 'Login failed! Try again');
      }
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
