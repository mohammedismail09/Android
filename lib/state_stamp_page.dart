import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class StateStampPage extends StatefulWidget {
  const StateStampPage({super.key});

  @override
  State<StateStampPage> createState() => _StateStampPageState();
}

class _StateStampPageState extends State<StateStampPage> {
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();

    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(
        Uri.parse("https://taxshieldadvisor.com/state_stamp.html"),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("State Stamp"),
      ),
      body: WebViewWidget(controller: controller),
    );
  }
}