// lib/features/billing/billing_subscription_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:yollr/core/constants/assets.dart';
import 'package:yollr/core/theme/pallete.dart';
import 'package:yollr/core/utils/responsive_utils.dart';

/// Model for subscription plans
class SubscriptionPlan {
  final String title;
  final String description;
  final String imagePath;
  final String price;
  final String? discount;

  const SubscriptionPlan({
    required this.title,
    required this.description,
    required this.imagePath,
    required this.price,
    this.discount,
  });
}

class BillingSubscriptionScreen extends StatefulWidget {
  const BillingSubscriptionScreen({super.key});

  @override
  State<BillingSubscriptionScreen> createState() =>
      _BillingSubscriptionScreenState();
}

class _BillingSubscriptionScreenState extends State<BillingSubscriptionScreen> {
  late PageController _pageController;
  int _currentPage = 0;

  final List<SubscriptionPlan> _plans = const [
    SubscriptionPlan(
      title: 'Reveal 2 Names\nPer Week',
      description: 'See who like you',
      imagePath: Assets.billingEnvelope,
      price: '\$6.99/week',
      discount: '30% off',
    ),
    SubscriptionPlan(
      title: 'Get Unlimited\nHints',
      description: 'See who like you',
      imagePath: Assets.billingNote,
      price: '\$6.99/week',
    ),
    SubscriptionPlan(
      title: 'Get Double Coins\non Polls',
      description: 'See who like you',
      imagePath: Assets.billingCoins,
      price: '\$6.99/week',
    ),
    SubscriptionPlan(
      title: 'Secret Crush\nAlerts',
      description: 'See who like you',
      imagePath: Assets.billingSecretCrush,
      price: '\$6.99/week',
    ),
    SubscriptionPlan(
      title: '18 People liked\nyou',
      description: 'See who like you',
      imagePath: Assets.billingPeople,
      price: '\$6.99/week',
    ),
    SubscriptionPlan(
      title: 'Send Polls\nAnonymously',
      description: 'See who like you',
      imagePath: Assets.billingAnonymous,
      price: '\$6.99/week',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    _pageController.addListener(_onPageScroll);
  }

  void _onPageScroll() {
    if (_pageController.hasClients) {
      final page = _pageController.page?.round() ?? 0;
      if (_currentPage != page) {
        setState(() {
          _currentPage = page;
        });
      }
    }
  }

  @override
  void dispose() {
    _pageController.removeListener(_onPageScroll);
    _pageController.dispose();
    super.dispose();
  }

  void _onContinue() {
    debugPrint('Continue with plan: ${_plans[_currentPage].title}');
  }

  void _onMaybeLater() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final padding = ResponsiveUtils.paddingScale(context);
    final spacing = ResponsiveUtils.spacingScale(context);
    final component = ResponsiveUtils.componentScale(context);
    final font = ResponsiveUtils.fontScale(context);

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Pallete.secondaryColor, Pallete.primaryColor],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header Section
              _buildHeader(padding, spacing, font),

              SizedBox(height: 24 * spacing),

