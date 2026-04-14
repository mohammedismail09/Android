import 'package:flutter/material.dart';
import 'webview_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Color constants
    // const Color sageGreen = Color(0xFFB9C9B1);
    const Color darkBlue = Color(0xFF1A2E44);
    // const Color creamBg = Color(0xFFF2EEE4);

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            // 🔹 Full screen background image
            Positioned.fill(
              child: Opacity(
                opacity: 0.15, // Subtle opacity for background image
                child: Image.asset(
                  'assets/Background.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),

            // 🔹 Foreground content (your original widgets)
            SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 1. Logo Top Center
                  Center(
                    child: Image.asset(
                      'assets/new-logo-cropped-no-bg.png',
                      height: 80,
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(height: 30),

                  // 2. Header Text
                  const Text(
                    "Start Your Business",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: darkBlue,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const Text(
                    "With Ease",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: darkBlue,
                    ),
                  ),
                  const SizedBox(height: 30),

                  // 3. 2x2 Grid + Bottom Buttons
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    childAspectRatio: 1.1,
                    children: [
                      _buildCard(context, "Payment", Icons.credit_card, "https://payu.in/pay/C396BC8D6D52A9B2EC93D7842231ED57?source=app"),
                      _buildCard(context, "About Us", Icons.business, "https://taxshieldadvisor.com/"),
                      _buildCard(context, "Contact Us", Icons.contact_page, "https://taxshieldadvisor.com/contact/index.html"),
                      _buildCard(context, "Pricing", Icons.local_offer, "https://taxshieldadvisor.com/pricing/pricing.html"),
                      _buildCard(context, "State Stamp", Icons.description, "https://taxshieldadvisor.com/state_stamp.html"),
                      _buildCard(context, "Appointment", Icons.calendar_month, "https://calendly.com/simar-taxshieldadvisor"),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(BuildContext context, String title, IconData icon, String url) {
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => WebViewScreen(url: url, title: title))),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFB9C9B1),
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              // ignore: deprecated_member_use
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 5),
            )
          ],
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(icon, size: 35, color: const Color(0xFF1A2E44)),
            Text(title, style: const TextStyle(color: Color(0xFF1A2E44), fontWeight: FontWeight.bold, fontSize: 16)),
          ],
        ),
      ),
    );
  }
}