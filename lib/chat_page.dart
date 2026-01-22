import 'package:firebase_ai/firebase_ai.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo_ai/type_writer_markdown.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  // 1. Khai báo Prompt ở đây cho gọn code
  static const String _foodAnalysisPrompt = """
Vai trò: Bạn là chuyên gia toán AI người Việt Nam.

""";

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late final GenerativeModel _model;
  late final ChatSession _chat;
  final TextEditingController _controller = TextEditingController();
  final List<Content> _messages = [];
  bool _isLoading = false;

  bool _isTyping = false;

  bool get _isLocked => _isLoading || _isTyping;

  @override
  void initState() {
    super.initState();
    _model = FirebaseAI.googleAI().generativeModel(
      model: 'gemini-2.5-flash',
      systemInstruction: Content.system(ChatPage._foodAnalysisPrompt),
    );
    _chat = _model.startChat();
    // Thêm tin nhắn chào mừng
    _messages.add(
      Content.model([
        TextPart(
          "Chào bạn! Gửi ảnh đồ ăn vào đây để tớ soi calo cho nhé! 🥗📸",
        ),
      ]),
    );
  }

  Future<void> _sendMessage() async {
    final text = _controller.text;
    if (text.isEmpty) return;

    setState(() {
      _messages.add(Content.text(text));
      _isLoading = true;
      _controller.clear();
    });

    try {
      final response = await _chat.sendMessage(Content.text(text));
      if (response.text != null) {
        setState(() {
          _messages.add(Content.model([TextPart(response.text!)]));
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Lỗi: $e')));
      }
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flutter Demo AI')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                final isUser = message.role == 'user';
                final text = message.parts.fold('', (previousValue, part) {
                  return previousValue + (part is TextPart ? part.text : '');
                });

                return Align(
                  alignment: isUser
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isUser ? Colors.blue[100] : Colors.grey[200],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.8,
                    ),
                    child: isUser
                        ? Text(text)
                        : TypeWriterMarkdown(
                            text: text,
                            onFinish: () {
                              setState(() {
                                _isTyping = false;
                              });
                            },
                          ),
                  ),
                );
              },
            ),
          ),
          if (_isLoading) const LinearProgressIndicator(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: 'Nhập tin nhắn...',
                      border: OutlineInputBorder(),
                    ),
                    onSubmitted: (_) => _sendMessage(),
                  ),
                ),
                IconButton(
                  onPressed: _isLocked ? null : _sendMessage,
                  icon: const Icon(Icons.send),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
