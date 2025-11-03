// lib/features/auth/welcome_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yollr/core/constants/assets.dart';
import 'package:yollr/core/theme/pallete.dart';
import 'package:yollr/core/utils/responsive_utils.dart';
import 'package:yollr/features/auth/login_screen.dart';
import 'package:yollr/features/auth/signup_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

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
              top: 140 * spacing,
              right: 280 * spacing,
              child: Text('😊', style: TextStyle(fontSize: 24 * component)),
            ),
            Positioned(
              bottom: 280 * spacing,
              right: 20 * spacing,
              child: Text('✨', style: TextStyle(fontSize: 20 * component)),
            ),
            Positioned(
              bottom: 80 * spacing,
              left: 30 * spacing,
              child: Text('💕', style: TextStyle(fontSize: 20 * component)),
            ),

            // Main content
            SafeArea(
              child: Column(
                children: [
                  const Spacer(flex: 2),

                  // Logo container
                  Container(
                    width: 120 * component,
                    height: 120 * component,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(28 * component),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.1),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(26 * component),
                      child: SvgPicture.asset(
                        Assets.iconsSharedLogo,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),

                  SizedBox(height: 32 * spacing),

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

                  SizedBox(height: 28 * spacing),

                  // Welcome text
                  Text(
                    'Welcome to Yollr',
                    style: GoogleFonts.poppins(
                      fontSize: 18 * font,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      height: 1.0,
                    ),
                  ),

                  SizedBox(height: 12 * spacing),

                  // Tagline
                  Text(
                    'Say it on yollr',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: 18 * font,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                      height: 1.33,
                    ),
                  ),

                  const Spacer(flex: 3),

                  // Buttons
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40 * padding),
                    child: Column(
                      children: [
                        // Login button
                        SizedBox(
                          width: double.infinity,
                          height: 52 * component,
                          child: OutlinedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LoginScreen(),
                                ),
                              );
                            },
                            style: OutlinedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              foregroundColor: Colors.white,
                              side: const BorderSide(
                                color: Colors.white,
                                width: 1.5,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(26),
                              ),
                            ),
                            child: Text(
                              'LOGIN',
                              style: GoogleFonts.poppins(
                                fontSize: 16 * font,
                                fontWeight: FontWeight.w400,
                                height: 1.0,
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: 16 * spacing),

                        // Signup button
                        SizedBox(
                          width: double.infinity,
                          height: 52 * component,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const SignupScreen(),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Pallete.primaryColor,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(26),
                              ),
                            ),
                            child: Text(
                              'SIGNUP',
                              style: GoogleFonts.poppins(
                                fontSize: 16 * font,
                                fontWeight: FontWeight.w400,
                                height: 1.0,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 40 * spacing),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
