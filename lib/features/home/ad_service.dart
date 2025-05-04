import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdService {
  static final AdService _instance = AdService._internal();

  factory AdService() => _instance;

  AdService._internal();

  // Test Ad Unit IDs
  static const String _testBannerAdUnitIdAndroid =
      'ca-app-pub-3940256099942544/6300978111';
  static const String _testBannerAdUnitIdIOS =
      'ca-app-pub-3940256099942544/2934735716';

  // Production Ad Unit IDs - Replace with your actual IDs
  static const String _prodBannerAdUnitIdAndroid =
      'ca-app-pub-XXXXXXXXXXXXXXXX/YYYYYYYYYY';
  static const String _prodBannerAdUnitIdIOS =
      'ca-app-pub-XXXXXXXXXXXXXXXX/ZZZZZZZZZZ';

  // Flag to determine if we're in test mode
  final bool _testMode = !kReleaseMode;

  /// Initialize the Mobile Ads SDK
  Future<InitializationStatus> initialize() {
    return MobileAds.instance.initialize();
  }

  /// Get the appropriate banner ad unit ID based on platform and mode
  String get bannerAdUnitId {
    if (_testMode) {
      return Platform.isAndroid
          ? _testBannerAdUnitIdAndroid
          : _testBannerAdUnitIdIOS;
    } else {
      return Platform.isAndroid
          ? _prodBannerAdUnitIdAndroid
          : _prodBannerAdUnitIdIOS;
    }
  }

  /// Create a banner ad instance
  BannerAd createBannerAd({
    required Function(Ad) onAdLoaded,
    required Function(Ad, LoadAdError) onAdFailedToLoad,
  }) {
    return BannerAd(
      adUnitId: bannerAdUnitId,
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: onAdLoaded,
        onAdFailedToLoad: onAdFailedToLoad,
        onAdOpened: (ad) => debugPrint('Ad opened: ${ad.adUnitId}'),
        onAdClosed: (ad) => debugPrint('Ad closed: ${ad.adUnitId}'),
        onAdImpression: (ad) => debugPrint('Ad impression: ${ad.adUnitId}'),
      ),
    );
  }

  /// Add test devices (call this before loading ads)
  void addTestDevices(List<String> deviceIds) {
    if (_testMode) {
      MobileAds.instance.updateRequestConfiguration(
        RequestConfiguration(testDeviceIds: deviceIds),
      );
    }
  }
}
