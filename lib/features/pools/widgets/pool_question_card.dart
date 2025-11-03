// lib/features/pools/widgets/pool_question_card.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yollr/core/theme/pallete.dart';
import 'package:yollr/core/utils/responsive_utils.dart';

class PoolQuestionCard extends StatelessWidget {
  final String emoji;
  final String text;
  final List<String> answers;
  final int? selectedAnswer;
  final void Function(int index) onSelectAnswer;

  const PoolQuestionCard({
    super.key,
    required this.emoji,
    required this.text,
    required this.answers,
    required this.selectedAnswer,
    required this.onSelectAnswer,
  });

  @override
  Widget build(BuildContext context) {
    final spacing = ResponsiveUtils.spacingScale(context);
    final component = ResponsiveUtils.componentScale(context);
    final font = ResponsiveUtils.fontScale(context);

    return Column(
      children: [
        Image.asset(emoji, width: 220 * component, height: 220 * component),

        SizedBox(height: 24 * spacing),

        // QUESTION TEXT
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 40 * spacing),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: 24 * font,
              fontWeight: FontWeight.w600,
              color: Colors.white,
              height: 1.35,
              letterSpacing: -0.2,
            ),
          ),
        ),

        SizedBox(height: 56 * spacing),

        // ANSWER CHIPS
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 32 * spacing),
          child: Wrap(
            spacing: 16 * spacing,
            runSpacing: 16 * spacing,
            alignment: WrapAlignment.center,
            children: answers.asMap().entries.map((entry) {
              final idx = entry.key;
              final answer = entry.value;
              final isSelected = selectedAnswer == idx;

              return GestureDetector(
                onTap: () => onSelectAnswer(idx),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: EdgeInsets.symmetric(
                    horizontal: 28 * component,
                    vertical: 24 * component,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? Colors.white
                        : Colors.white.withOpacity(0.18),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    answer,
                    style: GoogleFonts.poppins(
                      fontSize: 15 * font,
                      fontWeight: FontWeight.w600,
                      color: isSelected ? Pallete.primaryColor : Colors.white,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),

        SizedBox(height: 40 * spacing),

        if (selectedAnswer == null)
          Text(
            'Tap to continue',
            style: GoogleFonts.poppins(
              fontSize: 14 * font,
              fontWeight: FontWeight.w500,
              color: Colors.white.withOpacity(0.7),
            ),
          ),
      ],
    );
  }
}
