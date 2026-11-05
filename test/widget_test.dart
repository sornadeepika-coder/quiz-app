import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quiz_app/main.dart';
import 'package:quiz_app/models/question.dart';
import 'package:quiz_app/screens/quiz_screen.dart';

void main() {
  testWidgets('Welcome screen renders properly with Start Quiz button',
      (WidgetTester tester) async {
    await tester.pumpWidget(const QuizApp());

    // Verify title and Start Quiz button are present
    expect(find.text('Quiz Master'), findsOneWidget);
    expect(find.text('Start Quiz'), findsOneWidget);
    expect(find.text('10 Questions'), findsOneWidget);
  });

  testWidgets('Start Quiz button navigates to QuizScreen with question 1',
      (WidgetTester tester) async {
    await tester.pumpWidget(const QuizApp());

    // Tap Start Quiz
    await tester.tap(find.text('Start Quiz'));
    await tester.pumpAndSettle();

    // Verify QuizScreen is displayed
    expect(find.text('QUESTION 1 OF 10'), findsOneWidget);
    expect(find.text('A'), findsOneWidget);
    expect(find.text('B'), findsOneWidget);
    expect(find.text('C'), findsOneWidget);
    expect(find.text('D'), findsOneWidget);
  });

  testWidgets('Option selection gives feedback and advances question',
      (WidgetTester tester) async {
    final testQuestions = [
      Question(
        questionText: 'Test Question 1?',
        options: ['Opt A', 'Opt B', 'Opt C', 'Opt D'],
        correctAnswerIndex: 0,
      ),
      Question(
        questionText: 'Test Question 2?',
        options: ['Opt 1', 'Opt 2', 'Opt 3', 'Opt 4'],
        correctAnswerIndex: 1,
      ),
    ];

    await tester.pumpWidget(
      MaterialApp(
        home: QuizScreen(customQuestions: testQuestions),
      ),
    );

    // Initial state: Question 1
    expect(find.text('QUESTION 1 OF 2'), findsOneWidget);
    expect(find.text('Test Question 1?'), findsOneWidget);

    // Tap correct option Opt A
    await tester.tap(find.text('Opt A'));
    await tester.pumpAndSettle();

    // Verify feedback is shown
    expect(find.text('Correct! Well done.'), findsOneWidget);
    expect(find.text('Score: 1'), findsOneWidget);

    // Tap Next Question
    await tester.tap(find.text('Next Question'));
    await tester.pumpAndSettle();

    // Question 2 is now shown
    expect(find.text('QUESTION 2 OF 2'), findsOneWidget);
    expect(find.text('Test Question 2?'), findsOneWidget);

    // Tap wrong option Opt 1 (correct is Opt 2 at index 1)
    await tester.tap(find.text('Opt 1'));
    await tester.pumpAndSettle();

    // Verify incorrect feedback is shown
    expect(find.textContaining('Incorrect. The correct answer is: Opt 2'), findsOneWidget);

    // Last question shows "View Results"
    expect(find.text('View Results'), findsOneWidget);
    await tester.tap(find.text('View Results'));
    await tester.pumpAndSettle();

    // Verify ResultScreen is reached
    expect(find.text('Quiz Results'), findsOneWidget);
    expect(find.text('50%'), findsOneWidget);
    expect(find.text('Restart Quiz'), findsOneWidget);
  });
}
