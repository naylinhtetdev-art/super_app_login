import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:super_app/providers/chat_provider.dart';
import 'package:super_app/providers/feed_provider.dart';
import 'package:super_app/providers/language_provider.dart';
import 'package:super_app/providers/profile_provider.dart';
import 'package:super_app/providers/search_provider.dart';
import 'package:super_app/providers/service_provider.dart';
import 'package:super_app/providers/story_provider.dart';
import 'package:super_app/providers/theme_provider.dart';
import 'package:super_app/providers/video_feed_provider.dart';
import 'package:super_app/utils/app_language.dart';
import 'package:super_app/utils/constants.dart';
import 'package:super_app/view/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterLocalization.instance.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();
  final savedLanguageCode = prefs.getString('selected_language') ?? 'en';

  FlutterLocalization.instance.init(
    mapLocales: [
      const MapLocale('en', AppLocale.EN),
      const MapLocale('my', AppLocale.MY),
    ],
    initLanguageCode: savedLanguageCode,
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()..loadThemeMode()),
        ChangeNotifierProvider(create: (_) => LanguageProvider()),
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
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<ThemeProvider, LanguageProvider>(
      builder: (context, themeProvider, languageProvider, _) {
        return ScreenUtilInit(
          designSize: const Size(375, 812),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, child) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,

              supportedLocales: FlutterLocalization.instance.supportedLocales,
              localizationsDelegates:
                  FlutterLocalization.instance.localizationsDelegates,

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
