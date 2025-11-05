// lib/features/result/result_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yollr/core/constants/assets.dart';
import 'package:yollr/core/theme/pallete.dart';
import 'package:yollr/core/utils/responsive_utils.dart';
import 'package:yollr/features/pools/widgets/top_nav_bar.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({super.key});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final spacing = ResponsiveUtils.spacingScale(context);
    final component = ResponsiveUtils.componentScale(context);
    final font = ResponsiveUtils.fontScale(context);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            TopNavBar(inboxBadge: 3, activeTab: 'Yollr'),
            SizedBox(height: 20 * spacing),
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (i) => setState(() => _currentPage = i),
                children: [
                  _buildCongratsPage(spacing, component, font),
                  _buildPlayAgainPage(spacing, component, font),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCongratsPage(double spacing, double component, double font) {
    return Container(
      color: Colors.white,

      padding: EdgeInsets.symmetric(horizontal: 24 * spacing),
      child: Column(
        children: [
          SizedBox(height: 40 * spacing),

          // Title
          Text(
            'Congrates',
            style: GoogleFonts.poppins(
              fontSize: 28 * font,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF3B3B3B),
            ),
          ),

          SizedBox(height: 40 * spacing),

          // Coin Stack
          Image.asset(
            Assets.resultCoinsStack,
            width: 160 * component,
            height: 160 * component,
          ),

          SizedBox(height: 40 * spacing),

          // Earned coins
          Text(
            'You earned 17 coins',
            style: GoogleFonts.poppins(
              fontSize: 20 * font,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF3B3B3B),
            ),
          ),

          SizedBox(height: 16 * spacing),

          Text(
            '🌟 Awesome! You just bagged 17 shiny coins! Keep it up!',
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            maxLines: 3,
            style: GoogleFonts.poppins(
              fontSize: 14 * font,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF9E9E9E),
              height: 1.4,
            ),
          ),

          const Spacer(),

          // CASH OUT Button
          _buildActionButton(
            label: 'CASH OUT',
            emoji: '🎉',
            icon: Assets.iconsFlameBig,
            onTap: () {},
            component: component,
            font: font,
          ),

          SizedBox(height: 32 * spacing),
        ],
      ),
    );
  }

  Widget _buildPlayAgainPage(double spacing, double component, double font) {
    return Container(
      // color: Colors.white,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadiusDirectional.only(
          topEnd: Radius.circular(24 * component),
          topStart: Radius.circular(24 * component),
        ),
      ),
      child: Column(
        children: [
          SizedBox(height: 40 * spacing),

          // Title
          Text(
            'Play Again',
            style: GoogleFonts.poppins(
              fontSize: 28 * font,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF3B3B3B),
            ),
          ),

          SizedBox(height: 40 * spacing),

          // Lock Shield
          Image.asset(
            Assets.resultBagShield,
            width: 140 * component,
            height: 140 * component,
          ),

          SizedBox(height: 40 * spacing),

          // Timer
          Text(
            'New Pools in 59:10',
            style: GoogleFonts.poppins(
              fontSize: 20 * font,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF3B3B3B),
            ),
          ),

          SizedBox(height: 16 * spacing),

          // Skip the wait
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '🌟 Skip the wait',
                style: GoogleFonts.poppins(
                  fontSize: 14 * font,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF9E9E9E),
                ),
              ),
            ],
          ),

          SizedBox(height: 8 * spacing),

          Text(
            'OR',
            style: GoogleFonts.poppins(
              fontSize: 12 * font,
              fontWeight: FontWeight.w600,
              color: const Color(0xFFFE4A8F),
            ),
          ),

          const Spacer(),

          // INVITE A FRIEND Button
          _buildActionButton(
            label: 'INVITE A FRIEND',
            emoji: '🎉',
            icon: Assets.iconsSharedLogo,
            onTap: () {},
            component: component,
            font: font,
          ),

          SizedBox(height: 32 * spacing),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required String label,
    required String emoji,
    required String icon,
    required VoidCallback onTap,
    required double component,
    required double font,
  }) {
    return SizedBox(
      width: 250,
      height: 56 * component,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: Pallete.primaryColor,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28 * component),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(emoji, style: const TextStyle(fontSize: 20)),
            SizedBox(width: 8),
            Text(
              label,
              style: GoogleFonts.poppins(
                fontSize: 16 * font,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(width: 8),
            SvgPicture.asset(
              icon,
              width: 20 * component,
              height: 20 * component,
              colorFilter: const ColorFilter.mode(
                Colors.white,
                BlendMode.srcIn,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ========================================
  // REUSABLE: Dotted Line
  // ========================================
  Widget _buildDottedLine(double spacing) {
    return Container(
      height: 1,

      color: const Color(0xFFFE4A8F).withOpacity(0.3),
      child: CustomPaint(painter: _DottedLinePainter()),
    );
  }
}

// ========================================
// CUSTOM PAINTER: Dotted Line
// ========================================
class _DottedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFFE4A8F).withOpacity(0.3)
      ..strokeWidth = 1.5
      ..strokeCap = StrokeCap.round;

    const dashWidth = 5.0;
    const dashSpace = 4.0;
    double startX = 0;

    while (startX < size.width) {
      canvas.drawLine(Offset(startX, 0), Offset(startX + dashWidth, 0), paint);
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
