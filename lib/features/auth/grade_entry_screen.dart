// lib/features/auth/grade_entry_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:yollr/core/constants/assets.dart';
import 'package:yollr/core/theme/pallete.dart';
import 'package:yollr/core/utils/responsive_utils.dart';
import 'package:yollr/features/auth/school_entry_screen.dart';

class GradeEntryScreen extends StatefulWidget {
  const GradeEntryScreen({super.key});

  @override
  State<GradeEntryScreen> createState() => _GradeEntryScreenState();
}

class _GradeEntryScreenState extends State<GradeEntryScreen> {
  int _selectedIndex = 2;

  final List<_GradeOption> _options = const [
    _GradeOption('Not in High School', null),
    _GradeOption('Grade 9', 'Class of 2026'),
    _GradeOption('Grade 10', 'Class of 2025'),
    _GradeOption('Grade 11', 'Class of 2024'),
    _GradeOption('Finished High School', 'Class of 2023'),
  ];

  late DraggableScrollableController _sheetController;

  @override
  void initState() {
    super.initState();
    _sheetController = DraggableScrollableController();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _sheetController.jumpTo(0.80);
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
            SafeArea(
              child: Column(
                children: [
                  SizedBox(height: 40 * spacing),

                  // Centered logo + text
                  Center(
                    child: Column(
                      children: [
                        Container(
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

                              // Helper text
                              Text(
                                'Grade means which year of school are you in.',
                                textAlign: TextAlign.start,
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w400,
                                  fontStyle: FontStyle.normal,
                                  fontSize: 18,
                                  height: 1.0,
                                  letterSpacing: 0.0,
                                  color: const Color(0xFF616161),
                                ),
                              ),

                              SizedBox(height: 32 * spacing),

                              // Title
                              Text(
                                'What Grade are you in?',
                                style: GoogleFonts.poppins(
                                  fontSize: 20 * font,
                                  fontWeight: FontWeight.w600,
                                  color: Pallete.primaryColor,
                                ),
                              ),

                              SizedBox(height: 24 * spacing),

                              // Options list
                              ..._options.asMap().entries.map((entry) {
                                final idx = entry.key;
                                final opt = entry.value;
                                final isSelected = _selectedIndex == idx;

                                return Padding(
                                  padding: EdgeInsets.only(
                                    bottom: 12 * spacing,
                                  ),
                                  child: _buildOptionTile(
                                    opt,
                                    isSelected,
                                    () => setState(() => _selectedIndex = idx),
                                    component,
                                    font,
                                  ),
                                );
                              }).toList(),

                              SizedBox(height: 36 * spacing),

                              // NEXT button
                              SizedBox(
                                width: double.infinity,
                                height: 52 * component,
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const SchoolEntryScreen(),
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
                                                'Yollr cares intensely about your grade privacy.\n',
                                          ),
                                          TextSpan(
                                            text:
                                                'We will never share your grade with anyone.',
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

  // --------------------------------------------------------------
  // Reusable option tile
  // --------------------------------------------------------------
  Widget _buildOptionTile(
    _GradeOption option,
    bool selected,
    VoidCallback onTap,
    double component,
    double font,
  ) {
    final bgColor = selected ? Pallete.primaryColor : Colors.white;
    final textColor = selected ? Colors.white : const Color(0xFF3B3B3B);
    final borderColor = selected ? Pallete.primaryColor : Pallete.primaryColor;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 20 * component,
          vertical: 16 * component,
        ),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: borderColor, width: 1.5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              option.grade,
              style: GoogleFonts.poppins(
                fontSize: 18 * font,
                fontWeight: FontWeight.w600,
                color: textColor,
              ),
            ),
            if (option.classOf != null)
              Text(
                option.classOf!,
                style: GoogleFonts.poppins(
                  fontSize: 14 * font,
                  fontWeight: FontWeight.w400,
                  color: textColor.withOpacity(0.8),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _GradeOption {
  final String grade;
  final String? classOf;

  const _GradeOption(this.grade, this.classOf);
}
