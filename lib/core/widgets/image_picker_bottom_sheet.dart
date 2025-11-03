import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ImagePickerBottomSheet {
  static Future<void> show({
    required BuildContext context,
    required Future<File?> Function() onPickFromGallery,
    required Future<File?> Function() onPickFromCamera,
    required void Function(File image) onImageSelected,
    String title = 'Select Image',
    Color? accentColor,
  }) {
    final Color highlightColor = accentColor ?? const Color(0xFF4C6FFF);

    return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Handle bar
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 20),

              // Title
              Text(
                title,
                style: GoogleFonts.inter(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 20),

              // Option 1: Gallery
              _OptionTile(
                icon: Icons.photo_library,
                label: 'Choose from Gallery',
                color: highlightColor,
                onTap: () async {
                  Navigator.pop(context);
                  final image = await onPickFromGallery();
                  if (image != null) onImageSelected(image);
                },
              ),

              // Option 2: Camera
              _OptionTile(
                icon: Icons.camera_alt,
                label: 'Take Photo',
                color: highlightColor,
                onTap: () async {
                  Navigator.pop(context);
                  final image = await onPickFromCamera();
                  if (image != null) onImageSelected(image);
                },
              ),

              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}

class _OptionTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color color;

  const _OptionTile({
    required this.icon,
    required this.label,
    required this.onTap,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: color),
      ),
      title: Text(
        label,
        style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w500),
      ),
      onTap: onTap,
    );
  }
}
