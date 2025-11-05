import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yollr/core/theme/pallete.dart';
import 'package:yollr/core/utils/responsive_utils.dart';

class SeeWhoButton extends StatelessWidget {
  final VoidCallback onPressed;

  const SeeWhoButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final component = ResponsiveUtils.componentScale(context);
    final spacing = ResponsiveUtils.spacingScale(context);
    final font = ResponsiveUtils.fontScale(context);

    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Pallete.secondaryColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(23)),
        minimumSize: Size(double.infinity, 46 * component),
        shadowColor: Pallete.primaryColor.withOpacity(0.3),
        elevation: 6,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.lock, color: Colors.white, size: 18 * component),
          SizedBox(width: 10 * spacing),
          Text(
            'SEE WHO LIKE YOU',
            style: GoogleFonts.poppins(
              fontSize: 14 * font,
              fontWeight: FontWeight.w600,
              color: Colors.white,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }
}
