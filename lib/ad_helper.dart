import 'dart:io';

class AdHelper {
  // Return the official AdMob Test Banner Ad Unit ID based on Platform.
  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-3940256099942544/6300978111'; // Android Test ID
    } else if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/2934735716'; // iOS Test ID
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }

  // Return the official AdMob Test Interstitial Ad Unit ID based on Platform.
  static String get interstitialAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-3940256099942544/1033173712'; // Android Test ID
    } else if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/4411468910'; // iOS Test ID
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }
}
