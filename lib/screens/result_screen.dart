import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'quiz_screen.dart';
import 'welcome_screen.dart';

/// Attractive results screen presenting the player's final score, percentage,
/// breakdown of correct vs wrong answers, and options to restart or go home.
class ResultScreen extends StatelessWidget {
  final int totalQuestions;
  final int correctAnswers;

  const ResultScreen({
    super.key,
    required this.totalQuestions,
    required this.correctAnswers,
  });

  int get wrongAnswers => totalQuestions - correctAnswers;

  double get percentage =>
      totalQuestions > 0 ? (correctAnswers / totalQuestions) * 100 : 0.0;

  String get performanceTitle {
    if (percentage >= 90) return 'Outstanding! 🏆';
    if (percentage >= 70) return 'Great Job! 🌟';
    if (percentage >= 50) return 'Good Effort! 👍';
    return 'Keep Practicing! 📚';
  }

  String get performanceMessage {
    if (percentage >= 90) {
      return 'Exceptional performance! You have mastered these questions.';
    }
    if (percentage >= 70) {
      return 'Very impressive! You clearly know your facts well.';
    }
    if (percentage >= 50) {
      return 'Nice attempt! A quick review will get you to the top tier.';
    }
    return 'Don\'t give up! Retake the quiz to sharpen your skills.';
  }

  Color get scoreColor {
    if (percentage >= 70) return AppTheme.correctGreen;
    if (percentage >= 50) return const Color(0xFFD97706); // Amber
    return AppTheme.wrongRed;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundLight,
      appBar: AppBar(
        title: const Text('Quiz Results'),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 520),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Main Score Summary Card
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24.0,
                      vertical: 28.0,
                    ),
                    decoration: BoxDecoration(
                      color: AppTheme.cardBackground,
                      borderRadius: AppTheme.radiusLarge,
                      boxShadow: AppTheme.cardShadow,
                      border: Border.all(color: AppTheme.borderLight),
                    ),
                    child: Column(
                      children: [
                        // Circular badge with score percentage
                        Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppTheme.primaryLight,
                            border: Border.all(
                              color: scoreColor.withValues(alpha: 0.3),
                              width: 4,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: scoreColor.withValues(alpha: 0.15),
                                blurRadius: 20,
                                offset: const Offset(0, 8),
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '${percentage.toStringAsFixed(0)}%',
                                style: TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.w900,
                                  color: scoreColor,
                                  letterSpacing: -1,
                                ),
                              ),
                              const Text(
                                'SCORE',
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w800,
                                  color: AppTheme.textLight,
                                  letterSpacing: 1.0,
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 20),

                        // Performance Feedback Text
                        Text(
                          performanceTitle,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                            color: AppTheme.textDark,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          performanceMessage,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 14,
                            color: AppTheme.textLight,
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Key Stats 2x2 Grid
                  Row(
                    children: [
                      Expanded(
                        child: _buildStatCard(
                          icon: Icons.help_outline_rounded,
                          iconColor: AppTheme.primaryBlue,
                          iconBgColor: AppTheme.primaryLight,
                          label: 'Total Questions',
                          value: '$totalQuestions',
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: _buildStatCard(
                          icon: Icons.check_circle_outline_rounded,
                          iconColor: AppTheme.correctGreen,
                          iconBgColor: AppTheme.correctLight,
                          label: 'Correct Answers',
                          value: '$correctAnswers',
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 14),

                  Row(
                    children: [
                      Expanded(
                        child: _buildStatCard(
                          icon: Icons.highlight_off_rounded,
                          iconColor: AppTheme.wrongRed,
                          iconBgColor: AppTheme.wrongLight,
                          label: 'Wrong Answers',
                          value: '$wrongAnswers',
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: _buildStatCard(
                          icon: Icons.percent_rounded,
                          iconColor: const Color(0xFF7C3AED),
                          iconBgColor: const Color(0xFFF3E8FF),
                          label: 'Accuracy',
                          value: '${percentage.toStringAsFixed(1)}%',
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 28),

                  // Restart Quiz Button
                  ElevatedButton(
                    onPressed: () {
                      // Replace current route with a fresh QuizScreen
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => const QuizScreen(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primaryBlue,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: AppTheme.radiusMedium,
                      ),
                      elevation: 3,
                      shadowColor: AppTheme.primaryBlue.withValues(alpha: 0.35),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.replay_rounded,
                          color: Colors.white,
                          size: 20,
                        ),
                        SizedBox(width: 8),
                        Text(
                          'Restart Quiz',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Back to Home Button
                  OutlinedButton(
                    onPressed: () {
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (context) => const WelcomeScreen(),
                        ),
                        (route) => false,
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      side: const BorderSide(color: AppTheme.borderLight, width: 1.5),
                      shape: RoundedRectangleBorder(
                        borderRadius: AppTheme.radiusMedium,
                      ),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.home_outlined,
                          size: 20,
                          color: AppTheme.textMedium,
                        ),
                        SizedBox(width: 8),
                        Text(
                          'Back to Home',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: AppTheme.textMedium,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required Color iconColor,
    required Color iconBgColor,
    required String label,
    required String value,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: AppTheme.cardBackground,
        borderRadius: AppTheme.radiusMedium,
        boxShadow: AppTheme.softShadow,
        border: Border.all(color: AppTheme.borderLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: iconBgColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: iconColor, size: 20),
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: AppTheme.textDark,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: AppTheme.textLight,
            ),
          ),
        ],
      ),
    );
  }
}
