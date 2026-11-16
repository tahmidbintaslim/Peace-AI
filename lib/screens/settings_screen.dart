import 'package:flutter/material.dart';
import '../services/islamic_knowledge_service.dart';
import '../services/theme_service.dart';
import '../widgets/common.dart';

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
        FilledButton(
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
    ThemeMode.system: 'System',
    ThemeMode.light: 'Light',
    ThemeMode.dark: 'Dark',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: _Page(
        children: [
          const _SectionHeader('Theme'),
          SurfaceCard(
            padding: const EdgeInsets.all(12),
            child: ValueListenableBuilder<ThemeMode>(
              valueListenable: ThemeService.mode,
              builder: (context, mode, _) => SegmentedChoice<ThemeMode>(
                options: _themeNames,
                value: mode,
                onChanged: ThemeService.setMode,
              ),
            ),
          ),
          const _SectionHeader('About'),
          SurfaceCard(
            padding: EdgeInsets.zero,
            child: Column(
              children: [
                _Row(
                  icon: Icons.info_outline_rounded,
                  title: 'About Peace AI',
                  subtitle: 'Where the answers come from',
                  onTap: () => showAboutPeaceAI(context),
                ),
                const Divider(indent: 76),
                _Row(
                  icon: Icons.auto_stories_outlined,
                  title: 'Content Statistics',
                  subtitle: 'What the built-in dataset holds',
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const StatisticsScreen(),
                    ),
                  ),
                ),
                const Divider(indent: 76),
                const _Row(
                  icon: Icons.label_outline_rounded,
                  title: 'Version',
                  subtitle: '1.0.0',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// A scrolling column of cards, kept to a readable width on wide screens.
class _Page extends StatelessWidget {
  final List<Widget> children;

  const _Page({required this.children});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 720),
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
          children: children,
        ),
      ),
    );
  }
}

class _Row extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;

  const _Row({
    required this.icon,
    required this.title,
    required this.subtitle,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      leading: IconTile(icon),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: onTap == null ? null : const Icon(Icons.chevron_right_rounded),
      onTap: onTap,
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
        style: theme.textTheme.bodySmall?.copyWith(
          color: theme.colorScheme.onSurfaceVariant,
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
    final collections = knowledge.hadithCollections.entries.toList();
    final theme = Theme.of(context);
    final muted = theme.textTheme.bodyMedium?.copyWith(
      color: theme.colorScheme.onSurfaceVariant,
    );

    Widget count(IconData icon, int value, String label) {
      return Expanded(
        child: SurfaceCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconTile(icon),
              const SizedBox(height: 12),
              Text('$value', style: theme.textTheme.headlineMedium),
              Text(label, style: muted),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Content Statistics')),
      body: _Page(
        children: [
          const _SectionHeader('Quran'),
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                count(Icons.auto_stories_outlined, knowledge.totalVerses,
                    'verses'),
                const SizedBox(width: 8),
                count(
                  Icons.format_list_numbered_rounded,
                  knowledge.getSurahNames().length,
                  'surahs they come from',
                ),
              ],
            ),
          ),
          const _SectionHeader('Hadith'),
          Row(
            children: [
              count(Icons.format_quote_rounded, knowledge.totalHadiths,
                  'hadiths'),
            ],
          ),
          const SizedBox(height: 8),
          SurfaceCard(
            padding: EdgeInsets.zero,
            child: Column(
              children: [
                for (var i = 0; i < collections.length; i++) ...[
                  if (i > 0) const Divider(indent: 16),
                  ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                    title: Text(collections[i].key),
                    trailing: Text(
                      '${collections[i].value}',
                      style: theme.textTheme.titleMedium,
                    ),
                  ),
                ],
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'The texts have not been reviewed by a scholar.',
              style: muted,
            ),
          ),
        ],
      ),
    );
  }
}
