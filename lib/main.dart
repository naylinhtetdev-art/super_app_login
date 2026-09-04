import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:super_app/providers/chat_provider.dart';
import 'package:super_app/providers/feed_provider.dart';
import 'package:super_app/providers/profile_provider.dart';
import 'package:super_app/providers/search_provider.dart';
import 'package:super_app/providers/service_provider.dart';
import 'package:super_app/providers/story_provider.dart';
import 'package:super_app/providers/theme_provider.dart';
import 'package:super_app/providers/video_feed_provider.dart';
import 'package:super_app/utils/constants.dart';
import 'package:super_app/view/splash_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => FeedProvider()),
        ChangeNotifierProvider(create: (_) => VideoFeedProvider()),
        ChangeNotifierProvider(create: (_) => ServiceProvider()),
        ChangeNotifierProvider(create: (_) => ChatProvider()),
        ChangeNotifierProvider(create: (_) => ProfileProvider()),
        ChangeNotifierProvider(create: (_) => StoryProvider()),
        ChangeNotifierProvider(create: (_) => SearchProvider()),
      ],
      child: const MyApp(),
    ),
  );
  //runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      if (!mounted) return;
      context.read<ThemeProvider>().loadThemeMode();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, _) {
        return ScreenUtilInit(
          designSize: const Size(375, 812),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, child) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              themeMode: themeProvider.themeMode,
              theme: ThemeData(
                brightness: Brightness.light,
                scaffoldBackgroundColor: AppColors.lightBackground,
                cardColor: AppColors.lightSurface,
                appBarTheme: const AppBarTheme(
                  backgroundColor: AppColors.lightBackground,
                  iconTheme: IconThemeData(color: AppColors.lightTextPrimary),
                  titleTextStyle: TextStyle(
                    color: AppColors.primary,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                colorScheme: const ColorScheme.light(
                  primary: AppColors.primary,
                  surface: AppColors.lightSurface,
                  onSurface: AppColors.lightTextPrimary,
                ),
              ),
              darkTheme: ThemeData(
                brightness: Brightness.dark,
                scaffoldBackgroundColor: AppColors.darkBackground,
                cardColor: AppColors.darkSurface,
                appBarTheme: const AppBarTheme(
                  backgroundColor: AppColors.darkBackground,
                  iconTheme: IconThemeData(color: AppColors.darkTextPrimary),
                  titleTextStyle: TextStyle(
                    color: AppColors.primary,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                colorScheme: const ColorScheme.dark(
                  primary: AppColors.primary,
                  surface: AppColors.darkSurface,
                  onSurface: AppColors.darkTextPrimary,
                ),
              ),
              home: const SplashScreen(),
            );
          },
        );
      },
    );
  }
}
