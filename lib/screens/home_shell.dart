import 'package:flutter/material.dart';
import 'bookmarks_screen.dart';
import 'chat_screen.dart';
import 'settings_screen.dart';

/// The three top-level screens behind a bottom tab bar.
class HomeShell extends StatefulWidget {
  const HomeShell({super.key});

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    final rule = Theme.of(context).colorScheme.outlineVariant;
    return Scaffold(
      // The chat keeps its messages while another tab is open. Bookmarks are
      // built only while shown, so the list is read again on every visit.
      body: IndexedStack(
        index: _index,
        children: [
          const ChatScreen(),
          _index == 1 ? const BookmarksScreen() : const SizedBox.shrink(),
          const SettingsScreen(),
        ],
      ),
      bottomNavigationBar: DecoratedBox(
        position: DecorationPosition.foreground,
        decoration: BoxDecoration(border: Border(top: BorderSide(color: rule))),
        child: NavigationBar(
          selectedIndex: _index,
          onDestinationSelected: (index) => setState(() => _index = index),
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.chat_bubble_outline_rounded),
              label: 'Ask',
            ),
            NavigationDestination(
              icon: Icon(Icons.bookmark_border_rounded),
              label: 'Saved',
            ),
            NavigationDestination(
              icon: Icon(Icons.settings_outlined),
              label: 'Settings',
            ),
          ],
        ),
      ),
    );
  }
}
