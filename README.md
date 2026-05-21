# Premium Flutter Quiz & Trivia Application with Google AdMob

A gorgeous, highly-polished mobile application featuring a gamified Quiz Universe with Google AdMob test advertisement slots (Banner and Interstitial) pre-configured.

## ✨ Features
1. **Interactive Premium Login**: Clean fields, secure password visibility controls, and responsive validations.
2. **Category Dashboard**: Lists curated topics (Flutter/Dart SDK, Space Science, and Earth Geography) with beautiful custom cards, progress lines, and simulated lifetime XP trackers or streak systems.
3. **Immersive Trivia View**: Interactive option cards with instant feedback (Green/Red highlights), detailed dynamic explanations, and automated countdown timers.
4. **AdMob Banner Ads**: Positioned non-intrusively at the bottom of the Category Dashboard.
5. **AdMob Interstitial Ads**: Pre-cached on quiz load and shown on quiz completion before displaying scores.
6. **Detailed Results Metrics**: Dynamic medal rewards, accuracy calculation, and XP level tallies.

---

## 📂 Project Structure
- `lib/main.dart` - Bootstraps the app and initializes the Google Mobile Ads SDK.
- `lib/ad_helper.dart` - Safely returns AdMob Test Unit IDs for Platform-specific Banner and Interstitial placements.
- `lib/login_screen.dart` - Handles user registration, inputs, and routes to dashboard.
- `lib/category_screen.dart` - Displays gamification metrics and Banner Ad placements.
- `lib/quiz_screen.dart` - Focuses on trivia loops, timers, dynamic card transitions, and caching of Interstitial slots.
- `lib/quiz_results_screen.dart` - Displays visual score performance cards and XP awards.
- `lib/models/question.dart` - Handles the type definitions and contains beautifully written mock questions.
- `pubspec.yaml` - Lists project dependencies such as `google_mobile_ads`.

---

## 🚀 Getting Started with GitHub & Project IDX

### Step 1: Push code to GitHub
Use the **GitHub Sync** panel inside Google AI Studio to push this project to your repository.

### Step 2: Import into Project IDX
1. Go to **Google Project IDX** ([idx.google.com](https://idx.google.com)).
2. Create a new workspace by selecting **Import an existing repository** and choose your GitHub repository.

### Step 3: Run Setup Commands
In the Project IDX terminal or your local development machine, run the following:
```bash
# Refresh and download required package dependencies
flutter pub get
```

---

## 🛠️ Required Android/iOS AdMob Setup

For native Android and iOS simulators to launch without crashing, you **MUST** specify a Google AdMob App ID inside the native workspace configuration files. Here are the step-by-step instructions:

### For Android (`android/app/src/main/AndroidManifest.xml`)
If the `android/` directory is not yet generated, run `flutter create .` in your terminal to bootstrap native folders. Then add your AdMob metadata tag inside the `<application>` element:

```xml
<manifest>
    <application>
        <!-- Sample AdMob App ID (Safe for test ads) -->
        <meta-data
            android:name="com.google.android.gms.ads.APPLICATION_ID"
            android:value="ca-app-pub-3940256099942544~3347511713"/>
    </application>
</manifest>
```

### For iOS (`ios/Runner/Info.plist`)
Open the `ios/Runner/Info.plist` file, and add the configuration keys inside the `<dict>` element:

```xml
<key>GADApplicationIdentifier</key>
<string>ca-app-pub-3940256099942544~1458002511</string>
```

---

## ⚙️ How Google AdMob Test Ads Work
Inside `lib/ad_helper.dart`, we have configured Google's standard, safe test ad unit IDs.
- **Android Banner:** `ca-app-pub-3940256099942544/6300978111`
- **iOS Banner:** `ca-app-pub-3940256099942544/2934735716`
- **Android Interstitial:** `ca-app-pub-3940256099942544/1033173712`
- **iOS Interstitial:** `ca-app-pub-3940256099942544/4411468910`

When you switch to production in the future, simply update those string returns with your real unit IDs from your Google AdMob Dashboard.
