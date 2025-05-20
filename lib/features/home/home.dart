import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:zenith/common/assetsource/assetsource.dart';
import 'package:zenith/common/widgets/normal_text_widget.dart';
import 'package:zenith/common/widgets/tappable_container.dart';
import 'package:zenith/core/di/di.dart';
import 'package:zenith/core/navigation_service/navservice.dart';
import 'package:zenith/core/route/routes.dart';
import 'package:zenith/core/screen_padding.dart';
import 'package:zenith/core/transition/transition_config.dart';
import 'package:zenith/features/home/banner_ad.dart';

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
                child: TappableContainer(child: Text('Session'), onTap: () {}),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
