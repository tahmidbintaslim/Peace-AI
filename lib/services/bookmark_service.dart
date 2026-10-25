import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/message.dart';

class BookmarkService {
  static const String _bookmarksKey = 'bookmarked_messages';

  /// Save a message as bookmark
  static Future<bool> bookmarkMessage(Message message) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final bookmarks = await getBookmarks();

      // Check if already bookmarked
      if (bookmarks.any((m) => m.id == message.id)) {
        return false; // Already bookmarked
      }

      bookmarks.add(message);

      final jsonList = bookmarks.map((m) => m.toJson()).toList();
      await prefs.setString(_bookmarksKey, json.encode(jsonList));

      return true;
    } catch (e) {
      return false;
    }
  }

  /// Remove a bookmark
  static Future<bool> removeBookmark(String messageId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final bookmarks = await getBookmarks();

      bookmarks.removeWhere((m) => m.id == messageId);

      final jsonList = bookmarks.map((m) => m.toJson()).toList();
      await prefs.setString(_bookmarksKey, json.encode(jsonList));

      return true;
    } catch (e) {
      return false;
    }
  }

  /// Get all bookmarks
  static Future<List<Message>> getBookmarks() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonString = prefs.getString(_bookmarksKey);

      if (jsonString == null || jsonString.isEmpty) {
        return [];
      }

      final jsonList = json.decode(jsonString) as List;
      return jsonList
          .map((json) => Message.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      return [];
    }
  }

  /// Check if a message is bookmarked
  static Future<bool> isBookmarked(String messageId) async {
    final bookmarks = await getBookmarks();
    return bookmarks.any((m) => m.id == messageId);
  }

  /// Clear all bookmarks
  static Future<bool> clearAllBookmarks() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_bookmarksKey);
      return true;
    } catch (e) {
      return false;
    }
  }
}
