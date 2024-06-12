import 'package:animated_line_through/animated_line_through.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:you_do/src/core/notifications/services/notification_service.dart';
import 'package:you_do/src/core/tasks/blocs/tasks_cubit.dart';
import 'package:you_do/src/core/tasks/models/task.dart';
import 'package:you_do/src/core/theme/theme_extension.dart';
import 'package:you_do/src/dependencies.dart';

class TaskBox extends StatefulWidget {
  final Task task;

  const TaskBox(this.task, {super.key});

  @override
  State<TaskBox> createState() => _TaskBoxState();
}

class _TaskBoxState extends State<TaskBox> {
  bool _hasNotification = false;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocBuilder<TasksCubit, TasksState>(
      builder: (context, state) {
        return Card(
          color: context.theme.cardColor,
          child: Container(
            width: size.width,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AnimatedLineThrough(
                      duration: const Duration(milliseconds: 400),
                      isCrossed: widget.task.isCompleted,
                      child: Text(
                        widget.task.description,
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                    InkWell(
                      child: const Icon(Icons.close, color: Colors.grey),
                      onTap: () =>
                          context.read<TasksCubit>().deleteTask(widget.task.id),
                    )
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      child: _hasNotification
                          ? Icon(Icons.notifications,
                              color: context.theme.primaryColor)
                          : const Icon(Icons.notifications_off,
                              color: Colors.grey),
                      onTap: () => setState(
                        () {
                          if (!_hasNotification) {
                            showTimePicker(
                                context: context, initialTime: TimeOfDay.now());
                            _scheduleNotification(state.tasks, context);
                          } else {
                            context
                                .get<NotificationService>()
                                .cancelNotification(0);
                          }
                          _hasNotification = !_hasNotification;
                        },
                      ),
                    ),
                    Checkbox(
                      side: WidgetStateBorderSide.resolveWith(
                        (states) =>
                            const BorderSide(width: 1.0, color: Colors.grey),
                      ),
                      value: widget.task.isCompleted,
                      onChanged: (_) {
                        setState(() {
                          context.read<TasksCubit>().setTaskCompletion(
                              widget.task.id, !widget.task.isCompleted);
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

//TODO: make task accessible in widget so u dont have to pass list so often
  Future<void> _scheduleNotification(
    List<Task> tasks,
    BuildContext ctx, {
    Duration inDuration = const Duration(
      seconds: 20,
    ),
  }) async {
    final notificationService = ctx.get<NotificationService>();
    await notificationService.scheduleNotification(
        description: widget.task.description);
  }
}
