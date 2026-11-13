import 'package:flutter/material.dart';
import '../models/message.dart';
import '../services/ai_response_service.dart';
import '../services/islamic_knowledge_service.dart';
import '../widgets/message_bubble.dart';
import '../widgets/chat_input.dart';
import 'settings_screen.dart';
import 'bookmarks_screen.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  static const List<String> _quickTopics = [
    'Prayer',
    'Mercy',
    'Knowledge',
    'Patience',
    'Charity',
    'Family',
  ];

  final List<Message> _messages = [];
  final AIResponseService _aiService = AIResponseService();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _messages.add(
      Message(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        text: 'Assalamu Alaikum.\n\n'
            'Ask a question or pick a topic below. '
            '${sourceNotice(IslamicKnowledgeService())}',
        isUser: false,
        timestamp: DateTime.now(),
      ),
    );
  }

  Future<void> _handleSendMessage(String text) async {
    if (text.trim().isEmpty) return;

    final userMessage = Message(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      text: text,
      isUser: true,
      timestamp: DateTime.now(),
    );
    final reply = await _aiService.generateResponse(text);
    if (!mounted) return;

    setState(() {
      _messages.insert(0, userMessage);
      _messages.insert(0, reply);
    });
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _open(Widget screen) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Peace AI'),
        actions: [
          IconButton(
            icon: const Icon(Icons.bookmark_border),
            onPressed: () => _open(const BookmarksScreen()),
            tooltip: 'Bookmarks',
          ),
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () => _open(const SettingsScreen()),
            tooltip: 'Settings',
          ),
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () => showAboutPeaceAI(context),
            tooltip: 'About',
          ),
        ],
      ),
      // Keeps a readable line length on wide screens.
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 720),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  controller: _scrollController,
                  reverse: true,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  itemCount: _messages.length,
                  itemBuilder: (context, index) {
                    final message = _messages[index];
                    return MessageBubble(
                      key: ValueKey(message.id),
                      message: message,
                    );
                  },
                ),
              ),
              if (_messages.length <= 1)
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                  child: Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        for (final topic in _quickTopics)
                          ActionChip(
                            label: Text(topic),
                            onPressed: () => _handleSendMessage(topic),
                          ),
                      ],
                    ),
                  ),
                ),
              const Divider(),
              ChatInput(onSendMessage: _handleSendMessage),
            ],
          ),
        ),
      ),
    );
  }
}
