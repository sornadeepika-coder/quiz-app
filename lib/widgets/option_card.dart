import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// Interactive card representing a single multiple-choice answer option.
/// Displays option letters (A, B, C, D) and dynamically reflects selection
/// and green/red correctness feedback once the question is answered.
class OptionCard extends StatelessWidget {
  final int optionIndex;
  final String optionText;
  final bool isAnswered;
  final bool isSelected;
  final bool isCorrect;
  final VoidCallback? onTap;

  const OptionCard({
    super.key,
    required this.optionIndex,
    required this.optionText,
    required this.isAnswered,
    required this.isSelected,
    required this.isCorrect,
    required this.onTap,
  });

  String get optionLetter {
    const letters = ['A', 'B', 'C', 'D'];
    if (optionIndex >= 0 && optionIndex < letters.length) {
      return letters[optionIndex];
    }
    return '';
  }

  @override
  Widget build(BuildContext context) {
    // Determine colors based on state
    Color backgroundColor = AppTheme.cardBackground;
    Color borderColor = AppTheme.borderLight;
    double borderWidth = 1.2;
    Color letterBgColor = AppTheme.primaryLight;
    Color letterTextColor = AppTheme.primaryBlue;
    Widget? trailingWidget;

    if (isAnswered) {
      if (isSelected) {
        if (isCorrect) {
          // Selected and Correct -> GREEN
          backgroundColor = AppTheme.correctLight;
          borderColor = AppTheme.correctBorder;
          borderWidth = 2.0;
          letterBgColor = AppTheme.correctGreen;
          letterTextColor = Colors.white;
          trailingWidget = const Icon(
            Icons.check_circle_rounded,
            color: AppTheme.correctGreen,
            size: 24,
          );
        } else {
          // Selected and Wrong -> RED
          backgroundColor = AppTheme.wrongLight;
          borderColor = AppTheme.wrongBorder;
          borderWidth = 2.0;
          letterBgColor = AppTheme.wrongRed;
          letterTextColor = Colors.white;
          trailingWidget = const Icon(
            Icons.cancel_rounded,
            color: AppTheme.wrongRed,
            size: 24,
          );
        }
      } else if (isCorrect) {
        // Not selected by user, but is the correct answer -> Highlight GREEN outline
        backgroundColor = AppTheme.correctLight.withValues(alpha: 0.4);
        borderColor = AppTheme.correctBorder;
        borderWidth = 1.8;
        letterBgColor = AppTheme.correctLight;
        letterTextColor = AppTheme.correctGreen;
        trailingWidget = const Icon(
          Icons.check_circle_outline_rounded,
          color: AppTheme.correctGreen,
          size: 24,
        );
      } else {
        // Not selected and wrong -> Dimmed
        backgroundColor = Colors.white.withValues(alpha: 0.7);
        borderColor = AppTheme.borderLight.withValues(alpha: 0.7);
        letterBgColor = const Color(0xFFF1F5F9);
        letterTextColor = AppTheme.textLight;
      }
    } else {
      // Unanswered state (default interactive)
      trailingWidget = Container(
        width: 20,
        height: 20,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: AppTheme.borderLight, width: 1.5),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: AppTheme.radiusMedium,
          border: Border.all(color: borderColor, width: borderWidth),
          boxShadow: isSelected ? AppTheme.cardShadow : AppTheme.softShadow,
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: isAnswered ? null : onTap,
            borderRadius: AppTheme.radiusMedium,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
              child: Row(
                children: [
                  // Option Letter Badge (A, B, C, D)
                  Container(
                    width: 36,
                    height: 36,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: letterBgColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      optionLetter,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: letterTextColor,
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),

                  // Option text
                  Expanded(
                    child: Text(
                      optionText,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                        color: isAnswered && !isSelected && !isCorrect
                            ? AppTheme.textLight
                            : AppTheme.textDark,
                        height: 1.3,
                      ),
                    ),
                  ),

                  // Trailing feedback / selection indicator
                  if (trailingWidget != null) ...[
                    const SizedBox(width: 10),
                    trailingWidget,
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
