// lib/features/auth/otp_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';

import 'package:yollr/core/constants/assets.dart';
import 'package:yollr/core/theme/pallete.dart';
import 'package:yollr/core/utils/responsive_utils.dart';
import 'package:yollr/features/auth/permissions_screen.dart';

class OtpScreen extends StatefulWidget {
  final String phoneNumber;
  const OtpScreen({super.key, required this.phoneNumber});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final TextEditingController _otpController = TextEditingController();
  final FocusNode _pinFocusNode = FocusNode();

  late DraggableScrollableController _sheetController;

  late double _padding;
  late double _spacing;
  late double _component;
  late double _font;

  @override
  void initState() {
    super.initState();
    _sheetController = DraggableScrollableController();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _sheetController.jumpTo(0.45);
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _padding = ResponsiveUtils.paddingScale(context);
    _spacing = ResponsiveUtils.spacingScale(context);
    _component = ResponsiveUtils.componentScale(context);
    _font = ResponsiveUtils.fontScale(context);
  }

  @override
  void dispose() {
    _otpController.dispose();
    _pinFocusNode.dispose();
    _sheetController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Pallete.secondaryColor, Pallete.primaryColor],
          ),
        ),
        child: Stack(
          children: [
            // ------------------- HEADER CONTENT -------------------
            SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 30 * _padding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 30 * _spacing),
                    Text(
                      'Enter code sent to your phone',
                      style: GoogleFonts.poppins(
                        fontSize: 25 * _font,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 8 * _spacing),
                    RichText(
                      text: TextSpan(
                        text: 'We sent OTP code to ',
                        style: GoogleFonts.poppins(
                          fontSize: 16 * _font,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                        children: [
                          TextSpan(
                            text: widget.phoneNumber.isNotEmpty
                                ? widget.phoneNumber
                                : '+966 547 987 4565',
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 40 * _spacing),
                    Center(
                      child: Column(
                        children: [
                          Container(
                            width: 100 * _component,
                            height: 100 * _component,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(
                                24 * _component,
                              ),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color(0x26000000),
                                  offset: Offset(4, 4),
                                  blurRadius: 14,
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(22 * _component),
                              child: SvgPicture.asset(
                                Assets.iconsSharedLogo,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          SizedBox(height: 20 * _spacing),
                          Text(
                            'Yollr',
                            style: GoogleFonts.poppins(
                              fontSize: 52 * _font,
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
                        margin: EdgeInsets.only(top: 12 * _spacing),
                        width: 40 * _component,
                        height: 5 * _component,
                        decoration: BoxDecoration(
                          color: const Color(0xFFE0E0E0),
                          borderRadius: BorderRadius.circular(2.5),
                        ),
                      ),

                      Expanded(
                        child: SingleChildScrollView(
                          controller: scrollController,
                          padding: EdgeInsets.all(24 * _padding),
                          child: Column(
                            children: [
                              SizedBox(height: 8 * _spacing),

                              // Title (visible in collapsed state)
                              Text(
                                'Enter OTP',
                                style: GoogleFonts.poppins(
                                  fontSize: 25 * _font,
                                  fontWeight: FontWeight.w700,
                                  color: Pallete.primaryColor,
                                ),
                              ),
                              SizedBox(height: 30 * _spacing),

                              // Pinput
                              Pinput(
                                length: 5,
                                controller: _otpController,
                                focusNode: _pinFocusNode,
                                defaultPinTheme: _defaultPinTheme(),
                                focusedPinTheme: _focusedPinTheme(),
                                submittedPinTheme: _submittedPinTheme(),
                                hapticFeedbackType:
                                    HapticFeedbackType.lightImpact,
                                onCompleted: (_) => _onOtpCompleted(),
                                onChanged: (_) => setState(() {}),
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                                onClipboardFound: (value) {
                                  if (value.length == 5 && value.isNotEmpty) {
                                    _otpController.text = value;
                                    _onOtpCompleted();
                                  }
                                },
                              ),

                              SizedBox(height: 40 * _spacing),

                              // Resend text
                              Text(
                                "Didn't receive OTP?",
                                style: GoogleFonts.poppins(
                                  fontSize: 14 * _font,
                                  color: Colors.grey[700],
                                ),
                              ),
                              SizedBox(height: 8 * _spacing),

                              // Resend button
                              TextButton(
                                onPressed: () {
                                  // TODO: Resend OTP
                                },
                                child: Text(
                                  'Resend Code',
                                  style: GoogleFonts.poppins(
                                    fontSize: 14 * _font,
                                    fontWeight: FontWeight.w600,
                                    color: Pallete.primaryColor,
                                  ),
                                ),
                              ),

                              SizedBox(height: 40 * _spacing),

                              // CONFIRM BUTTON
                              SizedBox(
                                width: double.infinity,
                                height: 52 * _component,
                                child: ElevatedButton(
                                  onPressed: _otpController.text.length == 5
                                      ? _onOtpCompleted
                                      : null,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Pallete.primaryColor,
                                    disabledBackgroundColor: Pallete
                                        .primaryColor
                                        .withOpacity(0.4),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(26),
                                    ),
                                    elevation: 6,
                                    shadowColor: Pallete.primaryColor
                                        .withOpacity(0.3),
                                  ),
                                  child: Text(
                                    'CONFIRM & CONTINUE',
                                    style: GoogleFonts.poppins(
                                      fontSize: 16 * _font,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),

                              SizedBox(height: 20 * _spacing),

                              // Bottom padding for keyboard
                              SizedBox(
                                height:
                                    MediaQuery.of(context).viewInsets.bottom > 0
                                    ? 20
                                    : MediaQuery.of(context).padding.bottom +
                                          20,
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
  // Pinput Themes
  // --------------------------------------------------------------
  PinTheme _defaultPinTheme() {
    return PinTheme(
      width: 55 * _component,
      height: 64 * _component,
      textStyle: GoogleFonts.poppins(
        fontSize: 24 * _font,
        fontWeight: FontWeight.w600,
        color: const Color(0xFF3B3B3B),
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFD1D1D1), width: 1),
      ),
    );
  }

  PinTheme _focusedPinTheme() {
    return _defaultPinTheme().copyWith(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Pallete.primaryColor, width: 2),
      ),
    );
  }

  PinTheme _submittedPinTheme() {
    return _defaultPinTheme().copyWith(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: Pallete.primaryColor.withOpacity(0.6),
          width: 1,
        ),
      ),
    );
  }

  void _onOtpCompleted() {
    if (_otpController.text.length == 5) {
      Navigator.of(
        context,
      ).push(MaterialPageRoute(builder: (_) => const PermissionsScreen()));
    }
  }
}
