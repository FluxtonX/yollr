// lib/features/auth/school_entry_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:yollr/core/constants/assets.dart';
import 'package:yollr/core/theme/pallete.dart';
import 'package:yollr/core/utils/responsive_utils.dart';
import 'package:yollr/features/auth/profile_setup_screen.dart';

class SchoolEntryScreen extends StatefulWidget {
  const SchoolEntryScreen({super.key});

  @override
  State<SchoolEntryScreen> createState() => _SchoolEntryScreenState();
}

class _SchoolEntryScreenState extends State<SchoolEntryScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  // Mock data
  final List<_School> _allSchools = const [
    _School('Newton North High School', 'Newtonville, MA', 1470),
    _School('Newton South High School', 'Newton, MA', 1320),
    _School('Brookline High School', 'Brookline, MA', 980),
    _School('Lexington High School', 'Lexington, MA', 1120),
    _School('Wellesley High School', 'Wellesley, MA', 890),
    _School('Needham High School', 'Needham, MA', 750),
    _School('Wayland High School', 'Wayland, MA', 620),
  ];

  late List<_School> _filteredSchools;
  _School? _selectedSchool;

  late DraggableScrollableController _sheetController;

  @override
  void initState() {
    super.initState();
    _filteredSchools = _allSchools;
    _sheetController = DraggableScrollableController();

    _searchController.addListener(() {
      setState(() {
        _searchQuery = _searchController.text.toLowerCase();
        _filteredSchools = _allSchools
            .where((s) => s.name.toLowerCase().contains(_searchQuery))
            .toList();
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _sheetController.dispose();
    super.dispose();
  }

  void _selectSchool(_School school) {
    setState(() {
      _selectedSchool = school;
    });
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
            // ------------------- Header (logo + title) -------------------
            SafeArea(
              child: Column(
                children: [
                  SizedBox(height: 40 * spacing),
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

            // ------------------- Draggable Bottom Sheet -------------------
            DraggableScrollableSheet(
              controller: _sheetController,
              initialChildSize: 0.75, // Start at 75%
              minChildSize: 0.5, // Minimum 50%
              maxChildSize: 0.95, // Max almost full screen
              snap: true,
              snapSizes: const [0.5, 0.75], // Snap points
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

                              // Title
                              Text(
                                'Pick your school',
                                style: GoogleFonts.poppins(
                                  fontSize: 20 * font,
                                  fontWeight: FontWeight.w600,
                                  color: Pallete.primaryColor,
                                ),
                              ),

                              SizedBox(height: 20 * spacing),

                              // Search bar
                              TextField(
                                controller: _searchController,
                                decoration: InputDecoration(
                                  hintText: 'Search...',
                                  hintStyle: GoogleFonts.poppins(
                                    fontSize: 16 * font,
                                    color: const Color(0xFF9E9E9E),
                                  ),
                                  prefixIcon: Icon(
                                    Icons.search,
                                    color: const Color(0xFF9E9E9E),
                                    size: 24 * component,
                                  ),
                                  filled: true,
                                  fillColor: const Color(0xFFF5F5F5),
                                  contentPadding: EdgeInsets.symmetric(
                                    vertical: 16 * component,
                                    horizontal: 20 * component,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                              ),

                              SizedBox(height: 20 * spacing),

                              // Schools list
                              _filteredSchools.isEmpty
                                  ? Center(
                                      child: Text(
                                        'No schools found',
                                        style: GoogleFonts.poppins(
                                          fontSize: 16 * font,
                                          color: const Color(0xFF9E9E9E),
                                        ),
                                      ),
                                    )
                                  : ListView.separated(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: _filteredSchools.length,
                                      separatorBuilder: (_, __) => Divider(
                                        height: 1,
                                        color: const Color(0xFFE0E0E0),
                                      ),
                                      itemBuilder: (context, index) {
                                        final school = _filteredSchools[index];
                                        final isSelected =
                                            _selectedSchool?.name ==
                                            school.name;

                                        return _buildSchoolTile(
                                          school: school,
                                          isSelected: isSelected,
                                          component: component,
                                          font: font,
                                          onTap: () => _selectSchool(school),
                                        );
                                      },
                                    ),

                              SizedBox(height: 36 * spacing),

                              // NEXT button
                              SizedBox(
                                width: double.infinity,
                                height: 52 * component,
                                child: ElevatedButton(
                                  onPressed: _selectedSchool == null
                                      ? null
                                      : () {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (_) =>
                                                  ProfileSetupScreen(),
                                            ),
                                          );
                                        },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Pallete.primaryColor,
                                    foregroundColor: Colors.white,
                                    disabledBackgroundColor: const Color(
                                      0xFFBBBBBB,
                                    ),
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
                                                'Yollr cares intensely about your schools privacy.\n',
                                          ),
                                          TextSpan(
                                            text:
                                                'We will never share your school with anyone.',
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

  Widget _buildSchoolTile({
    required _School school,
    required bool isSelected,
    required double component,
    required double font,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 12 * component),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 32 * component,
              child: Radio<_School>(
                value: school,
                groupValue: _selectedSchool,
                onChanged: (_) => onTap(),
                activeColor: Pallete.primaryColor,
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    school.name,
                    style: GoogleFonts.poppins(
                      fontSize: 16 * font,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF3B3B3B),
                    ),
                  ),
                  SizedBox(height: 4 * component),
                  Text(
                    school.location,
                    style: GoogleFonts.poppins(
                      fontSize: 14 * font,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF9E9E9E),
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '${school.memberCount}',
                  style: GoogleFonts.poppins(
                    fontSize: 16 * font,
                    fontWeight: FontWeight.w600,
                    color: Pallete.primaryColor,
                  ),
                ),
                Text(
                  'MEMBERS',
                  style: GoogleFonts.poppins(
                    fontSize: 12 * font,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF9E9E9E),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _School {
  final String name;
  final String location;
  final int memberCount;

  const _School(this.name, this.location, this.memberCount);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _School &&
          runtimeType == other.runtimeType &&
          name == other.name;

  @override
  int get hashCode => name.hashCode;
}
