import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:innoscripta_home_challenge/domain/entity/task/task.dart';
import 'package:innoscripta_home_challenge/presentation/screens/task/widgets/others/empty_task_state.dart';
import 'package:innoscripta_home_challenge/presentation/screens/task/widgets/task_card/task_card.dart';
import 'package:innoscripta_home_challenge/presentation/theme/configs.dart';

class TaskRow extends StatelessWidget {
  final List<Task> tasks;
  final String status;
  final Function(Task, String) onTaskMoved;

  const TaskRow({
    Key? key,
    required this.tasks,
    required this.status,
    required this.onTaskMoved,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200.h,
      width: MediaQuery.of(context).size.width,
      child: DragTarget<Task>(
        onAccept: (task) {
          if (!task.labels!.contains(status)) {
            onTaskMoved(task, status);
          }
        },
        builder: (context, candidateData, rejectedData) {
          return Container(
            decoration: BoxDecoration(
              color: candidateData.isNotEmpty
                  ? Colors.grey.withOpacity(0.2)
                  : Colors.transparent,
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: tasks.isEmpty
                  ? Container(
                      width: 300.w,
                      padding: Space.h,
                      child: EmptyTaskState(status: status),
                    )
                  : ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      padding: Space.h,
                      itemCount: tasks.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: Space.h.add(const EdgeInsets.only(right: 8)),
                          child: SizedBox(
                            width: 300.w,
                            child: TaskCard(
                              task: tasks[index],
                            ),
                          ),
                        );
                      },
                    ),
            ),
          );
        },
      ),
    );
  }
}
