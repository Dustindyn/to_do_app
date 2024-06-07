import 'package:animated_line_through/animated_line_through.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:you_do/src/core/tasks/blocs/tasks_cubit.dart';
import 'package:you_do/src/core/tasks/models/task.dart';
import 'package:you_do/src/core/theme/theme_extension.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:you_do/src/dependencies.dart';

class TaskBox extends StatefulWidget {
  final String taskId;

  const TaskBox({required this.taskId, super.key});

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
                      isCrossed: _getIsChecked(state.tasks),
                      child: Text(
                        _getDescription(state.tasks),
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                    InkWell(
                      child: const Icon(Icons.close, color: Colors.grey),
                      onTap: () =>
                          context.read<TasksCubit>().deleteTask(widget.taskId),
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
                          _scheduleNotification(context);
                          _hasNotification = !_hasNotification;
                        },
                      ),
                    ),
                    Checkbox(
                      side: WidgetStateBorderSide.resolveWith(
                        (states) =>
                            const BorderSide(width: 1.0, color: Colors.grey),
                      ),
                      value: _getIsChecked(state.tasks),
                      onChanged: (_) {
                        setState(() {
                          context.read<TasksCubit>().setTaskCompletion(
                              widget.taskId, !_getIsChecked(state.tasks));
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
    BuildContext ctx, {
    Duration inDuration = const Duration(
      seconds: 20,
    ),
  }) async {
    final notificationPlugin = ctx.get<FlutterLocalNotificationsPlugin>();
    await notificationPlugin.zonedSchedule(
        0,
        "Test Title",
        "Test body",
        tz.TZDateTime.now(tz.local).add(inDuration),
        const NotificationDetails(
          android: AndroidNotificationDetails(
              'your channel id', 'your channel name',
              channelDescription: 'your channel description'),
        ),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
    print("were here");
  }

  bool _getIsChecked(List<Task> tasks) {
    final task = tasks.firstWhere((task) => task.id == widget.taskId);
    return task.isCompleted;
  }

  DateTime _getDueDate(List<Task> tasks) {
    final task = tasks.firstWhere((task) => task.id == widget.taskId);
    return task.dueDate;
  }

  String _getDescription(List<Task> tasks) {
    final task = tasks.firstWhere((task) => task.id == widget.taskId);
    return task.description;
  }
}
