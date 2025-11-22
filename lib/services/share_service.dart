import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/message.dart';

class ShareService {
  /// Share a message text
  static Future<void> shareMessage(BuildContext context, Message message) async {
    final text = _formatMessageForSharing(message);
    await _copyToClipboard(context, text);
  }

  /// Format message for sharing
  static String _formatMessageForSharing(Message message) {
    final buffer = StringBuffer();
    
    // Add message text
    buffer.writeln(message.text);
    
    // Add references if available
    if (message.references != null && message.references!.isNotEmpty) {
      buffer.writeln();
      buffer.writeln('References:');
      for (final ref in message.references!) {
        buffer.writeln('- $ref');
      }
    }
    
    // Add attribution
    buffer.writeln();
    buffer.writeln('---');
    buffer.writeln('Shared from Peace AI');
    buffer.writeln('Islamic Knowledge Assistant');
    
    return buffer.toString();
  }

  /// Copy text to clipboard
  static Future<void> _copyToClipboard(BuildContext context, String text) async {
    await Clipboard.setData(ClipboardData(text: text));
    
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Copied to clipboard!'),
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
              leading: const Icon(Icons.copy),
              title: const Text('Copy to Clipboard'),
              onTap: () {
                Navigator.pop(context);
                shareMessage(context, message);
              },
            ),
            ListTile(
              leading: const Icon(Icons.text_snippet),
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
            _formatMessageForSharing(message),
            style: const TextStyle(fontSize: 14),
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