              // Fixed Card with Swipeable Content
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12 * padding),
                  child: _buildFixedCard(padding, spacing, component, font),
                ),
              ),

              SizedBox(height: 16 * spacing),
            ],
          ),
        ),
      ),
    );
  }

  // --------------------------------------------------------------
  // Header Section
  // --------------------------------------------------------------
  Widget _buildHeader(double padding, double spacing, double font) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(24 * padding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Recurring billing, Cancel\nAnytime',
            style: GoogleFonts.poppins(
              fontSize: 26 * font,
              fontWeight: FontWeight.w700,
              color: Colors.white,
              height: 1.3,
            ),
          ),
          SizedBox(height: 16 * spacing),
          RichText(
            text: TextSpan(
              style: GoogleFonts.poppins(
                fontSize: 16 * font,
                fontWeight: FontWeight.w400,
                color: Colors.white,
                height: 1.4,
              ),
              children: [
                TextSpan(
                  text:
                      'Your payment will be charged to iTunes Account, and your subscription will be auto-renew for \$6.99/week. Until you cancel in iTunes Store settings. By tapping unlock, you agree to our ',
                ),
                TextSpan(
                  text: 'Terms',
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                TextSpan(text: ' and auto-renewal.'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --------------------------------------------------------------
  // Fixed Card Container with PageView Inside
  // --------------------------------------------------------------
  Widget _buildFixedCard(
    double padding,
    double spacing,
    double component,
    double font,
  ) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24 * component),
      ),
      child: PageView.builder(
        controller: _pageController,
        itemCount: _plans.length,
        itemBuilder: (context, index) {
          return _buildCardContent(
            _plans[index],
            padding,
            spacing,
            component,
            font,
          );
        },
      ),
    );
  }

  // --------------------------------------------------------------
  // Card Content (what changes when swiping)
  // --------------------------------------------------------------
  Widget _buildCardContent(
    SubscriptionPlan plan,
    double padding,
    double spacing,
    double component,
    double font,
  ) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 24 * padding,
          vertical: 32 * padding,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              Assets.iconsSharedLogo,
              width: 32 * component,
              height: 32 * component,
            ),

            SizedBox(height: 12 * spacing),

            // Description text
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: GoogleFonts.poppins(
                  fontSize: 16 * font,
                  fontWeight: FontWeight.w500,
                  color: Pallete.primaryColor,
                  height: 1.3,
                ),
                children: [
                  TextSpan(text: plan.description),
                  TextSpan(text: '\nwith '),
                  TextSpan(
                    text: '⚡ ',
                    style: TextStyle(fontSize: 18 * font),
                  ),
                  TextSpan(
                    text: 'GOD MODE',
                    style: TextStyle(
                      color: Color(0xFF00D856),
                      fontWeight: FontWeight.w700,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 16 * spacing),

            // Feature Image
            Image.asset(
              plan.imagePath,
              width: 120 * component,
              height: 120 * component,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 120 * component,
                  height: 120 * component,
                  decoration: BoxDecoration(
                    color: Pallete.backgroundColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Icon(
                    Icons.image,
                    size: 60 * component,
                    color: Pallete.primaryColor,
                  ),
                );
              },
            ),

            SizedBox(height: 16 * spacing),

            // Smooth Page Indicator
            SmoothPageIndicator(
              controller: _pageController,
              count: _plans.length,
              effect: WormEffect(
                dotWidth: 8 * component,
                dotHeight: 8 * component,
                spacing: 8 * spacing,
                dotColor: const Color(0xFFD9D9D9),
                activeDotColor: Pallete.primaryColor,
                radius: 8 * component,
              ),
            ),

            SizedBox(height: 20 * spacing),

            // Title
            Text(
              plan.title,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 20 * font,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF3B3B3B),
                height: 1.3,
              ),
            ),

            SizedBox(height: 16 * spacing),

            // Price with discount
            Column(
              children: [
                Text(
                  plan.price,
                  style: GoogleFonts.poppins(
                    fontSize: 28 * font,
                    fontWeight: FontWeight.w700,
                    color: Pallete.primaryColor,
                    height: 1.0,
                  ),
                ),
                if (plan.discount != null) ...[
                  SizedBox(height: 4 * spacing),
                  Text(
                    plan.discount!,
                    style: GoogleFonts.poppins(
                      fontSize: 12 * font,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF00D856),
                      height: 1.0,
                    ),
                  ),
                ],
              ],
            ),

            SizedBox(height: 24 * spacing),

            // Continue Button
            SizedBox(
              width: 200,
              height: 50 * component,

              child: ElevatedButton(
                onPressed: _onContinue,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Pallete.primaryColor,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(26),
                  ),
                  shadowColor: Pallete.primaryColor.withOpacity(0.3),
                ),
                child: Text(
                  'CONTINUE',
                  style: GoogleFonts.poppins(
                    fontSize: 15 * font,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ),

            SizedBox(height: 16 * spacing),

            // Maybe Later Button
            TextButton(
              onPressed: _onMaybeLater,
              child: Text(
                'Maybe Later',
                style: GoogleFonts.poppins(
                  fontSize: 14 * font,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF9E9E9E),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
