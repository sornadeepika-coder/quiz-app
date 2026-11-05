import 'package:flutter/material.dart';
import '../data/quiz_data.dart';
import '../models/question.dart';
import '../theme/app_theme.dart';
import '../widgets/option_card.dart';
import '../widgets/quiz_progress_bar.dart';
import 'result_screen.dart';

/// The active quiz screen displaying one question at a time, interactive
/// 4-option cards with immediate green/red feedback, answer locking,
/// progress tracking, and next question progression.
class QuizScreen extends StatefulWidget {
  final List<Question>? customQuestions;

  const QuizScreen({super.key, this.customQuestions});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  late final List<Question> _questions;
  int _currentIndex = 0;
  int? _selectedOptionIndex;
  bool _isAnswerLocked = false;
  int _score = 0;

  @override
  void initState() {
    super.initState();
    _questions = widget.customQuestions ?? sampleQuizQuestions;
  }

  Question get _currentQuestion => _questions[_currentIndex];
  bool get _isLastQuestion => _currentIndex == _questions.length - 1;

  void _handleOptionSelected(int optionIndex) {
    if (_isAnswerLocked) return;

    setState(() {
      _selectedOptionIndex = optionIndex;
      _isAnswerLocked = true;

      // Increment score if selected option is the correct one
      if (optionIndex == _currentQuestion.correctAnswerIndex) {
        _score++;
      }
    });
  }

  void _goToNextQuestion() {
    if (!_isAnswerLocked) return;

    if (_isLastQuestion) {
      // Navigate to Results Screen
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => ResultScreen(
            totalQuestions: _questions.length,
            correctAnswers: _score,
          ),
        ),
      );
    } else {
      // Advance to next question and reset state
      setState(() {
        _currentIndex++;
        _selectedOptionIndex = null;
        _isAnswerLocked = false;
      });
    }
  }

  Future<bool> _onWillPop() async {
    final shouldLeave = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppTheme.cardBackground,
        shape: RoundedRectangleBorder(borderRadius: AppTheme.radiusMedium),
        title: const Text(
          'Leave Quiz?',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        content: const Text(
          'Are you sure you want to exit? Your current progress and score will be lost.',
          style: TextStyle(color: AppTheme.textMedium),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Continue Quiz'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.wrongRed,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            ),
            child: const Text('Exit'),
          ),
        ],
      ),
    );

    return shouldLeave ?? false;
  }

  @override
  Widget build(BuildContext context) {
    final question = _currentQuestion;
    final isSelectedCorrect = _selectedOptionIndex != null &&
        _selectedOptionIndex == question.correctAnswerIndex;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;
        final shouldLeave = await _onWillPop();
        if (shouldLeave && context.mounted) {
          Navigator.of(context).pop();
        }
      },
      child: Scaffold(
        backgroundColor: AppTheme.backgroundLight,
        appBar: AppBar(
          title: const Text('Quiz Challenge'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
            tooltip: 'Back',
            onPressed: () async {
              final shouldLeave = await _onWillPop();
              if (shouldLeave && context.mounted) {
                Navigator.of(context).pop();
              }
            },
          ),
        ),
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 580),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Top Progress Bar
                    QuizProgressBar(
                      currentIndex: _currentIndex,
                      totalQuestions: _questions.length,
                      currentScore: _score,
                    ),

                    const SizedBox(height: 18),

                    // Question Card
                    Container(
                      padding: const EdgeInsets.all(22.0),
                      decoration: BoxDecoration(
                        color: AppTheme.cardBackground,
                        borderRadius: AppTheme.radiusLarge,
                        boxShadow: AppTheme.cardShadow,
                        border: Border.all(color: AppTheme.borderLight),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 28,
                                height: 28,
                                decoration: BoxDecoration(
                                  color: AppTheme.primaryLight,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Icon(
                                  Icons.help_rounded,
                                  size: 16,
                                  color: AppTheme.primaryBlue,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Question ${_currentIndex + 1}',
                                style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                  color: AppTheme.primaryBlue,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Text(
                            question.questionText,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: AppTheme.textDark,
                              height: 1.35,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Instruction / Prompt text
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: Text(
                        _isAnswerLocked
                            ? 'Answer submitted. Tap below to proceed.'
                            : 'Select one of the 4 options below:',
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: AppTheme.textLight,
                        ),
                      ),
                    ),

                    const SizedBox(height: 8),

                    // 4 Answer Option Cards
                    ...List.generate(question.options.length, (index) {
                      return OptionCard(
                        optionIndex: index,
                        optionText: question.options[index],
                        isAnswered: _isAnswerLocked,
                        isSelected: _selectedOptionIndex == index,
                        isCorrect: index == question.correctAnswerIndex,
                        onTap: () => _handleOptionSelected(index),
                      );
                    }),

                    // Answer Feedback & Explanation Banner
                    if (_isAnswerLocked) ...[
                      const SizedBox(height: 12),
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        padding: const EdgeInsets.all(14.0),
                        decoration: BoxDecoration(
                          color: isSelectedCorrect
                              ? AppTheme.correctLight
                              : AppTheme.wrongLight,
                          borderRadius: AppTheme.radiusMedium,
                          border: Border.all(
                            color: isSelectedCorrect
                                ? AppTheme.correctBorder
                                : AppTheme.wrongBorder,
                            width: 1.2,
                          ),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              isSelectedCorrect
                                  ? Icons.check_circle_rounded
                                  : Icons.cancel_rounded,
                              color: isSelectedCorrect
                                  ? AppTheme.correctGreen
                                  : AppTheme.wrongRed,
                              size: 22,
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    isSelectedCorrect
                                        ? 'Correct! Well done.'
                                        : 'Incorrect. The correct answer is: ${question.correctAnswer}',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      color: isSelectedCorrect
                                          ? AppTheme.correctGreen
                                          : AppTheme.wrongRed,
                                    ),
                                  ),
                                  if (question.explanation != null) ...[
                                    const SizedBox(height: 4),
                                    Text(
                                      question.explanation!,
                                      style: TextStyle(
                                        fontSize: 12.5,
                                        color: isSelectedCorrect
                                            ? const Color(0xFF166534)
                                            : const Color(0xFF991B1B),
                                        height: 1.3,
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],

                    const SizedBox(height: 24),

                    // Next / View Results Button
                    ElevatedButton(
                      onPressed: _isAnswerLocked ? _goToNextQuestion : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.primaryBlue,
                        disabledBackgroundColor: AppTheme.borderLight,
                        disabledForegroundColor: AppTheme.textLight,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: AppTheme.radiusMedium,
                        ),
                        elevation: _isAnswerLocked ? 3 : 0,
                        shadowColor: AppTheme.primaryBlue.withValues(alpha: 0.35),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            _isLastQuestion
                                ? 'View Results'
                                : 'Next Question',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: _isAnswerLocked
                                  ? Colors.white
                                  : AppTheme.textLight,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Icon(
                            _isLastQuestion
                                ? Icons.emoji_events_rounded
                                : Icons.arrow_forward_rounded,
                            size: 20,
                            color: _isAnswerLocked
                                ? Colors.white
                                : AppTheme.textLight,
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
      ),
    );
  }
}
