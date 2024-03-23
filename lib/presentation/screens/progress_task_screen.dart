import 'package:flutter/material.dart';
import 'package:task_manager/data/models/task_list_wrapper.dart';
import 'package:task_manager/data/services/network_caller.dart';
import 'package:task_manager/data/utility/urls.dart';
import 'package:task_manager/presentation/widgets/app_background.dart';
import 'package:task_manager/presentation/widgets/empty_list_widget.dart';
import 'package:task_manager/presentation/widgets/profile_app_bar.dart';
import 'package:task_manager/presentation/widgets/snack_bar_message.dart';
import 'package:task_manager/presentation/widgets/task_card.dart';

class ProgressTaskScreen extends StatefulWidget {
  const ProgressTaskScreen({super.key});

  @override
  State<ProgressTaskScreen> createState() => _ProgressTaskScreenState();
}

class _ProgressTaskScreenState extends State<ProgressTaskScreen> {
  bool _getAllProgressTaskListInProgress = false;
  TaskListWrapper _progressTaskListWrapper = TaskListWrapper();

  @override
  void initState() {
    super.initState();
    _getAllProgressTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: profileAppBar,
      body: AppBackground(
        child: Visibility(
          visible: !_getAllProgressTaskListInProgress,
          replacement: const Center(
            child: CircularProgressIndicator(),
          ),
          child: RefreshIndicator(
            onRefresh: () async {
              _getAllProgressTaskList();
            },
            child: Visibility(
              visible: _progressTaskListWrapper.taskList?.isNotEmpty ?? false,
              replacement: const EmptyListWidget(),
              child: ListView.builder(
                itemCount: _progressTaskListWrapper.taskList?.length ?? 0,
                itemBuilder: (context, index) {
                  return TaskCard(
                    taskItem: _progressTaskListWrapper.taskList![index],
                    refreshList: () {
                      _getAllProgressTaskList();
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

  Future<void> _getAllProgressTaskList() async {
    _getAllProgressTaskListInProgress = true;
    setState(() {});
    final response = await NetworkCaller.getRequest(Urls.progressTaskList);
    if (response.isSuccess) {
      _progressTaskListWrapper =
          TaskListWrapper.fromJson(response.responseBody);
    } else {
      if (mounted) {
        showSnackBarMessage(
          context,
          response.errorMessage ?? 'Failed to get progress task list',
        );
      }
    }
    _getAllProgressTaskListInProgress = false;
    if (mounted) {
      setState(() {});
    }
  }
}
