import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class StateStampPage extends StatefulWidget {
  final String targetUrl;
  final String title;
  const StateStampPage({super.key, required this.targetUrl, required this.title});

  @override
  State<StateStampPage> createState() => _StateStampPageState();
}

class _StateStampPageState extends State<StateStampPage> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0xFFF2EFE4))
      ..loadRequest(Uri.parse(widget.targetUrl));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: const Color(0xFFB5C9AD),
        foregroundColor: const Color(0xFF1A335D),
      ),
      body: WebViewWidget(controller: _controller),
    );
  }
}