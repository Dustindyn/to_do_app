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
      floatingActionButton: FloatingActionButton(
        child: IconButton(
          icon: const Icon(Icons.add),
          onPressed: () {},
        ),
        onPressed: () {},
      ),
      appBar: AppBar(
        title: Text(context.texts.app_title,
            style: context.theme.textTheme.displayLarge),
        backgroundColor: context.theme.scaffoldBackgroundColor,
        scrolledUnderElevation: 0,
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
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.group), label: "test1"),
            BottomNavigationBarItem(icon: Icon(Icons.chat), label: "test2"),
            BottomNavigationBarItem(icon: Icon(Icons.chat), label: "test3")
          ],
          onTap: (tappedIndex) => navigationShell.goBranch(tappedIndex),
          currentIndex: navigationShell.currentIndex,
          selectedItemColor: Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}
