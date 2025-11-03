// lib/features/pools/widgets/top_nav_bar.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yollr/core/utils/responsive_utils.dart';

class TopNavBar extends StatelessWidget {
  final int inboxBadge;
  final String activeTab;

  const TopNavBar({super.key, this.inboxBadge = 0, required this.activeTab});

  @override
  Widget build(BuildContext context) {
    final spacing = ResponsiveUtils.spacingScale(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24 * spacing),
      child: Row(
        children: [
          _buildTab(context, 'Inbox', badge: inboxBadge),
          const Spacer(),
          _buildTab(context, 'Yollr', isActive: activeTab == 'Yollr'),
          const Spacer(),
          _buildTab(context, 'Profile', isActive: activeTab == 'Profile'),
        ],
      ),
    );
  }

  Widget _buildTab(
    BuildContext context,
    String text, {
    bool isActive = false,
    int? badge,
  }) {
    final font = ResponsiveUtils.fontScale(context);
    return Stack(
      children: [
        Text(
          text,
          style: GoogleFonts.poppins(
            fontSize: 16 * font,
            fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
            color: isActive ? Colors.white : Colors.white.withOpacity(0.7),
          ),
        ),
        if (badge != null && badge > 0)
          Positioned(
            right: -10,
            top: -6,
            child: Container(
              padding: const EdgeInsets.all(5),
              decoration: const BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
              child: Text(
                '$badge',
                style: GoogleFonts.poppins(
                  fontSize: 10,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
