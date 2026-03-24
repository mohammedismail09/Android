import 'package:flutter/material.dart';
// import 'home_screen.dart'; 
import 'landingpage.dart';

void main() {
  runApp(const TaxShieldApp());
}

class TaxShieldApp extends StatelessWidget {
  const TaxShieldApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Taxshieldadvisor',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: const Color(0xFF0077B6),
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF0077B6)),
      ),
      home: const LandingPage(), 
    );
  }
}
