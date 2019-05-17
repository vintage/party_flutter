import 'dart:io' show Platform;

import 'package:firebase_admob/firebase_admob.dart';

class AdsService {
  static final String appId = Platform.isAndroid
      ? 'ca-app-pub-4764697513834958~1271811266'
      : 'ca-app-pub-4764697513834958~9794133262';

  static InterstitialAd interstitialAd;
  static final String interstitialId = Platform.isAndroid
      ? 'ca-app-pub-4764697513834958/4585204466'
      : 'ca-app-pub-4764697513834958/6701066069';

  static final String rewardId = Platform.isAndroid
      ? 'ca-app-pub-4764697513834958/8632433661'
      : 'ca-app-pub-4764697513834958/8353232062';

  static initialize() {
    FirebaseAdMob.instance.initialize(appId: appId);
  }

  static loadInterstitialAd() async {
    if (interstitialAd != null) {
      await interstitialAd.dispose();
    }

    interstitialAd = InterstitialAd(
      adUnitId: interstitialId,
    );
    await interstitialAd.load();
  }

  static showInterstitialAd() {
    interstitialAd.show();
  }

  static loadRewardAd() {
    RewardedVideoAd.instance.load(adUnitId: rewardId);
  }

  static showRewardAd() {
    RewardedVideoAd.instance.show();
  }
}
