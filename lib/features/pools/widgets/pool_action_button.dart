// lib/features/pools/widgets/pool_action_button.dart
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yollr/core/utils/responsive_utils.dart';

class PoolActionButton extends StatelessWidget {
  final String icon;
  final String label;
  final VoidCallback onTap;

  const PoolActionButton({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final spacing = ResponsiveUtils.spacingScale(context);
    final font = ResponsiveUtils.fontScale(context);

    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          SvgPicture.asset(
            icon,
            width: 22,
            height: 22,
            colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
          ),
          SizedBox(width: 10 * spacing),
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 15 * font,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
