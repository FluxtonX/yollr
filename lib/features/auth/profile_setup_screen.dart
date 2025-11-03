// lib/features/auth/profile_setup_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:yollr/core/constants/assets.dart';
import 'package:yollr/core/theme/pallete.dart';
import 'package:yollr/core/utils/responsive_utils.dart';
import 'package:yollr/features/auth/profile_photo_screen.dart';

class ProfileSetupScreen extends StatefulWidget {
  const ProfileSetupScreen({super.key});

  @override
  State<ProfileSetupScreen> createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends State<ProfileSetupScreen> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();

  int _selectedGender = 0; // 0 = Girl, 1 = Boy, 2 = Non-Binary

  late DraggableScrollableController _sheetController;

  @override
  void initState() {
    super.initState();
    _sheetController = DraggableScrollableController();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _sheetController.jumpTo(0.57);
    });
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
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
            // ------------------- BACKGROUND IMAGE (BLURRED) -------------------
            Positioned.fill(
              child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/onboarding_bg.png'),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                      Colors.black54,
                      BlendMode.darken,
                    ),
                  ),
                ),
              ),
            ),

            // ------------------- HEADER TEXT (Hi, Say it on Yollr) -------------------
            SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      top: 30 * spacing,
                      left: 30 * padding,
                    ),
                    child: Text(
                      'Hi, Say it on Yollr',
                      style: GoogleFonts.poppins(
                        fontSize: 28 * font,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        height: 1.2,
                      ),
                    ),
                  ),
                  SizedBox(height: 8 * spacing),
                  Padding(
                    padding: EdgeInsets.only(left: 30 * padding),
                    child: Text(
                      'Anon. Positive. Real.',
                      style: GoogleFonts.poppins(
                        fontSize: 16 * font,
                        fontWeight: FontWeight.w400,
                        color: Colors.white.withOpacity(0.9),
                      ),
                    ),
                  ),
                  SizedBox(height: 24 * spacing),
                  Center(
                    child: Column(
                      children: [
                        Container(
                          width: 100 * component,
                          height: 100 * component,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(24 * component),
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0x26000000),
                                offset: Offset(4, 4),
                                blurRadius: 14,
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
                        SizedBox(height: 16 * spacing),
                        Text(
                          'Yollr',
                          style: GoogleFonts.poppins(
                            fontSize: 48 * font,
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
                              SizedBox(height: 20 * spacing),

                              // Name Section Title
                              Text(
                                "What's your first & Last name?",
                                style: GoogleFonts.poppins(
                                  fontSize: 20 * font,
                                  fontWeight: FontWeight.w600,
                                  color: Pallete.primaryColor,
                                ),
                              ),

                              SizedBox(height: 20 * spacing),

                              // First Name
                              _buildNameField(
                                controller: _firstNameController,
                                hint: 'ENTER YOUR FIRST NAME',
                                icon: Icons.person,
                                component: component,
                                font: font,
                              ),

                              SizedBox(height: 16 * spacing),

                              // Last Name
                              _buildNameField(
                                controller: _lastNameController,
                                hint: 'ENTER YOUR SECOND NAME',
                                icon: Icons.person,
                                component: component,
                                font: font,
                              ),

                              SizedBox(height: 32 * spacing),

                              // Gender Section Title
                              Text(
                                "What's your gender?",
                                style: GoogleFonts.poppins(
                                  fontSize: 20 * font,
                                  fontWeight: FontWeight.w600,
                                  color: Pallete.primaryColor,
                                ),
                              ),

                              SizedBox(height: 16 * spacing),

                              // Gender Buttons
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 0.0,
                                ),
                                child: Wrap(
                                  alignment: WrapAlignment.center,
                                  spacing: 20 * spacing,
                                  runSpacing: 12 * spacing,
                                  children: [
                                    SizedBox(
                                      width: 120 * component,
                                      child: _buildGenderButton(
                                        'Girl',
                                        0,
                                        component,
                                        font,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 120 * component,
                                      child: _buildGenderButton(
                                        'Boy',
                                        1,
                                        component,
                                        font,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 130 * component,
                                      child: _buildGenderButton(
                                        'Non-Binary',
                                        2,
                                        component,
                                        font,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              SizedBox(height: 36 * spacing),

                              // NEXT Button
                              SizedBox(
                                width: double.infinity,
                                height: 52 * component,
                                child: ElevatedButton(
                                  onPressed: _canProceed()
                                      ? () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const ProfilePhotoScreen(),
                                            ),
                                          );
                                        }
                                      : null,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Pallete.primaryColor,
                                    foregroundColor: Colors.white,
                                    disabledBackgroundColor: Pallete
                                        .primaryColor
                                        .withOpacity(0.4),
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

                              SizedBox(height: 20 * spacing),

                              // Bottom padding for keyboard
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

  // --------------------------------------------------------------
  // Validation
  // --------------------------------------------------------------
  bool _canProceed() {
    return _firstNameController.text.trim().isNotEmpty &&
        _lastNameController.text.trim().isNotEmpty;
  }

  // --------------------------------------------------------------
  // Name Field
  // --------------------------------------------------------------
  Widget _buildNameField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    required double component,
    required double font,
  }) {
    final spacing = ResponsiveUtils.spacingScale(context);
    return Row(
      children: [
        Container(
          width: 48 * component,
          height: 48 * component,
          decoration: BoxDecoration(
            color: Pallete.primaryColor,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Icon(icon, color: Colors.white, size: 22 * component),
        ),
        SizedBox(width: 16 * spacing),
        Expanded(
          child: TextField(
            controller: controller,
            textCapitalization: TextCapitalization.words,
            onChanged: (_) => setState(() {}), // Trigger button state
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: GoogleFonts.poppins(
                fontSize: 14 * font,
                color: const Color(0xFF9E9E9E),
              ),
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Pallete.primaryColor, width: 1.5),
              ),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Pallete.primaryColor, width: 2),
              ),
              contentPadding: EdgeInsets.zero,
            ),
            style: GoogleFonts.poppins(
              fontSize: 16 * font,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF3B3B3B),
            ),
          ),
        ),
      ],
    );
  }

  // --------------------------------------------------------------
  // Gender Button
  // --------------------------------------------------------------
  Widget _buildGenderButton(
    String label,
    int index,
    double component,
    double font,
  ) {
    final isSelected = _selectedGender == index;
    final spacing = ResponsiveUtils.spacingScale(context);
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedGender = index),
        child: Container(
          height: 48 * component,
          decoration: BoxDecoration(
            color: isSelected ? Pallete.primaryColor : Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected
                  ? Pallete.primaryColor
                  : const Color(0xFFBDBDBD),
              width: 1.5,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                label,
                style: GoogleFonts.poppins(
                  fontSize: 15 * font,
                  fontWeight: FontWeight.w600,
                  color: isSelected ? Colors.white : const Color(0xFF3B3B3B),
                ),
              ),
              SizedBox(width: 8 * spacing),
              Container(
                width: 18 * component,
                height: 18 * component,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isSelected ? Colors.white : const Color(0xFFBDBDBD),
                    width: 2,
                  ),
                ),
                child: isSelected
                    ? Center(
                        child: Container(
                          width: 8 * component,
                          height: 8 * component,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                        ),
                      )
                    : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
