// lib/features/auth/follow_friends_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:yollr/core/constants/assets.dart';
import 'package:yollr/core/theme/pallete.dart';
import 'package:yollr/core/utils/responsive_utils.dart';

class FollowFriendsScreen extends StatefulWidget {
  const FollowFriendsScreen({super.key});

  @override
  State<FollowFriendsScreen> createState() => _FollowFriendsScreenState();
}

class _FollowFriendsScreenState extends State<FollowFriendsScreen> {
  final Set<int> _selectedIndices = {4}; // Pre-selected example (index 4)
  late DraggableScrollableController _sheetController;

  // Mock data
  final List<_FriendSuggestion> _suggestions = List.generate(
    10,
    (index) => _FriendSuggestion(
      name: 'Emma Johnson',
      school: 'Newton North High School',
      mutualFriends: 1,
      avatarUrl: 'https://i.pravatar.cc/150?img=${index + 1}',
    ),
  );

  @override
  void initState() {
    super.initState();
    _sheetController = DraggableScrollableController();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _sheetController.jumpTo(0.77);
    });
  }

  @override
  void dispose() {
    _sheetController.dispose();
    super.dispose();
  }

  void _toggleSelection(int index) {
    setState(() {
      if (_selectedIndices.contains(index)) {
        _selectedIndices.remove(index);
      } else {
        _selectedIndices.add(index);
      }
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
            // ------------------- HEADER (Logo + Title) -------------------
            SafeArea(
              child: Column(
                children: [
                  SizedBox(height: 40 * spacing),
                  Center(
                    child: Column(
                      children: [
                        // Logo
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
                        SizedBox(height: 20 * spacing),
                        // Title
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

            // ------------------- DRAGGABLE BOTTOM SHEET -------------------
            DraggableScrollableSheet(
              controller: _sheetController,
              initialChildSize: 0.75,
              minChildSize: 0.5,
              maxChildSize: 0.95,
              snap: true,
              snapSizes: const [0.5, 0.75, 0.95],
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

                      // Sheet Title
                      Padding(
                        padding: EdgeInsets.only(top: 20 * spacing),
                        child: Text(
                          'Follow your friends to see what they talk about you',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            fontSize: 18 * font,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF3B3B3B),
                            height: 1.3,
                          ),
                        ),
                      ),

                      SizedBox(height: 16 * spacing),

                      // Friends List
                      Expanded(
                        child: ListView.separated(
                          controller: scrollController,
                          padding: EdgeInsets.symmetric(
                            horizontal: 24 * padding,
                          ),
                          itemCount: _suggestions.length,
                          separatorBuilder: (_, __) =>
                              SizedBox(height: 12 * spacing),
                          itemBuilder: (context, index) {
                            final friend = _suggestions[index];
                            final isSelected = _selectedIndices.contains(index);

                            return _buildFriendTile(
                              friend: friend,
                              isSelected: isSelected,
                              onTap: () => _toggleSelection(index),
                              component: component,
                              font: font,
                            );
                          },
                        ),
                      ),

                      // NEXT Button
                      Padding(
                        padding: EdgeInsets.fromLTRB(
                          24 * padding,
                          20 * spacing,
                          24 * padding,
                          MediaQuery.of(context).padding.bottom + 20,
                        ),
                        child: SizedBox(
                          width: double.infinity,
                          height: 52 * component,
                          child: ElevatedButton(
                            onPressed: _selectedIndices.isNotEmpty
                                ? () {
                                    // TODO: Navigate to next screen
                                  }
                                : null,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Pallete.primaryColor,
                              foregroundColor: Colors.white,
                              disabledBackgroundColor: Pallete.primaryColor
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
  // Reusable Friend Tile
  // --------------------------------------------------------------
  Widget _buildFriendTile({
    required _FriendSuggestion friend,
    required bool isSelected,
    required VoidCallback onTap,
    required double component,
    required double font,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16 * component),
        decoration: BoxDecoration(
          color: isSelected
              ? Pallete.primaryColor.withOpacity(0.08)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? Pallete.primaryColor : const Color(0xFFE0E0E0),
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            // Avatar
            Stack(
              children: [
                CircleAvatar(
                  radius: 28 * component,
                  backgroundImage: NetworkImage(friend.avatarUrl),
                ),
                if (isSelected)
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      padding: EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: Pallete.primaryColor,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 14 * component,
                      ),
                    ),
                  ),
              ],
            ),

            SizedBox(width: 16 * component),

            // Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    friend.name,
                    style: GoogleFonts.poppins(
                      fontSize: 16 * font,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF3B3B3B),
                    ),
                  ),
                  SizedBox(height: 4 * component),
                  Text(
                    friend.school,
                    style: GoogleFonts.poppins(
                      fontSize: 13 * font,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF9E9E9E),
                    ),
                  ),
                  SizedBox(height: 2 * component),
                  Text(
                    '${friend.mutualFriends} mutual friend',
                    style: GoogleFonts.poppins(
                      fontSize: 12 * font,
                      fontWeight: FontWeight.w500,
                      color: Pallete.primaryColor,
                    ),
                  ),
                ],
              ),
            ),

            // Radio (visual only, tap whole tile)
            Container(
              width: 24 * component,
              height: 24 * component,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected
                      ? Pallete.primaryColor
                      : const Color(0xFFBDBDBD),
                  width: 2,
                ),
              ),
              child: isSelected
                  ? Center(
                      child: Container(
                        width: 12 * component,
                        height: 12 * component,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Pallete.primaryColor,
                        ),
                      ),
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}

// --------------------------------------------------------------
// Data Model
// --------------------------------------------------------------
class _FriendSuggestion {
  final String name;
  final String school;
  final int mutualFriends;
  final String avatarUrl;

  const _FriendSuggestion({
    required this.name,
    required this.school,
    required this.mutualFriends,
    required this.avatarUrl,
  });
}
