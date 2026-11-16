import 'package:flutter/material.dart';

/// The app mark: a filled green tile with a book, as used in the app bar and
/// on the splash screen.
class BrandMark extends StatelessWidget {
  final double size;

  const BrandMark({super.key, this.size = 36});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: colors.primary,
        borderRadius: BorderRadius.circular(size * 0.28),
      ),
      child: Icon(
        Icons.auto_stories_outlined,
        size: size * 0.58,
        color: colors.onPrimary,
      ),
    );
  }
}

/// The pale green 44 px tile that carries a row's icon.
class IconTile extends StatelessWidget {
  final IconData icon;

  const IconTile(this.icon, {super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: colors.secondaryContainer,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(icon, size: 24, color: colors.onSecondaryContainer),
    );
  }
}

/// A white card with the large corner radius, flat on the page.
class SurfaceCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;

  const SurfaceCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).colorScheme.surfaceContainerLow,
      borderRadius: BorderRadius.circular(24),
      clipBehavior: Clip.antiAlias,
      child: Padding(padding: padding, child: child),
    );
  }
}

/// A segmented switch: a pale track with the chosen option on a card.
class SegmentedChoice<T> extends StatelessWidget {
  final Map<T, String> options;
  final T value;
  final ValueChanged<T> onChanged;

  const SegmentedChoice({
    super.key,
    required this.options,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    return Container(
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: colors.secondaryContainer,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          for (final entry in options.entries)
            Expanded(
              child: Semantics(
                inMutuallyExclusiveGroup: true,
                checked: entry.key == value,
                child: Material(
                  color: entry.key == value
                      ? colors.surfaceContainerHigh
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                  clipBehavior: Clip.antiAlias,
                  child: InkWell(
                    onTap: () => onChanged(entry.key),
                    child: Container(
                      constraints: const BoxConstraints(minHeight: 44),
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        entry.value,
                        textAlign: TextAlign.center,
                        style: (entry.key == value
                                ? theme.textTheme.titleSmall
                                : theme.textTheme.bodyMedium)
                            ?.copyWith(
                          color: entry.key == value
                              ? colors.onSurface
                              : colors.onSurfaceVariant,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
