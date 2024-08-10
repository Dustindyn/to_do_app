import 'package:animated_line_through/animated_line_through.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:you_do/l10n/context_text_extension.dart';
import 'package:you_do/src/core/notifications/services/notification_service.dart';
import 'package:you_do/src/core/tasks/blocs/tasks_cubit.dart';
import 'package:you_do/src/core/tasks/models/task.dart';
import 'package:you_do/src/core/theme/theme_extension.dart';
import 'package:you_do/src/core/toasts/show_error_toast.dart';
import 'package:you_do/src/dependencies.dart';

class TaskBox extends StatefulWidget {
  final Task task;

  const TaskBox(this.task, {super.key});
  @override
  State<TaskBox> createState() => _TaskBoxState();
}

class _TaskBoxState extends State<TaskBox> {
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
                      child: widget.task.notificationId != null
                          ? Icon(Icons.notifications,
                              color: context.theme.primaryColor)
                          : const Icon(Icons.notifications_off,
                              color: Colors.grey),
                      onTap: () => setState(
                        () async {
                          if (widget.task.notificationId == null) {
                            if (!(await context
                                .get<NotificationService>()
                                .hasPermission())) {
                              if (context.mounted) {
                                showErrorToast(
                                    // ignore: use_build_context_synchronously
                                    context,
                                    // ignore: use_build_context_synchronously
                                    context.texts.missing_permission_error);
                              }
                              return;
                            }
                            if (context.mounted) {
                              showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.now())
                                  .then((time) => time != null
                                      // ignore: use_build_context_synchronously
                                      ? _scheduleNotification(context, time)
                                      : null);
                            }
                          } else {
                            _cancelNotification(context);
                          }
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

  Future<void> _scheduleNotification(
    BuildContext ctx,
    TimeOfDay time,
  ) async {
    final cubit = context.read<TasksCubit>();
    final notificationService = ctx.get<NotificationService>();

    final dateTime = DateTime(
        widget.task.dueDate.year,
        widget.task.dueDate.month,
        widget.task.dueDate.day,
        time.hour,
        time.minute);
    final notificationId = await notificationService.scheduleNotification(
        dateTime, context.texts.notification_title,
        description: widget.task.description);
    cubit.setTaskNotificationId(widget.task.id, notificationId);
  }

  Future<void> _cancelNotification(BuildContext ctx) async {
    final cubit = context.read<TasksCubit>();
    final notificationService = ctx.get<NotificationService>();
    await notificationService.cancelNotification(widget.task.notificationId!);
    cubit.setTaskNotificationId(widget.task.id, null);
  }
}
