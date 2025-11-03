// lib/features/auth/profile_photo_screen.dart
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import 'package:yollr/core/constants/assets.dart';
import 'package:yollr/core/theme/pallete.dart';
import 'package:yollr/core/utils/responsive_utils.dart';
import 'package:yollr/core/widgets/image_picker_bottom_sheet.dart';
import 'package:yollr/features/pools/loading_pools_screen.dart';

class ProfilePhotoScreen extends StatefulWidget {
  const ProfilePhotoScreen({super.key});

  @override
  State<ProfilePhotoScreen> createState() => _ProfilePhotoScreenState();
}

class _ProfilePhotoScreenState extends State<ProfilePhotoScreen> {
  File? _pickedImage;
  final ImagePicker _picker = ImagePicker();

  late DraggableScrollableController _sheetController;

  @override
  void initState() {
    super.initState();
    _sheetController = DraggableScrollableController();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _sheetController.jumpTo(0.57);
    });
  }

  @override
  void dispose() {
    _sheetController.dispose();
    super.dispose();
  }

  /// Pick from gallery
  Future<void> _choosePhoto() async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 85,
    );
    if (image != null) {
      setState(() => _pickedImage = File(image.path));
    }
  }

  /// Capture from camera
  Future<void> _takePhoto() async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 85,
    );
    if (image != null) {
      setState(() => _pickedImage = File(image.path));
    }
  }

  bool _canProceed() => _pickedImage != null;

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
            // ------------------- BACKGROUND IMAGE (BLURRED) -------------------
            Positioned.fill(
              child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/onboarding_bg.png'),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                      Colors.black54,
                      BlendMode.darken,
                    ),
                  ),
                ),
              ),
            ),

            // ------------------- HEADER (Hi, Say it on Yollr) -------------------
            SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      top: 30 * spacing,
                      left: 30 * padding,
                    ),
                    child: Text(
                      'Hi, Say it on Yollr',
                      style: GoogleFonts.poppins(
                        fontSize: 28 * font,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        height: 1.2,
                      ),
                    ),
                  ),
                  SizedBox(height: 8 * spacing),
                  Padding(
                    padding: EdgeInsets.only(left: 30 * padding),
                    child: Text(
                      'Anon. Positive. Real.',
                      style: GoogleFonts.poppins(
                        fontSize: 16 * font,
                        fontWeight: FontWeight.w400,
                        color: Colors.white.withOpacity(0.9),
                      ),
                    ),
                  ),
                  SizedBox(height: 24 * spacing),
                  Center(
                    child: Column(
                      children: [
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
                        SizedBox(height: 16 * spacing),
                        Text(
                          'Yollr',
                          style: GoogleFonts.poppins(
                            fontSize: 48 * font,
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
                              SizedBox(height: 20 * spacing),

                              // Title
                              Text(
                                'Profile Photo',
                                style: GoogleFonts.poppins(
                                  fontSize: 24 * font,
                                  fontWeight: FontWeight.w600,
                                  color: Pallete.primaryColor,
                                ),
                              ),
                              SizedBox(height: 8 * spacing),
                              Text(
                                'Your looking matters us the most',
                                style: GoogleFonts.poppins(
                                  fontSize: 14 * font,
                                  fontWeight: FontWeight.w400,
                                  color: const Color(0xFF757575),
                                ),
                              ),
                              SizedBox(height: 18 * spacing),

                              // Photo Placeholder / Image
                              // ---- Photo Placeholder / Image ----
                              Center(
                                child: GestureDetector(
                                  onTap: () {
                                    ImagePickerBottomSheet.show(
                                      context: context,
                                      onPickFromGallery: () async {
                                        final XFile? image = await _picker
                                            .pickImage(
                                              source: ImageSource.gallery,
                                              imageQuality: 85,
                                            );
                                        return image != null
                                            ? File(image.path)
                                            : null;
                                      },
                                      onPickFromCamera: () async {
                                        final XFile? image = await _picker
                                            .pickImage(
                                              source: ImageSource.camera,
                                              imageQuality: 85,
                                            );
                                        return image != null
                                            ? File(image.path)
                                            : null;
                                      },
                                      onImageSelected: (File image) {
                                        setState(() => _pickedImage = image);
                                      },
                                      title: 'Add a Profile Photo',
                                      accentColor: Pallete.primaryColor,
                                    );
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Container(
                                      width: 120 * component,
                                      height: 120 * component,
                                      decoration: BoxDecoration(
                                        color: const Color(0xffF7F7F7),
                                        borderRadius: BorderRadius.circular(
                                          20 * component,
                                        ),
                                        border: Border.all(
                                          color: Pallete.secondaryColor,
                                          width: 2,
                                        ),
                                        boxShadow: const [
                                          BoxShadow(
                                            color: Color(0x1A000000),
                                            offset: Offset(0, 4),
                                            blurRadius: 8,
                                          ),
                                        ],
                                      ),
                                      child: _pickedImage == null
                                          ? Image.asset(
                                              'assets/images/blue_person_add.png',
                                            )
                                          : ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                    18 * component,
                                                  ),
                                              child: Image.file(
                                                _pickedImage!,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                    ),
                                  ),
                                ),
                              ),

                              SizedBox(height: 18 * spacing),

                              // Helper text
                              Text(
                                _pickedImage == null
                                    ? 'Add a photo so your friends find you'
                                    : 'Your Profile Photo',
                                style: GoogleFonts.poppins(
                                  fontSize: 14 * font,
                                  fontWeight: FontWeight.w400,
                                  color: const Color(0xFF757575),
                                ),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: 32 * spacing),

                              // Action Buttons
                              Row(
                                children: [
                                  // CHOOSE / CHANGE PHOTO
                                  Expanded(
                                    child: SizedBox(
                                      height: 52 * component,
                                      child: ElevatedButton(
                                        onPressed: _pickedImage == null
                                            ? _choosePhoto
                                            : _choosePhoto,
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Pallete.primaryColor,
                                          foregroundColor: Colors.white,
                                          elevation: 0,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              26 * component,
                                            ),
                                          ),
                                        ),
                                        child: Text(
                                          _pickedImage == null
                                              ? 'CHOOSE A PHOTO'
                                              : 'CHANGE PHOTO',
                                          style: GoogleFonts.poppins(
                                            fontSize: 15 * font,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 12 * spacing),
                                  // TAKE A PHOTO
                                  Expanded(
                                    child: SizedBox(
                                      height: 52 * component,
                                      child: OutlinedButton(
                                        onPressed: _takePhoto,
                                        style: OutlinedButton.styleFrom(
                                          side: const BorderSide(
                                            color: Pallete.primaryColor,
                                            width: 1.5,
                                          ),
                                          foregroundColor: Pallete.primaryColor,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              26 * component,
                                            ),
                                          ),
                                        ),
                                        child: Text(
                                          'TAKE A PHOTO',
                                          style: GoogleFonts.poppins(
                                            fontSize: 15 * font,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 36 * spacing),

                              // NEXT Button
                              SizedBox(
                                width: double.infinity,
                                height: 52 * component,
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => LoadingPoolsScreen(),
                                      ),
                                    );
                                  },
                                  // onPressed: _canProceed() ? () {} : null,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Pallete.primaryColor,
                                    foregroundColor: Colors.white,
                                    disabledBackgroundColor: Pallete
                                        .primaryColor
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

                              SizedBox(height: 20 * spacing),

                              // Bottom padding
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
}
