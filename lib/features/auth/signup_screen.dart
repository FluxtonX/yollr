// lib/features/auth/signup_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:yollr/core/constants/assets.dart';
import 'package:yollr/core/theme/pallete.dart';
import 'package:yollr/core/utils/responsive_utils.dart';

import 'package:yollr/features/auth/login_screen.dart';
import 'package:yollr/features/auth/otp_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  late DraggableScrollableController _sheetController;

  @override
  void initState() {
    super.initState();
    _sheetController = DraggableScrollableController();
    // Start collapsed
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _sheetController.animateTo(
        0.45,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _sheetController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final padding = ResponsiveUtils.paddingScale(context);
    final spacing = ResponsiveUtils.spacingScale(context);
    final component = ResponsiveUtils.componentScale(context);
    final font = ResponsiveUtils.fontScale(context);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Pallete.secondaryColor, Pallete.primaryColor],
          ),
        ),
        child: Stack(
          children: [
            // ------------------- HEADER CONTENT -------------------
            SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 30 * padding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 30 * spacing),
                    Text(
                      'Create Your Account',
                      style: GoogleFonts.poppins(
                        fontSize: 25 * font,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 8 * spacing),
                    Text(
                      'Enter your information to create your account',
                      style: GoogleFonts.poppins(
                        fontSize: 16 * font,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 40 * spacing),

                    // LOGO + TEXT
                    Center(
                      child: Column(
                        children: [
                          Container(
                            width: 100 * component,
                            height: 100 * component,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(
                                24 * component,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 20,
                                  offset: const Offset(0, 10),
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(22 * component),
                              child: SvgPicture.asset(
                                Assets.iconsSharedLogo,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          SizedBox(height: 20 * spacing),
                          Text(
                            'Yollr',
                            style: GoogleFonts.poppins(
                              fontSize: 52 * font,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // ------------------- DRAGGABLE BOTTOM SHEET (STARTS COLLAPSED) -------------------
            DraggableScrollableSheet(
              controller: _sheetController,
              initialChildSize: 0.35, // Start collapsed
              minChildSize: 0.35, // Can't go lower
              maxChildSize: 0.95, // Can expand almost full
              snap: true,
              snapSizes: const [0.35, 0.5, 0.75], // Snap points
              builder: (context, scrollController) {
                return Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x26000000),
                        offset: Offset(4, 4),
                        blurRadius: 14,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      // Drag handle
                      Container(
                        margin: EdgeInsets.only(top: 12 * spacing),
                        width: 40 * component,
                        height: 5 * component,
                        decoration: BoxDecoration(
                          color: const Color(0xFFE0E0E0),
                          borderRadius: BorderRadius.circular(2.5),
                        ),
                      ),

                      Expanded(
                        child: SingleChildScrollView(
                          controller: scrollController,
                          padding: EdgeInsets.all(24 * padding),
                          child: Column(
                            children: [
                              SizedBox(height: 8 * spacing),

                              // Title (visible in collapsed state)
                              Text(
                                'Sign Up',
                                style: GoogleFonts.poppins(
                                  fontSize: 25 * font,
                                  fontWeight: FontWeight.w700,
                                  color: Pallete.primaryColor,
                                ),
                              ),
                              SizedBox(height: 20 * spacing),

                              // NAME INPUT
                              Row(
                                children: [
                                  Container(
                                    width: 50 * component,
                                    height: 50 * component,
                                    decoration: const BoxDecoration(
                                      color: Pallete.primaryColor,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      Icons.person,
                                      color: Colors.white,
                                      size: 24 * component,
                                    ),
                                  ),
                                  SizedBox(width: 16 * spacing),
                                  Expanded(
                                    child: TextField(
                                      controller: _nameController,
                                      decoration: InputDecoration(
                                        hintText: 'NAME',
                                        hintStyle: GoogleFonts.poppins(
                                          fontSize: 14 * font,
                                          color: Colors.grey.withOpacity(0.6),
                                        ),
                                        enabledBorder:
                                            const UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Pallete.primaryColor,
                                                width: 1,
                                              ),
                                            ),
                                        focusedBorder:
                                            const UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Pallete.primaryColor,
                                                width: 2,
                                              ),
                                            ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              SizedBox(height: 30 * spacing),

                              // PHONE INPUT
                              Row(
                                children: [
                                  Container(
                                    width: 50 * component,
                                    height: 50 * component,
                                    decoration: const BoxDecoration(
                                      color: Pallete.primaryColor,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      Icons.phone,
                                      color: Colors.white,
                                      size: 24 * component,
                                    ),
                                  ),
                                  SizedBox(width: 16 * spacing),
                                  Expanded(
                                    child: TextField(
                                      controller: _phoneController,
                                      keyboardType: TextInputType.phone,
                                      decoration: InputDecoration(
                                        hintText: 'MOBILE NUMBER',
                                        hintStyle: GoogleFonts.poppins(
                                          fontSize: 14 * font,
                                          color: Colors.grey.withOpacity(0.6),
                                        ),
                                        enabledBorder:
                                            const UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Pallete.primaryColor,
                                                width: 1,
                                              ),
                                            ),
                                        focusedBorder:
                                            const UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Pallete.primaryColor,
                                                width: 2,
                                              ),
                                            ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              SizedBox(height: 40 * spacing),

                              // SIGNUP BUTTON
                              SizedBox(
                                width: double.infinity,
                                height: 52 * component,
                                child: ElevatedButton(
                                  onPressed: () {
                                    final phone = _phoneController.text.trim();
                                    if (phone.isNotEmpty) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              OtpScreen(phoneNumber: phone),
                                        ),
                                      );
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Pallete.primaryColor,
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(26),
                                    ),
                                    elevation: 0,
                                  ),
                                  child: Text(
                                    'SIGN UP',
                                    style: GoogleFonts.poppins(
                                      fontSize: 16 * font,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ),

                              SizedBox(height: 24 * spacing),

                              // LOGIN LINK
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Already have an account? ',
                                    style: GoogleFonts.poppins(
                                      fontSize: 14 * font,
                                      color: const Color(0xFF616161),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const LoginScreen(),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      'Log In',
                                      style: GoogleFonts.poppins(
                                        fontSize: 14 * font,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              // Bottom padding (keyboard safe)
                              SizedBox(
                                height:
                                    MediaQuery.of(context).viewInsets.bottom > 0
                                    ? 20
                                    : MediaQuery.of(context).padding.bottom +
                                          20,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
