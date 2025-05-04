import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:zenith/common/extensions/theme_extension.dart';
import 'package:zenith/core/bloc_provider/global_bloc_provider.dart';
import 'package:zenith/core/di/di.dart';
import 'package:zenith/core/route/go_route_config.dart';
import 'package:zenith/core/theme/dark_theme.dart';
import 'package:zenith/core/theme/light_theme.dart';
import 'package:zenith/features/home/ad_service.dart';
import 'package:zenith/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  final routeconfig = GoRouterConfig();
  await routeconfig.init();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  configureDependencies();
  final adService = AdService();
  await adService.initialize();
  // await dotenv.load(fileName: ".env");
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(
        MediaQuery.of(context).size.width,
        MediaQuery.of(context).size.height,
      ),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiBlocProvider(
          providers: GlobalBlocProvider().globalBlocProvider,
          child: MaterialApp.router(
            builder: FToastBuilder(),
            theme: context.isDark ? darkTheme : lightTheme,
            routerConfig: GoRouterConfig().routes,
            debugShowCheckedModeBanner: false,
          ),
        );
      },
    );
  }
}
