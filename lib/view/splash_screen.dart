import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:super_app/extensions/context_extension.dart';
import 'package:super_app/view/register_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  late Animation<double> _sizeAnimation;
  late Animation<double> _logoAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    // Circle size animation
    _sizeAnimation = Tween<double>(begin: 0.22, end: 2.2).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.75, curve: Curves.easeInOut),
      ),
    );

    // Logo fade in animation
    _logoAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.65, 1.0, curve: Curves.easeIn),
      ),
    );

    _startAnimation();
  }

  Future<void> _startAnimation() async {
    await _controller.forward();

    if (!mounted) return;

    await Future.delayed(const Duration(milliseconds: 500));

    if (!mounted) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const RegisterScreen()),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isTablet = context.isTablet;
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFFF7F7FB),
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          final circleSize = size.width * _sizeAnimation.value;

          return Stack(
            children: [
              // Gradient Circle
              Positioned(
                left: (size.width - circleSize) / 2,

                // Circle ကို အောက်ပိုင်းမှာထားခြင်း
                top: size.height * 0.50 - circleSize / 2,

                child: Container(
                  width: circleSize,
                  height: circleSize,

                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,

                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xFFFFC66D),
                        Color(0xFFF47D7D),
                        Color(0xFFB957B8),
                        Color(0xFF21B5A9),
                        Color(0xFF20A9B5),
                      ],
                    ),
                  ),
                ),
              ),

              // Logo
              Center(
                child: FadeTransition(
                  opacity: _logoAnimation,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'OLLIO',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: isTablet ? 48.sp : 96.sp,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                        ),
                      ),

                      const SizedBox(height: 4),

                      Text(
                        'Connect with your loved ones',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: isTablet ? 10.sp : 20.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
