// lib/features/auth/age_entry_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:numberpicker/numberpicker.dart';

import 'package:yollr/core/constants/assets.dart';
import 'package:yollr/core/theme/pallete.dart';
import 'package:yollr/core/utils/responsive_utils.dart';
import 'package:yollr/features/auth/grade_entry_screen.dart';

class AgeEntryScreen extends StatefulWidget {
  const AgeEntryScreen({super.key});

  @override
  State<AgeEntryScreen> createState() => _AgeEntryScreenState();
}

class _AgeEntryScreenState extends State<AgeEntryScreen> {
  int _selectedAge = 15; // default
  late DraggableScrollableController _sheetController;

  @override
  void initState() {
    super.initState();
    _sheetController = DraggableScrollableController();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _sheetController.jumpTo(0.55);
    });
  }

  @override
  void dispose() {
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
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Pallete.secondaryColor, Pallete.primaryColor],
          ),
        ),
        child: Stack(
          children: [
            // ------------------- HEADER (LOGO + TITLE) -------------------
            Positioned(
              top: 40 * spacing,
              left: 0,
              right: 0,
              child: SafeArea(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Logo (centered)
                    Center(
                      child: Container(
                        width: 120 * component,
                        height: 120 * component,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(28 * component),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0x26000000),
                              offset: Offset(4, 4),
                              blurRadius: 14,
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
                    ),

                    SizedBox(height: 20 * spacing),

                    // App title with emoji
                    Center(
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Yollr',
                              style: GoogleFonts.poppins(
                                fontSize: 52 * font,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                height: 1.0,
                              ),
                            ),
                            WidgetSpan(
                              child: Padding(
                                padding: EdgeInsets.only(left: 8 * spacing),
                                child: Text(
                                  '😊',
                                  style: TextStyle(fontSize: 38 * font),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // ------------------- DRAGGABLE BOTTOM SHEET (COLLAPSED ON START) -------------------
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
                              SizedBox(height: 26 * spacing),

                              // Agreement text
                              Text(
                                'By entering your age you agree to\nour terms and Privacy Policy.',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                  fontSize: 14 * font,
                                  fontWeight: FontWeight.w400,
                                  color: const Color(0xFF616161),
                                  height: 1.4,
                                ),
                              ),

                              SizedBox(height: 32 * spacing),

                              // Title
                              Text(
                                'Enter Your age',
                                style: GoogleFonts.poppins(
                                  fontSize: 20 * font,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF3B3B3B),
                                ),
                              ),
                              SizedBox(height: 16 * spacing),

                              // NUMBER PICKER
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.05),
                                      blurRadius: 10,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: NumberPicker(
                                  value: _selectedAge,
                                  minValue: 10,
                                  maxValue: 100,
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedAge = value;
                                    });
                                  },
                                  textStyle: GoogleFonts.poppins(
                                    fontSize: 24 * font,
                                    color: const Color(0xFF9E9E9E),
                                  ),
                                  selectedTextStyle: GoogleFonts.poppins(
                                    fontSize: 36 * font,
                                    fontWeight: FontWeight.w700,
                                    color: Pallete.primaryColor,
                                  ),
                                  itemHeight: 50,
                                  decoration: BoxDecoration(
                                    border: Border.symmetric(
                                      horizontal: BorderSide(
                                        color: Pallete.primaryColor.withOpacity(
                                          0.3,
                                        ),
                                        width: 1.5,
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                              SizedBox(height: 36 * spacing),

                              // NEXT button
                              SizedBox(
                                width: double.infinity,
                                height: 52 * component,
                                child: ElevatedButton(
                                  onPressed: _selectedAge < 13
                                      ? null
                                      : () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const GradeEntryScreen(),
                                            ),
                                          );
                                        },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Pallete.primaryColor,
                                    foregroundColor: Colors.white,
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(26),
                                    ),
                                    disabledBackgroundColor: const Color(
                                      0xFFDDDDDD,
                                    ),
                                  ),
                                  child: Text(
                                    'NEXT',
                                    style: GoogleFonts.poppins(
                                      fontSize: 16 * font,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),

                              SizedBox(height: 24 * spacing),

                              // Privacy note
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.lock_outline,
                                    size: 16 * component,
                                    color: const Color(0xFF616161),
                                  ),
                                  SizedBox(width: 8 * spacing),
                                  Expanded(
                                    child: RichText(
                                      text: TextSpan(
                                        style: GoogleFonts.poppins(
                                          fontSize: 12 * font,
                                          fontWeight: FontWeight.w400,
                                          color: const Color(0xFF616161),
                                          height: 1.3,
                                        ),
                                        children: const [
                                          TextSpan(
                                            text:
                                                'Yollr cares intensely about your age privacy.\n',
                                          ),
                                          TextSpan(
                                            text:
                                                'We will never share your age with anyone.',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              // Bottom padding
                              SizedBox(
                                height:
                                    MediaQuery.of(context).padding.bottom + 20,
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
