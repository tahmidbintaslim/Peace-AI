import 'islamic_content.dart';

class Message {
  final String id;
  final String text;
  final bool isUser;
  final DateTime timestamp;
  final List<String>? references;

  /// Texts from the search API, carried whole because they are not in the
  /// built-in dataset that [references] point into.
  final List<SearchMatch>? matches;

  Message({
    required this.id,
    required this.text,
    required this.isUser,
    required this.timestamp,
    this.references,
    this.matches,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'text': text,
      'isUser': isUser,
      'timestamp': timestamp.toIso8601String(),
      'references': references,
      'matches': matches?.map((m) => m.toJson()).toList(),
    };
  }

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json['id'] as String,
      text: json['text'] as String,
      isUser: json['isUser'] as bool,
      timestamp: DateTime.parse(json['timestamp'] as String),
      references: json['references'] != null
          ? List<String>.from(json['references'] as List)
          : null,
      matches: (json['matches'] as List?)
          ?.map((m) => SearchMatch.fromJson(m as Map<String, dynamic>))
          .toList(),
    );
  }
}
