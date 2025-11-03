// lib/features/pools/loading_pools_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:yollr/core/constants/assets.dart';
import 'package:yollr/core/theme/pallete.dart';
import 'package:yollr/core/utils/responsive_utils.dart';
import 'package:yollr/features/pools/pool_question_screen.dart';
import 'package:yollr/features/pools/widgets/top_nav_bar.dart';

class LoadingPoolsScreen extends StatefulWidget {
  const LoadingPoolsScreen({super.key});

  @override
  State<LoadingPoolsScreen> createState() => _LoadingPoolsScreenState();
}

class _LoadingPoolsScreenState extends State<LoadingPoolsScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    )..repeat(reverse: true);

    _scaleAnimation = Tween<double>(
      begin: 0.95,
      end: 1.05,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    // Auto navigate after 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            pageBuilder: (context, _, __) =>
                const PoolQuestionScreen(questionIndex: 0),
            transitionDuration: const Duration(milliseconds: 600),
            transitionsBuilder: (context, animation, _, child) {
              return FadeTransition(opacity: animation, child: child);
            },
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final spacing = ResponsiveUtils.spacingScale(context);
    final component = ResponsiveUtils.componentScale(context);
    final font = ResponsiveUtils.fontScale(context);

    return Scaffold(
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
        child: SafeArea(
          child: Column(
            children: [
              // TOP BAR: Inbox | Yollr | Profile
              const TopNavBar(inboxBadge: 3, activeTab: 'Yollr'),
              const Spacer(),

              // Logo + Loading Text
              ScaleTransition(
                scale: _scaleAnimation,
                child: SvgPicture.asset(
                  Assets.iconsPoolLoadingTree,
                  width: 100 * component,
                  height: 100 * component,
                ),
              ),

              SizedBox(height: 32 * spacing),

              Text(
                'Loading Pools...',
                style: GoogleFonts.poppins(
                  fontSize: 20 * font,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  height: 1.2,
                ),
              ),

              const Spacer(flex: 2),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTab(String text, {bool isActive = false, int? badge}) {
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
        if (badge != null)
          Positioned(
            right: -8,
            top: -4,
            child: Container(
              padding: const EdgeInsets.all(4),
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
