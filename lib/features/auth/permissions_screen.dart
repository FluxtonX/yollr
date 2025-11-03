// lib/features/auth/permissions_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:yollr/core/constants/assets.dart';
import 'package:yollr/core/theme/pallete.dart';
import 'package:yollr/core/utils/responsive_utils.dart';
import 'package:yollr/features/auth/age_entry_screen.dart';

class PermissionsScreen extends StatefulWidget {
  const PermissionsScreen({super.key});

  @override
  State<PermissionsScreen> createState() => _PermissionsScreenState();
}

class _PermissionsScreenState extends State<PermissionsScreen> {
  late DraggableScrollableController _sheetController;

  @override
  void initState() {
    super.initState();
    _sheetController = DraggableScrollableController();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _sheetController.jumpTo(0.65);
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
            // ------------------- DECORATIVE EMOJIS -------------------
            Positioned(
              top: 60 * spacing,
              left: 30 * spacing,
              child: Text('🎉', style: TextStyle(fontSize: 26 * component)),
            ),
            Positioned(
              top: 200 * spacing,
              right: 260 * spacing,
              child: Text('😊', style: TextStyle(fontSize: 26 * component)),
            ),
            Positioned(
              bottom: 220 * spacing,
              right: 20 * spacing,
              child: Text('✨', style: TextStyle(fontSize: 22 * component)),
            ),

            // ------------------- HEADER (LOGO + TITLE) -------------------
            Positioned(
              top: 40 * spacing,
              left: 0,
              right: 0,
              child: SafeArea(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Logo card
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

                    // App title
                    Text(
                      'Yollr',
                      style: GoogleFonts.poppins(
                        fontSize: 52 * font,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        height: 1.0,
                      ),
                      textAlign: TextAlign.center,
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

                              // Permission 1: Notifications
                              _buildPermissionItem(
                                Assets.iconsSharedBell,
                                'Allow Yollr to send\nnotifications?',
                                component,
                                spacing,
                                font,
                              ),
                              SizedBox(height: 16 * spacing),

                              // Permission 2: Contacts
                              _buildPermissionItem(
                                Assets.iconsSharedContacts,
                                'Allow Yollr to access\nyour contacts?',
                                component,
                                spacing,
                                font,
                              ),
                              SizedBox(height: 16 * spacing),

                              // Permission 3: Location
                              _buildPermissionItem(
                                Assets.iconsSharedLocationPin,
                                'Yollr needs to find your\nschool location.',
                                component,
                                spacing,
                                font,
                              ),

                              SizedBox(height: 36 * spacing),

                              // NEXT button
                              SizedBox(
                                width: double.infinity,
                                height: 52 * component,
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (_) => const AgeEntryScreen(),
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
                                    child: Text(
                                      'Yollr cares deeply about your privacy.\nWe will never share your data with anyone.',
                                      style: GoogleFonts.poppins(
                                        fontSize: 12 * font,
                                        fontWeight: FontWeight.w400,
                                        color: const Color(0xFF616161),
                                        height: 1.3,
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

  // --------------------------------------------------------------
  // Reusable permission item
  // --------------------------------------------------------------
  Widget _buildPermissionItem(
    String iconPath,
    String text,
    double component,
    double spacing,
    double font,
  ) {
    return Container(
      padding: EdgeInsets.all(16 * component),
      decoration: BoxDecoration(
        color: const Color(0xFFFFE4F0),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            width: 50 * component,
            height: 50 * component,
            decoration: BoxDecoration(
              color: Pallete.primaryColor,
              borderRadius: BorderRadius.circular(12),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x26000000),
                  offset: Offset(2, 4),
                  blurRadius: 10,
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.all(12 * component),
              child: SvgPicture.asset(
                iconPath,
                colorFilter: const ColorFilter.mode(
                  Colors.white,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
          SizedBox(width: 16 * spacing),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.poppins(
                fontSize: 18 * font,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF3B3B3B),
                height: 1.2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
