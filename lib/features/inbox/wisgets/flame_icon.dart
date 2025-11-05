import 'package:flutter/material.dart';
import 'package:yollr/core/constants/assets.dart';
import 'package:yollr/core/utils/responsive_utils.dart';

class FlameIcon extends StatelessWidget {
  final Color color;

  const FlameIcon({super.key, required this.color});

  @override
  Widget build(BuildContext context) {
    final component = ResponsiveUtils.componentScale(context);

    return Container(
      width: 48 * component,
      height: 48 * component,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [color.withOpacity(0.2), color.withOpacity(0.05)],
        ),
      ),
      child: Image.asset(
        Assets.iconsFlameBig,
        width: 32 * component,
        height: 32 * component,
        color: color,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) => Icon(
          Icons.local_fire_department,
          color: color,
          size: 32 * component,
        ),
      ),
    );
  }
}
