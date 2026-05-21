import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'models/question.dart';
import 'quiz_results_screen.dart';
import 'ad_helper.dart';

class QuizScreen extends StatefulWidget {
  final QuizCategory category;
  const QuizScreen({super.key, required this.category});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  InterstitialAd? _interstitialAd;
  bool _isInterstitialLoaded = false;

  int _currentQuestionIndex = 0;
  int? _selectedAnswerIndex;
  bool _hasAnswered = false;
  int _score = 0;

  // Question countdown Timer mechanics
  Timer? _countdownTimer;
  int _secondsRemaining = 15;

  @override
  void initState() {
    super.initState();
    _startTimer();
    _loadInterstitialAd();
  }

  void _startTimer() {
    _secondsRemaining = 15;
    _countdownTimer?.cancel();
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) return;
      setState(() {
        if (_secondsRemaining > 0) {
          _secondsRemaining--;
        } else {
          // Time expired! Automatically flag question as false
          _countdownTimer?.cancel();
          _revealAnswer(null);
        }
      });
    });
  }

  void _loadInterstitialAd() {
    InterstitialAd.load(
      adUnitId: AdHelper.interstitialAdUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          _interstitialAd = ad;
          _isInterstitialLoaded = true;

          // Configure callbacks to execute state transitions once the interstitial ad concludes
          _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              ad.dispose();
              _transitionToResults();
            },
            onAdFailedToShowFullScreenContent: (ad, error) {
              debugPrint('Interstitial failed to show: ${error.message}');
              ad.dispose();
              _transitionToResults(); // Safe recovery fallback
            },
          );
        },
        onAdFailedToLoad: (error) {
          debugPrint('InterstitialAd failed to load: ${error.message}');
          _isInterstitialLoaded = false;
        },
      ),
    );
  }

  void _revealAnswer(int? index) {
    if (_hasAnswered) return;
    _countdownTimer?.cancel();

    setState(() {
      _selectedAnswerIndex = index;
      _hasAnswered = true;

      final currentQuestion = widget.category.questions[_currentQuestionIndex];
      if (index == currentQuestion.correctAnswerIndex) {
        _score++;
      }
    });
  }

  void _handleNext() {
    if (_currentQuestionIndex < widget.category.questions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
        _selectedAnswerIndex = null;
        _hasAnswered = false;
      });
      _startTimer();
    } else {
      // Finished all quiz items! Launch AdMob Interstitial or transition directly if still loading.
      if (_isInterstitialLoaded && _interstitialAd != null) {
        _interstitialAd!.show();
      } else {
        _transitionToResults();
      }
    }
  }

  void _transitionToResults() {
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => QuizResultsScreen(
          score: _score,
          totalQuestions: widget.category.questions.length,
          categoryName: widget.category.name,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _countdownTimer?.cancel();
    _interstitialAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion = widget.category.questions[_currentQuestionIndex];
    final progressFraction = (_currentQuestionIndex + 1) / widget.category.questions.length;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.close_rounded, color: Colors.black87),
          onPressed: () {
            // Confirm cancel
            showDialog(
              context: context,
              builder: (ctx) => AlertDialog(
                title: const Text('Quit Training?'),
                content: const Text('Are you sure you want to stop this training? All current answers will be lost.'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(ctx),
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(ctx);
                      Navigator.pop(context);
                    },
                    style: TextButton.styleFrom(foregroundColor: Colors.red),
                    child: const Text('Quit'),
                  ),
                ],
              ),
            );
          },
        ),
        title: LinearProgressIndicator(
          value: progressFraction,
          backgroundColor: Colors.grey.shade100,
          color: Colors.blueAccent,
          minHeight: 12,
          borderRadius: BorderRadius.circular(8),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: CircleAvatar(
              backgroundColor: _secondsRemaining > 5 ? Colors.blue.shade50 : Colors.red.shade50,
              radius: 20,
              child: Text(
                '$_secondsRemaining',
                style: TextStyle(
                  color: _secondsRemaining > 5 ? Colors.blue : Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Question ${_currentQuestionIndex + 1} of ${widget.category.questions.length}',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                currentQuestion.text,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 32),
              Expanded(
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: currentQuestion.options.length,
                  itemBuilder: (context, index) {
                    final optionText = currentQuestion.options[index];

                    // Visual configurations of selected states
                    Color cardBorderColor = Colors.grey.shade200;
                    Color cardBgColor = Colors.white;
                    IconData? feedbackIcon;
                    Color feedbackIconColor = Colors.transparent;

                    if (_hasAnswered) {
                      if (index == currentQuestion.correctAnswerIndex) {
                        // The correct option gets styled green
                        cardBorderColor = Colors.green.shade400;
                        cardBgColor = Colors.green.shade50;
                        feedbackIcon = Icons.check_circle_rounded;
                        feedbackIconColor = Colors.green;
                      } else if (index == _selectedAnswerIndex) {
                        // The user answered incorrectly
                        cardBorderColor = Colors.red.shade400;
                        cardBgColor = Colors.red.shade50;
                        feedbackIcon = Icons.cancel_rounded;
                        feedbackIconColor = Colors.red;
                      }
                    } else {
                      // Standard clean borders at load-time
                      cardBorderColor = Colors.grey.shade200;
                    }

                    return Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      child: InkWell(
                        onTap: () => _revealAnswer(index),
                        borderRadius: BorderRadius.circular(16),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 250),
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: cardBgColor,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: cardBorderColor, width: 2),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  optionText,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: _hasAnswered && index == currentQuestion.correctAnswerIndex
                                        ? Colors.green.shade900
                                        : Colors.black87,
                                  ),
                                ),
                              ),
                              if (feedbackIcon != null)
                                Icon(feedbackIcon, color: feedbackIconColor),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              // Detailed Answer Explanation Widget
              if (_hasAnswered)
                Container(
                  padding: const EdgeInsets.all(16),
                  margin: const EdgeInsets.only(bottom: 24),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.blue.shade100, width: 1),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Icon(Icons.info_outline, color: Colors.blue, size: 18),
                          SizedBox(width: 8),
                          Text(
                            'Explanation',
                            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        currentQuestion.explanation,
                        style: TextStyle(fontSize: 13, color: Colors.blue.shade900, height: 1.4),
                      ),
                    ],
                  ),
                ),

              // Flow CTA Buttons
              if (_hasAnswered)
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: _handleNext,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          _currentQuestionIndex < widget.category.questions.length - 1 ? 'Next Question' : 'Finish Quiz',
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(width: 8),
                        const Icon(Icons.arrow_forward_rounded, size: 20),
                      ],
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
