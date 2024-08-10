import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:you_do/l10n/context_text_extension.dart';
import 'package:you_do/src/core/helpers/datetime_helpers.dart';
import 'package:you_do/src/core/tasks/blocs/tasks_cubit.dart';
import 'package:you_do/src/core/theme/theme_extension.dart';

class DailyProgressIndicator extends StatelessWidget {
  final String dailyProgressText;
  const DailyProgressIndicator(this.dailyProgressText, {super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksCubit, TasksState>(builder: (context, state) {
      return Stack(
        children: [
          Positioned(
            bottom: 0,
            left: 8,
            child: Text(context.texts.dashboard_daily_progress),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 22),
            child: CircularPercentIndicator(
              radius: 55,
              lineWidth: 7,
              animation: true,
              animationDuration: 500,
              animateFromLastPercent: true,
              percent: state.tasks
                      .where((t) => t.isCompleted && t.dueDate.isToday)
                      .isEmpty
                  ? 0
                  : state.tasks
                          .where((t) => t.isCompleted && t.dueDate.isToday)
                          .length /
                      state.tasks.where((t) => t.dueDate.isToday).length,
              progressColor: context.theme.primaryColor,
              backgroundColor: const Color(0xff384c5e),
            ),
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.only(
                  bottom: 22.0,
                ),
                child: Text(dailyProgressText,
                    style: const TextStyle(
                      fontSize: 16,
                    )),
              ),
            ),
          ),
        ],
      );
    });
  }
}
