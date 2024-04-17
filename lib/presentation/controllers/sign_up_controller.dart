import 'package:get/get.dart';
import 'package:task_manager/data/models/response_object.dart';
import 'package:task_manager/data/services/network_caller.dart';
import 'package:task_manager/data/utility/urls.dart';

class SignUpController extends GetxController{

  bool _inProgress = false;
  String? _errorMessage;

  bool get inProgress => _inProgress;

  String get errorMessage => _errorMessage ?? 'Sign up failed! Try again';

  Future<bool> signUp(String email, String password, String firstName, String lastname, String mobile)async{

    _inProgress = true;
    update();

    Map<String, dynamic> inputParams = {
      "email": email,
      "firstName": firstName,
      "lastName": lastname,
      "mobile": mobile,
      "password": password,
    };

    final ResponseObject response =
    await NetworkCaller.postRequest(Urls.registration, inputParams);

    _inProgress = false;
    update();

    if (response.isSuccess) {
      return true;
    } else {
      _errorMessage = response.errorMessage;
      update();
      return false;
    }



  }


}