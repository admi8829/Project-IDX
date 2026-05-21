import 'package:flutter/material.dart';

class QuizResultsScreen extends StatelessWidget {
  final int score;
  final int totalQuestions;
  final String categoryName;

  const QuizResultsScreen({
    super.key,
    required this.score,
    required this.totalQuestions,
    required this.categoryName,
  });

  @override
  Widget build(BuildContext context) {
    final double percentage = (score / totalQuestions) * 100;
    final int xpEarned = score * 10; // +10 XP earned per correct answer

    // Determine medal / layout depending on performance
    String performanceTitle;
    IconData performanceIcon;
    Color performanceColor;

    if (percentage >= 80) {
      performanceTitle = 'Grandmaster!';
      performanceIcon = Icons.military_tech_rounded;
      performanceColor = Colors.amber;
    } else if (percentage >= 50) {
      performanceTitle = 'Well Done!';
      performanceIcon = Icons.emoji_events_rounded;
      performanceColor = Colors.blueAccent;
    } else {
      performanceTitle = 'Keep Practicing!';
      performanceIcon = Icons.psychology_rounded;
      performanceColor = Colors.grey;
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              // Animated Circular score or Medal
              Container(
                padding: const EdgeInsets.all(28),
                decoration: BoxDecoration(
                  color: performanceColor.withOpacity(0.12),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  performanceIcon,
                  size: 100,
                  color: performanceColor,
                ),
              ),
              const SizedBox(height: 32),
              Text(
                performanceTitle,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                categoryName,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 40),

              // Score Metrics Panel
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: Colors.grey.shade100, width: 2),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        const Text('SCORE', style: TextStyle(fontSize: 12, color: Colors.grey, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 6),
                        Text(
                          '$score / $totalQuestions',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: performanceColor,
                          ),
                        ),
                      ],
                    ),
                    Container(height: 30, width: 1, color: Colors.grey.shade300),
                    Column(
                      children: [
                        const Text('ACCURACY', style: TextStyle(fontSize: 12, color: Colors.grey, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 6),
                        Text(
                          '${percentage.toStringAsFixed(0)}%',
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                    Container(height: 30, width: 1, color: Colors.grey.shade300),
                    Column(
                      children: [
                        const Text('XP GAINED', style: TextStyle(fontSize: 12, color: Colors.grey, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 6),
                        Text(
                          '+$xpEarned XP',
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const Spacer(),

              // Claim XP and finish button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
                    // Send back the aggregate XP earned to reflect in CategoryScreen's local state
                    Navigator.pop(context, xpEarned);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Claim Rewards & Continue',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
