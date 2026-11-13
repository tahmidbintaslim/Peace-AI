import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/islamic_content.dart';
import '../models/message.dart';
import 'islamic_knowledge_service.dart';

class ShareService {
  /// Share a message text
  static Future<void> shareMessage(
      BuildContext context, Message message) async {
    final text = formatMessage(message);
    await _copyToClipboard(context, text);
  }

  /// The reply as plain text: the explanation, then each verse or hadith
  /// from the dataset followed by its reference.
  static String formatMessage(Message message) {
    final knowledge = IslamicKnowledgeService();
    final buffer = StringBuffer();
    buffer.writeln(message.text);

    for (final reference in message.references ?? const <String>[]) {
      final source = knowledge.findByReference(reference);
      buffer.writeln();
      if (source is QuranVerse) {
        buffer.writeln(source.arabicText);
        buffer.writeln(source.translation);
      } else if (source is Hadith) {
        buffer.writeln(source.translation);
        buffer.writeln('Narrated by ${source.narrator}');
      }
      buffer.writeln('($reference)');
    }

    buffer.writeln();
    buffer.writeln('---');
    buffer.writeln('Shared from Peace AI');

    return buffer.toString();
  }

  /// Copy text to clipboard
  static Future<void> _copyToClipboard(
      BuildContext context, String text) async {
    await Clipboard.setData(ClipboardData(text: text));

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Copied to clipboard'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  /// Show share dialog with options
  static void showShareDialog(BuildContext context, Message message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Share Response'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.copy_rounded),
              title: const Text('Copy to Clipboard'),
              onTap: () {
                Navigator.pop(context);
                shareMessage(context, message);
              },
            ),
            ListTile(
              leading: const Icon(Icons.text_snippet_outlined),
              title: const Text('View Formatted Text'),
              onTap: () {
                Navigator.pop(context);
                _showFormattedText(context, message);
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  /// Show formatted text dialog
  static void _showFormattedText(BuildContext context, Message message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Formatted Text'),
        content: SingleChildScrollView(
          child: SelectableText(
            formatMessage(message),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              shareMessage(context, message);
            },
            child: const Text('Copy'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}
