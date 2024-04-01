import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:you_do/l10n/context_text_extension.dart';

class MainScaffold extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const MainScaffold({required this.navigationShell, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.texts.app_title),
        backgroundColor: Colors.white,
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
          backgroundColor: Colors.white,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: const Icon(Icons.group), label: context.texts.meets),
            BottomNavigationBarItem(
                icon: const Icon(Icons.chat), label: context.texts.chats),
          ],
          onTap: (tappedIndex) => navigationShell.goBranch(tappedIndex),
          currentIndex: navigationShell.currentIndex,
          selectedItemColor: Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}
