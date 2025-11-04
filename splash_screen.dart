import 'package:flutter/material.dart';
import 'dart:async';
import 'onboarding_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';

// Custom clipper to create the large white oval with a wave notch at the bottom
class _OvalWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final Path path = Path();

    // Start at top-center and draw an oval-like shape
    path.moveTo(size.width * 0.5, 0);
    // Top-right curve
    path.quadraticBezierTo(
      size.width,
      0,
      size.width,
      size.height * 0.45,
    );
    // Right-bottom curve into the wave
    path.quadraticBezierTo(
      size.width,
      size.height * 0.85,
      size.width * 0.65,
      size.height * 0.92,
    );
    // Wave notch
    path.quadraticBezierTo(
      size.width * 0.5,
      size.height,
      size.width * 0.35,
      size.height * 0.92,
    );
    // Left-bottom curve
    path.quadraticBezierTo(
      0,
      size.height * 0.85,
      0,
      size.height * 0.45,
    );
    // Top-left curve
    path.quadraticBezierTo(0, 0, size.width * 0.5, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

// Painter for the small decorative wave line near the bottom
class _AccentWavePainter extends CustomPainter {
  final Color color;
  _AccentWavePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.round;

    final Path wave = Path();
    wave.moveTo(0, size.height * 0.5);
    wave.quadraticBezierTo(
      size.width * 0.2,
      size.height * 0.35,
      size.width * 0.5,
      size.height * 0.45,
    );
    wave.quadraticBezierTo(
      size.width * 0.8,
      size.height * 0.55,
      size.width,
      size.height * 0.4,
    );
    canvas.drawPath(wave, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  
  @override
  void initState() {
    super.initState();
    
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeIn,
    ));
    
    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    ));
    
    _animationController.forward();
    
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const OnboardingScreen()),
      );
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const Color lavender = Color(0xFFB894F6); // Splash background close to reference
    return Scaffold(
      backgroundColor: lavender,
      body: SafeArea(
        child: Center(
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: ScaleTransition(
              scale: _scaleAnimation,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // App name at the top
                  Positioned(
                    top: 24,
                    child: Text(
                      'LexiLens',
                      style: GoogleFonts.poppins(
                        fontSize: 34,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        letterSpacing: 4,
                      ),
                    ),
                  ),

                  // Large white oval with wave notch
                  Align(
                    alignment: Alignment.center,
                    child: ClipPath(
                      clipper: _OvalWaveClipper(),
                      child: Container(
                        width: 260,
                        height: 360,
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Illustration inside the oval
                              Expanded(
                                child: SvgPicture.asset(
                                  'assets/images/splash_illustration.svg',
                                  fit: BoxFit.contain,
                                  // If asset is missing, show a friendly placeholder so the app still runs
                                  placeholderBuilder: (context) => const Icon(
                                    Icons.self_improvement,
                                    size: 96,
                                    color: Color(0xFFB894F6),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Decorative small wave line near the bottom
                  Positioned(
                    bottom: 28,
                    child: CustomPaint(
                      size: const Size(180, 40),
                      painter: _AccentWavePainter(color: Colors.white.withOpacity(0.9)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Custom clipper for the wave effect
class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    
    var firstControlPoint = Offset(size.width * 0.7, size.height * 0.5);
    var firstEndPoint = Offset(size.width * 0.5, size.height * 0.7);
    path.quadraticBezierTo(
      firstControlPoint.dx, 
      firstControlPoint.dy, 
      firstEndPoint.dx, 
      firstEndPoint.dy
    );
    
    var secondControlPoint = Offset(size.width * 0.3, size.height * 0.9);
    var secondEndPoint = Offset(0, size.height * 0.5);
    path.quadraticBezierTo(
      secondControlPoint.dx, 
      secondControlPoint.dy, 
      secondEndPoint.dx, 
      secondEndPoint.dy
    );
    
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
