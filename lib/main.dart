import 'package:flutter/material.dart';
import 'landingpage.dart';

void main() => runApp(const TaxshieldApp());

class TaxshieldApp extends StatelessWidget {
  const TaxshieldApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
      home: const LandingPage(),
    );
  }
}