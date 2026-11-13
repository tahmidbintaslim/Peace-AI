import 'package:flutter/material.dart';
import '../services/islamic_knowledge_service.dart';
import '../services/theme_service.dart';

/// What the answers are, in plain words. Shown in the first chat message
/// and in the About dialog.
String sourceNotice(IslamicKnowledgeService knowledge) {
  return 'Answers come from a small built-in set of '
      '${knowledge.totalVerses} Quran verses and ${knowledge.totalHadiths} '
      'hadiths, each shown with its reference. They are picked by keyword '
      'rules, not by an AI model. The texts have not been reviewed by a '
      'scholar, so check them against a trusted source. For a ruling, ask '
      'a scholar.';
}

void showAboutPeaceAI(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('About Peace AI'),
      content: SingleChildScrollView(
        child: Text(
          '${sourceNotice(IslamicKnowledgeService())}\n\n'
          'Free and open source (MIT licence). No ads, no tracking, and '
          'nothing you type leaves this device.',
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Close'),
        ),
      ],
    ),
  );
}

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  static const Map<ThemeMode, String> _themeNames = {
    ThemeMode.system: 'System default',
    ThemeMode.light: 'Light',
    ThemeMode.dark: 'Dark',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        children: [
          const _SectionHeader('Theme'),
          ValueListenableBuilder<ThemeMode>(
            valueListenable: ThemeService.mode,
            builder: (context, mode, _) => Column(
              children: [
                for (final entry in _themeNames.entries)
                  RadioListTile<ThemeMode>(
                    title: Text(entry.value),
                    value: entry.key,
                    groupValue: mode,
                    onChanged: (value) {
                      if (value != null) ThemeService.setMode(value);
                    },
                  ),
              ],
            ),
          ),
          const Divider(),
          const _SectionHeader('About'),
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text('About Peace AI'),
            subtitle: const Text('Where the answers come from'),
            onTap: () => showAboutPeaceAI(context),
          ),
          ListTile(
            leading: const Icon(Icons.menu_book_outlined),
            title: const Text('Content Statistics'),
            subtitle: const Text('What the built-in dataset holds'),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const StatisticsScreen(),
              ),
            ),
          ),
          const ListTile(
            leading: Icon(Icons.label_outline),
            title: Text('Version'),
            subtitle: Text('1.0.0'),
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;

  const _SectionHeader(this.title);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
      child: Text(
        title,
        style: theme.textTheme.labelLarge?.copyWith(
          color: theme.colorScheme.secondary,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.4,
        ),
      ),
    );
  }
}

/// Counts taken from the dataset itself, never typed in by hand.
class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final knowledge = IslamicKnowledgeService();
    final collections = knowledge.hadithCollections;
    final theme = Theme.of(context);

    Widget count(int value, String label) {
      return ListTile(
        title: Text('$value', style: theme.textTheme.headlineMedium),
        subtitle: Text(label),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Content Statistics')),
      body: ListView(
        children: [
          const _SectionHeader('Quran'),
          count(knowledge.totalVerses, 'verses'),
          count(knowledge.getSurahNames().length, 'surahs they come from'),
          const Divider(),
          const _SectionHeader('Hadith'),
          count(knowledge.totalHadiths, 'hadiths'),
          for (final entry in collections.entries)
            ListTile(
              title: Text(entry.key),
              trailing: Text(
                '${entry.value}',
                style: theme.textTheme.titleMedium,
              ),
            ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'The texts have not been reviewed by a scholar.',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
