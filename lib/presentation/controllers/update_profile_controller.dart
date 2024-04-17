import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task_manager/data/models/user_data.dart';
import 'package:task_manager/data/services/network_caller.dart';
import 'package:task_manager/data/utility/urls.dart';
import 'package:task_manager/presentation/controllers/auth_controller.dart';

class UpdateProfileController extends GetxController {
  XFile? pickedImage;
  bool _inProgress = false;
  String? _errorMessage;

  bool get inProgress => _inProgress;

  String get errorMessage =>
      _errorMessage ?? 'Update profile failed! Try again';

  Future<void> pickImageFromGallery() async {
    ImagePicker imagePicker = ImagePicker();
    pickedImage = await imagePicker.pickImage(source: ImageSource.camera);
    update();
  }

  Future<bool> updateProfile(String email, String firstName, String lastName,
      String mobile, String password, XFile? pickedImage) async {
    String? photo;

    _inProgress = true;
    update();

    Map<String, dynamic> inputParams = {
      "email": email,
      "firstName": firstName,
      "lastName": lastName,
      "mobile": mobile,
    };

    if (password.isNotEmpty) {
      inputParams['password'] = password;
    }

    if (pickedImage != null) {
      List<int> bytes = File(pickedImage.path).readAsBytesSync();
      photo = base64UrlEncode(bytes);
      inputParams['photo'] = photo;
    }

    final response =
    await NetworkCaller.postRequest(Urls.updateProfile, inputParams);

    _inProgress = false;
    if (response.isSuccess) {
      if (response.responseBody['status'] == 'success') {
        UserData userData = UserData(
          email: email,
          firstName: firstName,
          lastName: lastName,
          mobile: mobile,
          photo: photo,
        );
        await AuthController.saveUserData(userData);
        return true;
      }
      update();
    } else {
      update();
      _errorMessage = response.errorMessage;
    }

    // Return false if the update fails
    return false;
  }
}
