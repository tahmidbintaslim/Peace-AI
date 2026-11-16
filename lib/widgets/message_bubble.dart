import 'package:flutter/material.dart';
import '../models/islamic_content.dart';
import '../models/message.dart';
import '../services/bookmark_service.dart';
import '../services/islamic_knowledge_service.dart';
import '../services/share_service.dart';
import '../theme.dart';

class MessageBubble extends StatefulWidget {
  final Message message;

  const MessageBubble({super.key, required this.message});

  @override
  State<MessageBubble> createState() => _MessageBubbleState();
}

class _MessageBubbleState extends State<MessageBubble> {
  static final IslamicKnowledgeService _knowledge = IslamicKnowledgeService();
  bool _isBookmarked = false;

  @override
  void initState() {
    super.initState();
    _checkBookmarkStatus();
  }

  Future<void> _checkBookmarkStatus() async {
    final bookmarked = await BookmarkService.isBookmarked(widget.message.id);
    if (mounted) {
      setState(() => _isBookmarked = bookmarked);
    }
  }

  Future<void> _toggleBookmark() async {
    if (_isBookmarked) {
      await BookmarkService.removeBookmark(widget.message.id);
    } else {
      await BookmarkService.bookmarkMessage(widget.message);
    }
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(_isBookmarked ? 'Bookmark removed' : 'Bookmarked'),
          duration: const Duration(seconds: 1),
        ),
      );
    }
    await _checkBookmarkStatus();
  }

  @override
  Widget build(BuildContext context) {
    final message = widget.message;
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    if (message.isUser) {
      return Align(
        alignment: AlignmentDirectional.centerEnd,
        child: Container(
          margin:
              const EdgeInsetsDirectional.only(start: 48, top: 6, bottom: 6),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: colors.primary,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Text(
            message.text,
            style: theme.textTheme.bodyLarge?.copyWith(color: colors.onPrimary),
          ),
        ),
      );
    }

    final small = theme.textTheme.bodySmall?.copyWith(
      color: colors.onSurfaceVariant,
    );
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // The explanation is secondary to the scripture below it.
          Text(
            message.text,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: colors.onSurfaceVariant,
            ),
          ),
          for (final reference in message.references ?? const <String>[])
            _SourceBlock(
              reference: reference,
              source: _knowledge.findByReference(reference),
            ),
          // Only replies that quote a source are worth saving or sharing.
          if (message.references?.isNotEmpty ?? false)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Row(
                children: [
                  Text(_formatTime(message.timestamp), style: small),
                  const Spacer(),
                  TextButton.icon(
                    onPressed: _toggleBookmark,
                    icon: Icon(
                      _isBookmarked
                          ? Icons.bookmark_rounded
                          : Icons.bookmark_border_rounded,
                      size: 18,
                    ),
                    label: Text(_isBookmarked ? 'Saved' : 'Save'),
                  ),
                  TextButton.icon(
                    onPressed: () => ShareService.showShareDialog(
                      context,
                      message,
                    ),
                    icon: const Icon(Icons.ios_share_rounded, size: 18),
                    label: const Text('Share'),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  String _formatTime(DateTime time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }
}

/// A verse or hadith on a pale green block, under its reference in the green
/// accent. [source] is null when the reference is not in the dataset; the
/// reference line is shown either way.
class _SourceBlock extends StatelessWidget {
  final String reference;
  final Object? source;

  const _SourceBlock({required this.reference, required this.source});

  // Arabic-Indic digits, as printed inside the verse-end mark.
  static String _arabicDigits(int number) {
    return number
        .toString()
        .split('')
        .map((d) => String.fromCharCode(0x0660 + int.parse(d)))
        .join();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final source = this.source;
    final label = theme.textTheme.labelLarge?.copyWith(
      color: colors.secondary,
    );
    final translation = theme.textTheme.bodyLarge?.copyWith(height: 28 / 17);
    final kind = source is Hadith
        ? 'Hadith  ·  '
        : source is QuranVerse
            ? 'Quran  ·  '
            : '';

    return Container(
      margin: const EdgeInsets.only(top: 12),
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
      decoration: BoxDecoration(
        color: colors.secondaryContainer,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            '$kind$reference',
            style: label,
          ),
          if (source is QuranVerse) ...[
            const SizedBox(height: 8),
            Text.rich(
              TextSpan(
                text: source.arabicText,
                children: [
                  // U+06DD, the end-of-ayah mark: the font draws it as a
                  // roundel around the verse number.
                  TextSpan(
                    text: ' ۝${_arabicDigits(source.verse)}',
                    style: TextStyle(color: colors.secondary),
                    semanticsLabel: ' ',
                  ),
                ],
              ),
              textDirection: TextDirection.rtl,
              style: TextStyle(
                fontFamily: arabicFont,
                fontSize: 28,
                height: 2,
                color: colors.onSurface,
              ),
            ),
            const SizedBox(height: 8),
            Text(source.translation, style: translation),
          ],
          if (source is Hadith) ...[
            const SizedBox(height: 8),
            Text(source.translation, style: translation),
            const SizedBox(height: 6),
            Text(
              'Narrated by ${source.narrator}',
              style: theme.textTheme.bodySmall?.copyWith(
                color: colors.onSurfaceVariant,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
