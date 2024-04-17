import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/presentation/controllers/completed_task_controller.dart';
import 'package:task_manager/presentation/controllers/count_task_by_status_controller.dart';
import 'package:task_manager/presentation/widgets/app_background.dart';
import 'package:task_manager/presentation/widgets/empty_list_widget.dart';
import 'package:task_manager/presentation/widgets/profile_app_bar.dart';
import 'package:task_manager/presentation/widgets/task_card.dart';

class CompleteTaskScreen extends StatefulWidget {
  const CompleteTaskScreen({super.key});

  @override
  State<CompleteTaskScreen> createState() => _CompleteTaskScreenState();
}

class _CompleteTaskScreenState extends State<CompleteTaskScreen> {

  @override
  void initState() {
    super.initState();
    _getDataFromApis();
  }

  void _getDataFromApis() {
    Get.find<CountTaskByStatusController>().getCountByTaskStatus();
    Get.find<CompletedTaskController>().getCompletedTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: profileAppBar,
      body: AppBackground(
        child: GetBuilder<CompletedTaskController>(
          builder: (completedTaskController) {

           return Visibility(
              visible: completedTaskController.inProgress == false,
              replacement: const Center(
                child: CircularProgressIndicator(),
              ),
              child: RefreshIndicator(
                onRefresh: () async {
                  _getDataFromApis();
                },
                child: Visibility(
                  visible: completedTaskController.completedTaskListWrapper.taskList?.isNotEmpty ??
                      false,
                  replacement: const EmptyListWidget(),
                  child: ListView.builder(
                    itemCount: completedTaskController.completedTaskListWrapper.taskList?.length ?? 0,
                    itemBuilder: (context, index) {
                      return TaskCard(
                        taskItem: completedTaskController.completedTaskListWrapper.taskList![index],
                        refreshList: () {
                          completedTaskController.getCompletedTaskList();
                        },
                      );
                    },
                  ),
                ),
              ),
            );
          }
        ),
      ),
    );
  }

}
