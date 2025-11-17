class Message {
  final String id;
  final String text;
  final bool isUser;
  final DateTime timestamp;
  final List<String>? references;

  Message({
    required this.id,
    required this.text,
    required this.isUser,
    required this.timestamp,
    this.references,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'text': text,
      'isUser': isUser,
      'timestamp': timestamp.toIso8601String(),
      'references': references,
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
    );
  }
}
