import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/splash_screen.dart';
import 'screens/welcome_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/login_screen.dart';
import 'screens/phone_input_screen.dart';
import 'screens/phone_verification.dart';
import 'screens/verified_success_screen.dart';
import 'screens/doc_scanner_screen.dart';

void main() {
  runApp(const LexiLensApp());
}

class LexiLensApp extends StatelessWidget {
  const LexiLensApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LexiLens',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFFB894F6), // Purple theme
        scaffoldBackgroundColor: Colors.white,
        textTheme: GoogleFonts.poppinsTextTheme(),
        useMaterial3: true,
      ),
      routes: {
        '/welcome': (context) => const WelcomeScreen(),
        '/signup': (context) => const SignUpScreen(),
        '/login': (context) => const LoginScreen(),
        '/phone-input': (context) => const PhoneInputScreen(),
        '/phone-verify': (context) => const PhoneVerificationScreen(),
        '/verified': (context) => const VerifiedSuccessScreen(),
        '/scanner': (context) => const DocScannerScreen(),
      },
      home: const SplashScreen(),
    );
  }
}
