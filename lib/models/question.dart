/// Model class representing a single multiple-choice quiz question.
class Question {
  /// The question prompt text.
  final String questionText;

  /// The four answer choices for the question.
  final List<String> options;

  /// The zero-based index of the correct option in [options].
  final int correctAnswerIndex;

  /// Optional brief explanation providing educational context after answering.
  final String? explanation;

  Question({
    required this.questionText,
    required this.options,
    required this.correctAnswerIndex,
    this.explanation,
  })  : assert(
          options.length == 4,
          'Each question must have exactly 4 answer options.',
        ),
        assert(
          correctAnswerIndex >= 0 && correctAnswerIndex < 4,
          'correctAnswerIndex must be between 0 and 3.',
        );

  /// Helper to get the correct option text.
  String get correctAnswer => options[correctAnswerIndex];
}
