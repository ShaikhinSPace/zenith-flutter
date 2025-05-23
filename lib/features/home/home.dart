import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:path/path.dart';
import 'package:zenith/common/assetsource/assetsource.dart';
import 'package:zenith/common/widgets/normal_text_widget.dart';
import 'package:zenith/common/widgets/tappable_container.dart';
import 'package:zenith/core/di/di.dart';
import 'package:zenith/core/navigation_service/navservice.dart';
import 'package:zenith/core/route/routes.dart';
import 'package:zenith/core/screen_padding.dart';
import 'package:zenith/core/transition/transition_config.dart';
import 'package:zenith/features/home/banner_ad.dart';
import 'package:zenith/features/summary/auto_carousel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // appBar:
        body: ScreenPadding(
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: AppBar(
                  title: const Headline2Text(text: 'Zenith'),
                  actions: [
                    InkWell(
                      onTapDown: (dx) {
                        getIt<NavigationService>().goTo(
                          Routes.settings,
                          arguments: TransitionConfig(
                            tapPosition: dx.globalPosition,
                            transitionType: TransitionType.circularReveal,
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SvgPicture.asset(AssetSource.chatNavBarIcon),
                      ),
                    ),
                  ],
                ),
              ),
              SliverToBoxAdapter(
                child: AutomaticCarousel(
                  items: [
                    Card(
                      child: Padding(
                        padding: EdgeInsets.all(8.sp),
                        child: Column(
                          children: [
                            Row(children: [NormalTextWidget(text: 'Timer')]),
                          ],
                        ),
                      ),
                    ),
                    // _buildCarouselItem(Colors.green, 'Slide 2', Icons.favorite),
                    // _buildCarouselItem(Colors.blue, 'Slide 3', Icons.thumb_up),
                    // _buildCarouselItem(
                    //   Colors.orange,
                    //   'Slide 4',
                    //   Icons.lightbulb,
                    // ),
                  ],
                  autoScrollDuration: const Duration(seconds: 3),
                  autoScrollEnabled: true,
                  height: 180,
                  onPageChanged: (index) {
                    print('Page changed to: $index');
                  },
                ),
              ),
              SliverList.builder(
                itemBuilder: (context, idx) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TappableContainer(
                      child: Center(child: Text('Session ${idx + 1}')),
                      onTap: () {
                        getIt<NavigationService>().goTo(Routes.sessionScreen);
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCarouselItem(Color color, String title, IconData icon) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [color, color.withOpacity(0.7)],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 48, color: Colors.white),
          const SizedBox(height: 12),
          Text(
            title,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
