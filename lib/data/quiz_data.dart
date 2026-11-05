import '../models/question.dart';

/// Predefined list of 10 multiple-choice questions for the quiz.
final List<Question> sampleQuizQuestions = [
  Question(
    questionText: 'What is the primary programming language used to develop Flutter apps?',
    options: ['Java', 'Swift', 'Dart', 'Kotlin'],
    correctAnswerIndex: 2,
    explanation: 'Flutter was built by Google and uses Dart as its primary language.',
  ),
  Question(
    questionText: 'Which planet in our solar system is known as the "Red Planet"?',
    options: ['Venus', 'Mars', 'Jupiter', 'Saturn'],
    correctAnswerIndex: 1,
    explanation: 'Mars appears reddish because of the iron oxide (rust) on its surface.',
  ),
  Question(
    questionText: 'What does "CPU" stand for in computer systems?',
    options: [
      'Central Processing Unit',
      'Computer Personal Unit',
      'Central Performance Utility',
      'Core Processor Union',
    ],
    correctAnswerIndex: 0,
    explanation: 'The Central Processing Unit is often referred to as the brain of the computer.',
  ),
  Question(
    questionText: 'Which ocean is the largest and deepest on Earth?',
    options: ['Atlantic Ocean', 'Indian Ocean', 'Arctic Ocean', 'Pacific Ocean'],
    correctAnswerIndex: 3,
    explanation: 'The Pacific Ocean covers over 60 million square miles and contains the Mariana Trench.',
  ),
  Question(
    questionText: 'In Flutter, which widget is best used for an infinitely scrollable list?',
    options: ['Column', 'ListView.builder', 'SingleChildScrollView', 'Stack'],
    correctAnswerIndex: 1,
    explanation: 'ListView.builder lazily builds its children as they scroll into view, optimizing memory.',
  ),
  Question(
    questionText: 'What is the chemical symbol for the element Gold?',
    options: ['Ag', 'Au', 'Fe', 'Pb'],
    correctAnswerIndex: 1,
    explanation: 'Au comes from "aurum", the Latin word for gold.',
  ),
  Question(
    questionText: 'Which tech company originally created and open-sourced Flutter?',
    options: ['Meta', 'Microsoft', 'Google', 'Apple'],
    correctAnswerIndex: 2,
    explanation: 'Google announced Flutter in 2015 and released Flutter 1.0 in December 2018.',
  ),
  Question(
    questionText: 'How many continents are officially recognized on Earth?',
    options: ['5', '6', '7', '8'],
    correctAnswerIndex: 2,
    explanation: 'The seven continents are Asia, Africa, North America, South America, Antarctica, Europe, and Australia.',
  ),
  Question(
    questionText: 'What type of Flutter widget should be used when the user interface needs to update dynamically?',
    options: ['StatelessWidget', 'InheritedModel', 'StatefulWidget', 'ConstrainedBox'],
    correctAnswerIndex: 2,
    explanation: 'StatefulWidget maintains a mutable State object that calls setState() to trigger UI rebuilds.',
  ),
  Question(
    questionText: 'Approximately what is the speed of light in a vacuum?',
    options: ['150,000 km/s', '300,000 km/s', '450,000 km/s', '600,000 km/s'],
    correctAnswerIndex: 1,
    explanation: 'The speed of light in a vacuum is approximately 299,792 kilometers per second (about 300,000 km/s).',
  ),
];
