import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';

class TypeWriterMarkdown extends StatefulWidget {
  const TypeWriterMarkdown({
    super.key,
    required this.text,
    this.speed = const Duration(milliseconds: 30),
    this.onFinish,
  });
  final String text;
  final Duration speed;
  final Function()? onFinish;

  @override
  State<TypeWriterMarkdown> createState() => _TypeWriterMarkdownState();
}

class _TypeWriterMarkdownState extends State<TypeWriterMarkdown> {
  String _displayText = "";
  Timer? _timer;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _startAnimation();
  }

  @override
  void didUpdateWidget(covariant TypeWriterMarkdown oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.text != widget.text) {
      _startAnimation();
    }
  }

  void _startAnimation() {
    // Reset biến
    _timer?.cancel();
    // Chạy xong thì dừng = "";
    _currentIndex = 0;

    // Bắt đầu chạy Timer
    _timer = Timer.periodic(widget.speed, (timer) {
      if (_currentIndex < widget.text.length) {
        setState(() {
          _displayText += widget.text[_currentIndex];
          _currentIndex++;
        });
      } else {
        timer.cancel();
        widget.onFinish?.call();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MarkdownBody(
      data: _displayText, // Quan trọng: Hiển thị chuỗi đang chạy
      styleSheet: MarkdownStyleSheet(
        p: const TextStyle(fontSize: 16, color: Colors.black87),
        strong: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.blueAccent,
        ),
        listBullet: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }
}
