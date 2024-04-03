import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/presentation/controllers/cancel_task_controller.dart';
import 'package:task_manager/presentation/controllers/count_task_by_status_controller.dart';
import 'package:task_manager/presentation/widgets/app_background.dart';
import 'package:task_manager/presentation/widgets/empty_list_widget.dart';
import 'package:task_manager/presentation/widgets/profile_app_bar.dart';
import 'package:task_manager/presentation/widgets/task_card.dart';

class CancelTaskScreen extends StatefulWidget {
  const CancelTaskScreen({super.key});

  @override
  State<CancelTaskScreen> createState() => _CancelTaskScreenState();
}

class _CancelTaskScreenState extends State<CancelTaskScreen> {
  @override
  void initState() {
    super.initState();
    _getDataFromApis();
  }

  void _getDataFromApis() {
    Get.find<CountTaskByStatusController>().getCountByTaskStatus();
    Get.find<CancelTaskController>().getCancelledTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: profileAppBar,
      body: AppBackground(
        child:
            GetBuilder<CancelTaskController>(builder: (cancelTaskController) {
          return Visibility(
            visible: cancelTaskController.inProgress == false,
            replacement: const Center(
              child: CircularProgressIndicator(),
            ),
            child: RefreshIndicator(
              onRefresh: () async {
                _getDataFromApis();
              },
              child: Visibility(
                visible: cancelTaskController
                        .cancelledTaskListWrapper.taskList?.isNotEmpty ??
                    false,
                replacement: const EmptyListWidget(),
                child: ListView.builder(
                  itemCount: cancelTaskController
                          .cancelledTaskListWrapper.taskList?.length ??
                      0,
                  itemBuilder: (context, index) {
                    return TaskCard(
                      taskItem: cancelTaskController
                          .cancelledTaskListWrapper.taskList![index],
                      refreshList: () {
                        _getDataFromApis();
                      },
                    );
                  },
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
