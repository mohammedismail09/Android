import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'home_screen.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  late VideoPlayerController _controller;
  bool _hasNavigated = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/mp4/1080-taxshield-animation.mp4');

    _controller.initialize().then((_) {
      if (mounted) {
        setState(() {});
        _controller.play();
        
        // Use a Listener specifically to wait for the video to actually START moving
        _controller.addListener(_processVideoState);
      }
    }).catchError((error) {
      _navigateToHome();
    });
  }

  void _processVideoState() {
    if (!mounted || _hasNavigated) return;

    final bool isAtEnd = _controller.value.position >= _controller.value.duration;

    if (isAtEnd && _controller.value.position > const Duration(seconds: 1)) {
      _hasNavigated = true;
      _navigateToHome();
    }
  }

  void _navigateToHome() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const HomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2EEE4), 
      body: Center(
        child: _controller.value.isInitialized
            ? SizedBox.expand(
                child: FittedBox(
                  fit: BoxFit.cover,
                  child: SizedBox(
                    width: _controller.value.size.width,
                    height: _controller.value.size.height,
                    child: VideoPlayer(_controller),
                  ),
                ),
              )
            : const SizedBox.shrink(),
      ),
    );
  }

  @override
  void dispose() {
    _controller.removeListener(_processVideoState);
    _controller.dispose();
    super.dispose();
  }
}