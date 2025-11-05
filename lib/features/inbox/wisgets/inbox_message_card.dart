import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yollr/core/utils/responsive_utils.dart';
import '../inbox_screen.dart';
import 'flame_icon.dart';

class InboxMessageCard extends StatelessWidget {
  final InboxMessage message;

  const InboxMessageCard({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    final component = ResponsiveUtils.componentScale(context);
    final spacing = ResponsiveUtils.spacingScale(context);
    final font = ResponsiveUtils.fontScale(context);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 20 * component,
        vertical: 16 * component,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE8E8E8), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          FlameIcon(color: message.flameColor),
          SizedBox(width: 16 * spacing),
          Expanded(
            child: Text(
              message.displayText,
              style: GoogleFonts.poppins(
                fontSize: 16 * font,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF3B3B3B),
              ),
            ),
          ),
          Text(
            message.time,
            style: GoogleFonts.poppins(
              fontSize: 14 * font,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF9E9E9E),
            ),
          ),
        ],
      ),
    );
  }
}
