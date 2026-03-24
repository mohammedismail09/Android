import 'package:flutter/material.dart';
import 'webview_screen.dart';
import 'state_stamp_page.dart'; // Ensure you import your Native State Stamp page if you are using it

// New Brand Palette from the Promotional Image
const Color taxShieldDeepNavy = Color(0xFF1F2F4A); // Keep Navy for text/logo (for contrast)
const Color taxShieldAccentSage = Color(0xFFB5CFB0); // Greenish background tone (New Accent)
const Color taxShieldBgCream = Color(0xFFF0EBE0); // Beige/Cream background (New Base)

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late AnimationController _entranceController;

  final List<Map<String, dynamic>> _menuItems = [
    {
      'label': 'Payment',
      'icon': Icons.payment_rounded,
      'url': 'https://payu.in/pay/C396BC8D6D52A9B2EC93D7842231ED57?source=app'
    },
    {
      'label': 'About Us',
      'icon': Icons.business_rounded,
      'url': 'https://taxshieldadvisor.com/'
    },
    {
      'label': 'Contact Us',
      'icon': Icons.contact_mail_rounded,
      'url': 'https://taxshieldadvisor.com/contact/index.html'
    },
    {
      'label': 'Pricing',
      'icon': Icons.sell_rounded,
      'url': 'https://taxshieldadvisor.com/pricing/pricing.html'
    },
    {
      'label': 'State Stamp',
      'icon': Icons.description_rounded,
      'url': 'NATIVE_PAGE' // Marker to navigate to StateStampPage()
    },
  ];

  @override
  void initState() {
    super.initState();
    _entranceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..forward();
  }

  @override
  void dispose() {
    _entranceController.dispose();
    super.dispose();
  }

  void _handleNavigation(BuildContext context, String destination) {
    if (destination == 'NATIVE_PAGE') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const StateStampPage()), // Nav to native
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => WebViewScreen(url: destination)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: taxShieldBgCream, // New Beige/Cream Background
      appBar: AppBar(
        backgroundColor: taxShieldBgCream, // Keeps AppBar blending
        elevation: 0,
        centerTitle: true,
        // Assuming your logo (assets/logo2.png) is the full text logo. If not, use image_1.png (icon only)
        title: Image.asset('assets/logo2.png', height: 45, 
          errorBuilder: (context, error, stackTrace) => const Text("TAXSHIELD")),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 32, 24, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Start Your Business", style: TextStyle(fontSize: 18, color: taxShieldDeepNavy)),
                  const Text("With Ease", 
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: taxShieldDeepNavy)),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 1.15, // Adjusted for a softer look
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final item = _menuItems[index];
                  final animation = CurvedAnimation(
                    parent: _entranceController,
                    curve: Interval((index * 0.1).clamp(0, 1.0), 1.0, curve: Curves.easeOutBack),
                  );

                  return ScaleTransition(
                    scale: animation,
                    child: FadeTransition(
                      opacity: animation,
                      child: _ModernMenuCard(
                        label: item['label'],
                        icon: item['icon'],
                        onTap: () => _handleNavigation(context, item['url']),
                      ),
                    ),
                  );
                },
                childCount: _menuItems.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ModernMenuCard extends StatefulWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;

  const _ModernMenuCard({required this.label, required this.icon, required this.onTap});

  @override
  State<_ModernMenuCard> createState() => _ModernMenuCardState();
}

class _ModernMenuCardState extends State<_ModernMenuCard> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) {
        setState(() => _isPressed = false);
        widget.onTap();
      },
      onTapCancel: () => setState(() => _isPressed = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          // Colors: Sage Green defaults to cream on press.
          color: _isPressed ? taxShieldBgCream : taxShieldAccentSage,
          borderRadius: BorderRadius.circular(22), // Soft, rounded corners
          boxShadow: [
            BoxShadow(
              color: taxShieldDeepNavy.withOpacity(_isPressed ? 0.05 : 0.1),
              blurRadius: _isPressed ? 4 : 12,
              offset: Offset(0, _isPressed ? 2 : 6),
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(widget.icon, size: 36, color: taxShieldDeepNavy), // Using navy for icons
            Text(
              widget.label,
              style: const TextStyle(
                color: taxShieldDeepNavy, // Navy text for contrast
                fontWeight: FontWeight.bold,
                fontSize: 16,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}