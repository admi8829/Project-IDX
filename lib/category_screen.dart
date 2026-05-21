import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'models/question.dart';
import 'quiz_screen.dart';
import 'ad_helper.dart';

class CategoryScreen extends StatefulWidget {
  final String email;
  const CategoryScreen({super.key, required this.email});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  BannerAd? _bannerAd;
  bool _isBannerAdLoaded = false;
  int _userXP = 320;
  final int _streakDays = 5;

  @override
  void initState() {
    super.initState();
    _initBannerAd();
  }

  void _initBannerAd() {
    _bannerAd = BannerAd(
      adUnitId: AdHelper.bannerAdUnitId,
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          setState(() {
            _isBannerAdLoaded = true;
          });
        },
        onAdFailedToLoad: (ad, error) {
          debugPrint('AdMob Banner failed to load: ${error.message}');
          _isBannerAdLoaded = false;
          ad.dispose();
        },
      ),
    );
    _bannerAd!.load();
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }

  // Retrieve an elegant icon corresponding to the iconName
  IconData _getCategoryIcon(String iconName) {
    switch (iconName) {
      case 'flutter':
        return Icons.flutter_dash_rounded;
      case 'space':
        return Icons.rocket_launch_rounded;
      case 'globe':
        return Icons.public_rounded;
      default:
        return Icons.quiz_rounded;
    }
  }

  Color _getCategoryColor(String id) {
    switch (id) {
      case 'flutter_tech':
        return Colors.blue;
      case 'space_science':
        return Colors.deepPurple;
      case 'geography_nature':
        return Colors.teal;
      default:
        return Colors.blueAccent;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.blueAccent.withOpacity(0.1),
              child: Text(
                widget.email.isNotEmpty ? widget.email[0].toUpperCase() : 'U',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.email.split('@')[0],
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const Text(
                  'Explorer Level 4',
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          // Streak Counter
          Container(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.orange.shade50,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.orange.shade200, width: 1),
            ),
            child: Row(
              children: [
                const Icon(Icons.local_fire_department_rounded, color: Colors.orange, size: 18),
                const SizedBox(width: 4),
                Text(
                  '$_streakDays Days',
                  style: TextStyle(
                    color: Colors.orange.shade900,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          // XP Meter
          Container(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.blueAccent.withOpacity(0.08),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                const Icon(Icons.stars_rounded, color: Colors.blueAccent, size: 18),
                const SizedBox(width: 4),
                Text(
                  '$_userXP XP',
                  style: const TextStyle(
                    color: Colors.blueAccent,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Beautiful welcome card
          Container(
            width: double.infinity,
            margin: const EdgeInsets.all(20),
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blueAccent, Colors.blue.shade700],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.blueAccent.withOpacity(0.25),
                  blurRadius: 15,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Premium Quiz Universe',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    letterSpacing: -0.5,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Test your expertise to sharpen your brain. Earn up to +50 XP per category completion!',
                  style: TextStyle(
                    color: Colors.white87,
                    fontSize: 14,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
              itemCount: quizCategories.length,
              itemBuilder: (context, index) {
                final category = quizCategories[index];
                final catColor = _getCategoryColor(category.id);

                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.04),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Theme(
                      data: theme.copyWith(dividerColor: Colors.transparent),
                      child: ExpansionTile(
                        leading: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: catColor.withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            _getCategoryIcon(category.iconName),
                            color: catColor,
                            size: 26,
                          ),
                        ),
                        title: Text(
                          category.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.black87,
                          ),
                        ),
                        subtitle: Text(
                          '${category.questions.length} Items • Multi-choice',
                          style: const TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  category.description,
                                  style: TextStyle(
                                    color: Colors.grey.shade600,
                                    fontSize: 14,
                                    height: 1.4,
                                  ),
                                ),
                                const SizedBox(height: 20),
                                SizedBox(
                                  width: double.infinity,
                                  height: 48,
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      // Start the Quiz Activity
                                      final earnedXP = await Navigator.push<int>(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => QuizScreen(category: category),
                                        ),
                                      );
                                      if (earnedXP != null && earnedXP > 0) {
                                        setState(() {
                                          _userXP += earnedXP;
                                        });
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: catColor,
                                      foregroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      elevation: 0,
                                    ),
                                    child: const Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Start Training',
                                          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(width: 8),
                                        Icon(Icons.arrow_forward_rounded, size: 18),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // Google AdMob Banner Positioned elegantly at the footer
          if (_isBannerAdLoaded && _bannerAd != null)
            Container(
              width: _bannerAd!.size.width.toDouble(),
              height: _bannerAd!.size.height.toDouble(),
              alignment: Alignment.center,
              margin: const EdgeInsets.only(bottom: 12),
              child: AdWidget(ad: _bannerAd!),
            )
          else
            // High fidelity placeholder when ad hasn't loaded (simulated elegant spacer)
            _buildAdPlaceholder(),
        ],
      ),
    );
  }

  Widget _buildAdPlaceholder() {
    return Container(
      width: double.infinity,
      height: 60,
      margin: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200, width: 1),
      ),
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            width: 14,
            height: 14,
            child: CircularProgressIndicator(strokeWidth: 2, color: Colors.blueAccent),
          ),
          const SizedBox(width: 10),
          Text(
            'Google Ads loading securely...',
            style: TextStyle(fontSize: 12, color: Colors.grey.shade504),
          ),
        ],
      ),
    );
  }
}
