import 'package:get/get.dart';
import 'package:task_manager/presentation/controllers/add_new_task_controller.dart';
import 'package:task_manager/presentation/controllers/cancel_task_controller.dart';
import 'package:task_manager/presentation/controllers/completed_task_controller.dart';
import 'package:task_manager/presentation/controllers/count_task_by_status_controller.dart';
import 'package:task_manager/presentation/controllers/new_task_controller.dart';
import 'package:task_manager/presentation/controllers/progress_task_controller.dart';
import 'package:task_manager/presentation/controllers/sign_in_controller.dart';
import 'package:task_manager/presentation/controllers/sign_up_controller.dart';
import 'package:task_manager/presentation/controllers/update_profile_controller.dart';

class ControllerBinder extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SignInController());
    Get.lazyPut(() => SignUpController());
    Get.lazyPut(() => CountTaskByStatusController());
    Get.lazyPut(() => NewTaskController());
    Get.lazyPut(() => ProgressTaskController());
    Get.lazyPut(() => CancelTaskController());
    Get.lazyPut(() => CompletedTaskController());
    Get.lazyPut(() => AddNewTaskController());
    Get.lazyPut(() => UpdateProfileController());
  }
}