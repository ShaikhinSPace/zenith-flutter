import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'ad_service.dart';

class BannerAdWidget extends StatefulWidget {
  const BannerAdWidget({super.key});

  @override
  State<BannerAdWidget> createState() => _BannerAdWidgetState();
}

class _BannerAdWidgetState extends State<BannerAdWidget> {
  BannerAd? _bannerAd;
  bool _isLoaded = false;
  int _loadAttempts = 0;
  final int _maxAttempts = 3;

  final AdService _adService = AdService();

  @override
  void initState() {
    super.initState();
    _loadAd();
  }

  void _loadAd() {
    if (_loadAttempts >= _maxAttempts) {
      debugPrint('Max ad load attempts reached. Giving up.');
      return;
    }

    _bannerAd = _adService.createBannerAd(
      onAdLoaded: (Ad ad) {
        debugPrint('Banner ad loaded successfully!');
        setState(() {
          _isLoaded = true;
          _loadAttempts = 0; // Reset counter on success
        });
      },
      onAdFailedToLoad: (Ad ad, LoadAdError error) {
        ad.dispose();
        _bannerAd = null;

        _loadAttempts++;
        debugPrint(
          'Banner ad failed to load (attempt $_loadAttempts): ${error.message}',
        );

        // Retry with backoff
        if (_loadAttempts < _maxAttempts) {
          Future.delayed(Duration(seconds: _loadAttempts * 5), () {
            if (mounted) {
              _loadAd();
            }
          });
        }
      },
    );

    _bannerAd?.load();
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoaded && _bannerAd != null) {
      return Container(
        width: _bannerAd!.size.width.toDouble(),
        height: _bannerAd!.size.height.toDouble(),
        alignment: Alignment.center,
        child: AdWidget(ad: _bannerAd!),
      );
    } else {
      // Optional placeholder or loading indicator
      return SizedBox(
        height: 50,
        child: Center(
          child:
              _loadAttempts >= _maxAttempts
                  ? const Text(
                    'Ad unavailable',
                    style: TextStyle(color: Colors.grey),
                  )
                  : const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
        ),
      );
    }
  }
}
