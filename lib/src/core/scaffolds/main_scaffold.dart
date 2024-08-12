import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:you_do/l10n/context_text_extension.dart';
import 'package:you_do/src/core/theme/theme_extension.dart';

class MainScaffold extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const MainScaffold({required this.navigationShell, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AppTitle(),
        backgroundColor: context.theme.scaffoldBackgroundColor,
        scrolledUnderElevation: 0,
        actions: [
          IconButton(
              onPressed: () {
                showLicensePage(context: context);
              },
              icon: const Icon(Icons.settings))
        ],
      ),
      body: navigationShell,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      bottomNavigationBar: Ink(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 1,
            spreadRadius: 1,
          ),
        ]),
        child: BottomNavigationBar(
          backgroundColor: context.theme.scaffoldBackgroundColor,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: const Icon(Icons.home), label: context.texts.dashboard),
            BottomNavigationBarItem(
                icon: const Icon(Icons.calendar_month),
                label: context.texts.tasks),
          ],
          onTap: (tappedIndex) => navigationShell.goBranch(tappedIndex),
          currentIndex: navigationShell.currentIndex,
          selectedItemColor: Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}

class AppTitle extends StatelessWidget {
  const AppTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 24.0),
      child: Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                context.texts.app_title_first,
                style: context.theme.textTheme.displayLarge!.copyWith(
                  foreground: Paint()
                    ..style = PaintingStyle.stroke
                    ..strokeWidth = 1
                    ..color = Colors.black,
                ),
              ),
              const SizedBox(width: 2),
              Text(
                context.texts.app_title_second,
                style: context.theme.textTheme.displayLarge!.copyWith(
                  foreground: Paint()
                    ..style = PaintingStyle.stroke
                    ..strokeWidth = 1
                    ..color = Colors.black,
                ),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(context.texts.app_title_first,
                  style: context.theme.textTheme.displayLarge!),
              const SizedBox(width: 2),
              Text(context.texts.app_title_second,
                  style: context.theme.textTheme.displayLarge!
                      .copyWith(color: context.theme.primaryColor)),
            ],
          ),
        ],
      ),
    );
  }
}
