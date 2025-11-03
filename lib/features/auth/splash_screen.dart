// lib/features/splash_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yollr/core/constants/assets.dart';
import 'package:yollr/core/theme/pallete.dart';
import 'package:yollr/core/utils/responsive_utils.dart';
import 'package:yollr/features/auth/welcome_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToWelcome();
  }

  _navigateToWelcome() async {
    await Future.delayed(const Duration(seconds: 3));
    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const WelcomeScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final padding = ResponsiveUtils.paddingScale(context);
    final spacing = ResponsiveUtils.spacingScale(context);
    final component = ResponsiveUtils.componentScale(context);
    final font = ResponsiveUtils.fontScale(context);

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Pallete.secondaryColor, Pallete.primaryColor],
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              top: 60 * spacing,
              right: 30 * spacing,
              child: Text('🎉', style: TextStyle(fontSize: 24 * component)),
            ),
            Positioned(
              top: 370 * spacing,
              right: 20 * spacing,
              child: Text('✨', style: TextStyle(fontSize: 20 * component)),
            ),
            Positioned(
              bottom: 180 * spacing,
              left: 30 * spacing,
              child: Text('💕', style: TextStyle(fontSize: 20 * component)),
            ),

            // Main content
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo container
                  Container(
                    width: 140 * component,
                    height: 140 * component,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(32 * component),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(30 * component),
                      child: SvgPicture.asset(
                        Assets.iconsSharedLogo,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),

                  SizedBox(height: 40 * spacing),

                  // Yollr text
                  Text(
                    'Yollr',
                    style: GoogleFonts.poppins(
                      fontSize: 52 * font,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      height: 1.0,
                    ),
                  ),

                  SizedBox(height: 24 * spacing),

                  // Tagline
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40 * padding),
                    child: Text(
                      'Anon. Positive. Real. Say it on yollr',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontSize: 18 * font,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        height: 1.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
