import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:super_app/main.dart';
import 'package:super_app/model/post_model.dart';
import 'package:super_app/providers/theme_provider.dart';
import 'package:super_app/view/post_card.dart';

void main() {
  testWidgets('PostCard action buttons render without missing asset errors', (
    WidgetTester tester,
  ) async {
    final post = PostModel(
      id: '1',
      userName: 'Nay',
      avatar: 'assets/images/profile-image.png',
      text: 'Hello world',
      hashtags: '#flutter',
      images: const ['assets/images/opst-img-1.png'],
      likes: 12,
      comments: 3,
      share: 8,
      timeAgo: '2h',
    );

    await tester.pumpWidget(
      ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, __) {
          return MaterialApp(
            home: Scaffold(body: PostCard(post: post)),
          );
        },
      ),
    );

    expect(find.byType(PostCard), findsOneWidget);
    expect(find.text('12'), findsOneWidget);
    expect(find.text('3'), findsOneWidget);
    expect(find.text('8'), findsOneWidget);
  });

  testWidgets('MyApp applies the selected theme mode to the MaterialApp', (
    WidgetTester tester,
  ) async {
    final themeProvider = ThemeProvider();
    await themeProvider.setThemeMode(ThemeMode.dark);

    await tester.pumpWidget(
      ChangeNotifierProvider<ThemeProvider>.value(
        value: themeProvider,
        child: const MyApp(),
      ),
    );

    final materialApp = tester.widget<MaterialApp>(find.byType(MaterialApp));
    expect(materialApp.themeMode, ThemeMode.dark);
    expect(
      Theme.of(tester.element(find.byType(Scaffold))).brightness,
      Brightness.dark,
    );
  });
}
