import 'package:flutter/material.dart';
import 'package:task_manager/data/models/task_list_wrapper.dart';
import 'package:task_manager/data/services/network_caller.dart';
import 'package:task_manager/data/utility/urls.dart';
import 'package:task_manager/presentation/widgets/app_background.dart';
import 'package:task_manager/presentation/widgets/empty_list_widget.dart';
import 'package:task_manager/presentation/widgets/profile_app_bar.dart';
import 'package:task_manager/presentation/widgets/snack_bar_message.dart';
import 'package:task_manager/presentation/widgets/task_card.dart';

class CancelTaskScreen extends StatefulWidget {
  const CancelTaskScreen({super.key});

  @override
  State<CancelTaskScreen> createState() => _CancelTaskScreenState();
}

class _CancelTaskScreenState extends State<CancelTaskScreen> {
  bool _getAllCancelledTaskListInProgress = false;
  TaskListWrapper _cancelledTaskListWrapper = TaskListWrapper();

  @override
  void initState() {
    super.initState();
    _getAllCancelledTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: profileAppBar,
      body: AppBackground(
        child: Visibility(
          visible: !_getAllCancelledTaskListInProgress,
          replacement: const Center(
            child: CircularProgressIndicator(),
          ),
          child: RefreshIndicator(
            onRefresh: () async {
              _getAllCancelledTaskList();
            },
            child: Visibility(
              visible:
              _cancelledTaskListWrapper.taskList?.isNotEmpty ?? false,
              replacement: const EmptyListWidget(),
              child: ListView.builder(
                itemCount: _cancelledTaskListWrapper.taskList?.length ?? 0,
                itemBuilder: (context, index) {
                  return TaskCard(
                    taskItem: _cancelledTaskListWrapper.taskList![index],
                    refreshList: () {
                      _getAllCancelledTaskList();
                    },
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _getAllCancelledTaskList() async {
    _getAllCancelledTaskListInProgress = true;
    setState(() {});
    final response =
    await NetworkCaller.getRequest(Urls.cancelledTaskList);
    if (response.isSuccess) {
      _cancelledTaskListWrapper =
          TaskListWrapper.fromJson(response.responseBody);
    } else {
      if (mounted) {
        showSnackBarMessage(
          context,
          response.errorMessage ?? 'Failed to get cancelled task list',
        );
      }
    }
    _getAllCancelledTaskListInProgress = false;
    if (mounted) {
      setState(() {});
    }
  }
}
