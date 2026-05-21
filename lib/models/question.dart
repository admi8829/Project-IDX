class Question {
  final String text;
  final List<String> options;
  final int correctAnswerIndex;
  final String explanation;

  const Question({
    required this.text,
    required this.options,
    required this.correctAnswerIndex,
    required this.explanation,
  });
}

class QuizCategory {
  final String id;
  final String name;
  final String description;
  final String iconName;
  final List<Question> questions;

  const QuizCategory({
    required this.id,
    required this.name,
    required this.description,
    required this.iconName,
    required this.questions,
  });
}

// Custom sample quiz data with fascinating and beautifully curated trivia of varying difficulty.
final List<QuizCategory> quizCategories = [
  const QuizCategory(
    id: 'flutter_tech',
    name: 'Flutter & Dart Mobile Dev',
    description: 'Test your understanding of widgets, state management, and Dart core principles!',
    iconName: 'flutter',
    questions: [
      Question(
        text: 'Which widget is typically used as a root-level layout to provide Material design basics (AppBar, FloatingActionButton, Drawer)?',
        options: ['Scaffold', 'Container', 'Card', 'SizedBox'],
        correctAnswerIndex: 0,
        explanation: 'Scaffold implements the basic Material Design visual layout structure, supporting app bars, snack bars, drawers, and persistent buttons.',
      ),
      Question(
        text: 'What keyword do you use to define a read-only variable whose value is determined only at compile-time?',
        options: ['final', 'const', 'var', 'static'],
        correctAnswerIndex: 1,
        explanation: 'The "const" keyword is used for variables whose values are fully known at compile-time, allowing the compiler to optimize rendering memory.',
      ),
      Question(
        text: 'What design pattern does Flutter use to update the user interface?',
        options: ['MVC', 'Imperative UI', 'Declarative UI', 'Direct Manipulation'],
        correctAnswerIndex: 2,
        explanation: 'Flutter is a declarative UI framework, meaning the UI reflects the current state of the application. To change the UI, you trigger a rebuild with new state.',
      ),
    ],
  ),
  const QuizCategory(
    id: 'space_science',
    name: 'Cosmic & Space Exploration',
    description: 'Venture deep into the cosmos. How much do you know about galaxies, stars, and planets?',
    iconName: 'space',
    questions: [
      Question(
        text: 'Which planet is known as the "Red Planet" due to the high presence of iron oxide on its surface?',
        options: ['Venus', 'Mars', 'Jupiter', 'Mercury'],
        correctAnswerIndex: 1,
        explanation: 'Mars features rust-colored iron oxide coatings on its surface rocks, giving it a distinct reddish glow in the night sky.',
      ),
      Question(
        text: 'What is the approximate speed of light in a vacuum?',
        options: [
          '150,000 km/s',
          '380,000 km/s',
          '299,792 km/s',
          '500,000 km/s'
        ],
        correctAnswerIndex: 2,
        explanation: 'Light travels at roughly 299,792 kilometers per second inside a vacuum. It takes about 8.3 minutes for sunlight to arrive at planet Earth.',
      ),
      Question(
        text: 'What stellar phenomenon marks the explosive, brilliant demise of an extremely massive star?',
        options: ['Supernova', 'Black Hole Creation', 'Solar Flare', 'Nebula Drift'],
        correctAnswerIndex: 0,
        explanation: 'A Supernova is a massive stellar explosion that ejects most of a star\'s mass with spectacular energy, temporarily outshining entire galaxies.',
      ),
    ],
  ),
  const QuizCategory(
    id: 'geography_nature',
    name: 'Geography & The Planet Earth',
    description: 'Discover the continents, deep oceans, beautiful summits, and cultures across our world.',
    iconName: 'globe',
    questions: [
      Question(
        text: 'Which river flows through northeastern Africa and is widely celebrated as the longest river in the world?',
        options: ['Amazon River', 'Nile River', 'Yangtze River', 'Mississippi River'],
        correctAnswerIndex: 1,
        explanation: 'The Nile River spans nearly 6,650 kilometers (4,130 miles), winding gracefully through eleven nations to meet the Mediterranean Sea.',
      ),
      Question(
        text: 'What country claims the iconic, breathtaking peak of Mount Kilimanjaro?',
        options: ['Kenya', 'Ethiopia', 'Tanzania', 'Uganda'],
        correctAnswerIndex: 2,
        explanation: 'Mount Kilimanjaro is a dormant volcano in Tanzania and marks the highest summit in Africa (5,895 meters above sea level).',
      ),
      Question(
        text: 'Which ocean occupies the expansive area situated between the Americas and Asia/Australia?',
        options: ['Atlantic Ocean', 'Indian Ocean', 'Pacific Ocean', 'Arctic Ocean'],
        correctAnswerIndex: 2,
        explanation: 'The Pacific Ocean is the largest and deepest of the world\'s ocean basins, covering more Earth surface than all continental landmasses combined.',
      ),
    ],
  ),
];
