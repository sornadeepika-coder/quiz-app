import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'quiz_screen.dart';

/// The entry screen welcoming the user, displaying key quiz details,
/// and providing an attractive "Start Quiz" button to begin.
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundLight,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 520),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 12),

                  // Hero Icon / Graphic
                  Center(
                    child: Container(
                      width: 110,
                      height: 110,
                      decoration: BoxDecoration(
                        color: AppTheme.primaryLight,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppTheme.primarySurface,
                          width: 3,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: AppTheme.primaryBlue.withValues(alpha: 0.15),
                            blurRadius: 24,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.psychology_rounded,
                          size: 60,
                          color: AppTheme.primaryBlue,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 28),

                  // App Title & Tagline
                  const Text(
                    'Quiz Master',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w800,
                      color: AppTheme.textDark,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Challenge your knowledge with our curated multiple-choice quiz and discover your score!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                      color: AppTheme.textLight,
                      height: 1.45,
                    ),
                  ),

                  const SizedBox(height: 32),

                  // Quiz Highlights Info Card
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: AppTheme.cardBackground,
                      borderRadius: AppTheme.radiusLarge,
                      boxShadow: AppTheme.cardShadow,
                      border: Border.all(color: AppTheme.borderLight),
                    ),
                    child: Column(
                      children: [
                        _buildFeatureRow(
                          icon: Icons.quiz_outlined,
                          title: '10 Questions',
                          subtitle: 'Hand-picked multiple-choice questions',
                        ),
                        const Divider(height: 24, color: AppTheme.borderLight),
                        _buildFeatureRow(
                          icon: Icons.check_circle_outline_rounded,
                          title: 'Instant Feedback',
                          subtitle: 'Live green & red answer indicators',
                        ),
                        const Divider(height: 24, color: AppTheme.borderLight),
                        _buildFeatureRow(
                          icon: Icons.insights_rounded,
                          title: 'Detailed Results',
                          subtitle: 'Complete breakdown of score & accuracy',
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 36),

                  // Start Quiz Button
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const QuizScreen(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primaryBlue,
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      shape: RoundedRectangleBorder(
                        borderRadius: AppTheme.radiusMedium,
                      ),
                      elevation: 4,
                      shadowColor: AppTheme.primaryBlue.withValues(alpha: 0.4),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Start Quiz',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.2,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(width: 8),
                        Icon(
                          Icons.arrow_forward_rounded,
                          color: Colors.white,
                          size: 22,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Bottom subtle note
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.timer_outlined,
                        size: 15,
                        color: AppTheme.textLight,
                      ),
                      SizedBox(width: 6),
                      Text(
                        'Take your time • One question at a time',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppTheme.textLight,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  static Widget _buildFeatureRow({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Row(
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: AppTheme.primaryLight,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: AppTheme.primaryBlue, size: 22),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: AppTheme.textDark,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 13,
                  color: AppTheme.textLight,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
