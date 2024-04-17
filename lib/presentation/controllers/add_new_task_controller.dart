import 'package:get/get.dart';
import 'package:task_manager/data/models/response_object.dart';
import 'package:task_manager/data/services/network_caller.dart';
import 'package:task_manager/data/utility/urls.dart';

class AddNewTaskController extends GetxController {
  bool _inProgress = false;
  String? _errorMessage;

  bool get inProgress => _inProgress;

  String get errorMessage =>
      _errorMessage ?? 'Adding new task failed! Try again';

  Future<bool> addNewTask(String title, String description) async {
    Map<String, dynamic> inputParams = {
      "title": title,
      "description": description,
      "status": "New"
    };

    final ResponseObject response =
        await NetworkCaller.postRequest(Urls.createTask, inputParams);

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
