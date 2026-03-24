import 'package:flutter/material.dart';
import 'webview_screen.dart';

// Brand Palette from Logo
const Color taxShieldDarkBlue = Color(0xFF1B3D59);
const Color taxShieldLightBlue = Color(0xFF4EB4E8);

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late AnimationController _entranceController;

  // Your specific links preserved here
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
      'url': 'https://taxshieldadvisor.com/state_stamp.html'
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

  void _openWebView(BuildContext context, String url) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => WebViewScreen(url: url)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA), // Modern light background
      appBar: AppBar(
        backgroundColor: taxShieldDarkBlue,
        elevation: 0,
        centerTitle: true,
        title: Image.asset('assets/logo2.png', height: 40, 
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
                  const Text("Hello,", style: TextStyle(fontSize: 18, color: Colors.grey)),
                  const Text("Welcome Back", 
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: taxShieldDarkBlue)),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 1.1,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final item = _menuItems[index];
                  // Staggered Entrance Animation logic
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
                        onTap: () => _openWebView(context, item['url']),
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
          color: _isPressed ? taxShieldLightBlue : taxShieldDarkBlue,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: taxShieldDarkBlue.withOpacity(0.2),
              blurRadius: _isPressed ? 4 : 10,
              offset: Offset(0, _isPressed ? 2 : 6),
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(widget.icon, size: 32, color: _isPressed ? Colors.white : taxShieldLightBlue),
            Text(
              widget.label,
              style: TextStyle(
                color: _isPressed ? taxShieldDarkBlue : Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}