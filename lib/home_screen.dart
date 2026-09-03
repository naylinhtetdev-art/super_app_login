import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:super_app/providers/theme_provider.dart';
import 'package:super_app/utils/constants.dart';
import 'package:super_app/view/chat_tap_screen.dart';
import 'package:super_app/view/home_tap_screen.dart';
import 'package:super_app/view/me_tap_screen.dart';
import 'package:super_app/view/quick_tap_screen.dart';
import 'package:super_app/view/service_tap_screen.dart';
import 'package:super_app/view/splash_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int index = 0;
  int notificationCount = 5;
  final PageController _pageController = PageController();

  final pages = const [
    HomeTapScreen(),
    QuickTapScreen(),
    ServiceTapScreen(),
    ChatTapScreen(),
    MeTapScreen(),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onNavigationTap(int value) {
    setState(() {
      index = value;
    });

    _pageController.animateToPage(
      value,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  List<Widget> _buildAppBarActions(Color iconColor) {
    switch (index) {
      case 0:
        return [
          IconButton(
            icon: Image.asset(
              'assets/images/plus-filled.png',
              width: 24.w,
              height: 24.h,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: Image.asset(
              'assets/images/search.png',
              width: 24.w,
              height: 24.h,
              color: iconColor,
            ),
            onPressed: () {},
          ),
          IconButton(
            onPressed: () {},
            icon: Badge(
              isLabelVisible: notificationCount > 0,
              label: Text('$notificationCount'),
              child: Image.asset(
                'assets/images/noti.png',
                width: 24.w,
                height: 24.h,
                color: iconColor,
              ),
            ),
          ),
        ];
      case 2:
        return [
          IconButton(
            icon: Image.asset(
              'assets/images/search.png',
              width: 24.w,
              height: 24.h,
              color: iconColor,
            ),
            onPressed: () {},
          ),
          IconButton(
            onPressed: () {},
            icon: Badge(
              isLabelVisible: notificationCount > 0,
              label: Text('$notificationCount'),
              child: Image.asset(
                'assets/images/noti.png',
                width: 24.w,
                height: 24.h,
                color: iconColor,
              ),
            ),
          ),
        ];
      case 3:
        return [
          IconButton(
            onPressed: () {},
            icon: Badge(
              isLabelVisible: notificationCount > 0,
              label: Text('$notificationCount'),
              child: Image.asset(
                'assets/images/noti.png',
                width: 24.w,
                height: 24.h,
                color: iconColor,
              ),
            ),
          ),
        ];
      case 4:
        return [
          IconButton(
            icon: Image.asset(
              'assets/images/plus-filled.png',
              width: 24.w,
              height: 24.h,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: Image.asset(
              'assets/icons/edit-outline.png',
              width: 24.w,
              height: 24.h,
              color: iconColor,
            ),
            onPressed: () {},
          ),
        ];
      default:
        return const [];
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    final isDark = themeProvider.themeMode == ThemeMode.dark;

    final theme = Theme.of(context);
    final bgColor = theme.scaffoldBackgroundColor;
    final textColor = theme.colorScheme.onSurface;
    final iconColor = theme.iconTheme.color ?? textColor;
    final drawerBgColor = isDark ? Colors.grey.shade900 : Colors.white;
    final drawerHeaderBg = isDark
        ? Colors.grey.shade800
        : Colors.purple.shade50;

    return Scaffold(
      backgroundColor: bgColor,
      drawer: Drawer(
        backgroundColor: drawerBgColor,
        width: MediaQuery.of(context).size.width * 0.9,
        child: Column(
          // <--- Expanded ကို Column ထဲသို့ ထည့်သွင်းပေးထားပါသည်
          children: [
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  Container(
                    padding: const EdgeInsets.fromLTRB(16, 50, 16, 10),
                    color: drawerHeaderBg,
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 35.r,
                          child: Icon(Icons.person, size: 40.sp),
                        ),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 10.h),
                              Text(
                                'Ko Nay Lin',
                                style: TextStyle(
                                  color: textColor,
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 3.h),
                              Text(
                                'Yangon, Myanmar',
                                style: TextStyle(
                                  color: textColor.withValues(alpha: 0.7),
                                  fontSize: 12.sp,
                                ),
                              ),
                              SizedBox(height: 0.h),
                              Text(
                                'Verified Local',
                                style: TextStyle(
                                  color: Colors.amber,
                                  fontSize: 12.sp,
                                ),
                              ),
                              SizedBox(height: 6.h),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.person_outline,
                      color: AppColors.primary,
                    ),
                    title: Text(
                      'For You',
                      style: TextStyle(color: AppColors.primary),
                    ),
                    onTap: () => Navigator.pop(context),
                  ),
                  ListTile(
                    leading: Icon(Icons.menu, color: textColor),
                    title: Text(
                      'Following',
                      style: TextStyle(color: textColor),
                    ),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: Icon(Icons.group, color: textColor),
                    title: Text('Group', style: TextStyle(color: textColor)),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: Icon(
                      isDark ? Icons.dark_mode : Icons.light_mode,
                      color: textColor,
                    ),
                    title: Text(
                      'Display Setting',
                      style: TextStyle(color: textColor),
                    ),
                    onTap: () {
                      themeProvider.setThemeMode(
                        isDark ? ThemeMode.light : ThemeMode.dark,
                      );
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.language_outlined, color: textColor),
                    title: Text('Language', style: TextStyle(color: textColor)),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: Icon(Icons.settings, color: textColor),
                    title: Text(
                      'Account Setting',
                      style: TextStyle(color: textColor),
                    ),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: Icon(Icons.privacy_tip_sharp, color: textColor),
                    title: Text(
                      'Terms & Privacy',
                      style: TextStyle(color: textColor),
                    ),
                    onTap: () {},
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.r),
              child: InkWell(
                onTap: () {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (context) => const SplashScreen(),
                    ),
                    (route) => false,
                  );
                },
                borderRadius: BorderRadius.circular(12.r),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                  decoration: BoxDecoration(
                    color: isDark ? Colors.grey.shade800 : Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.logout_rounded,
                        color: Colors.redAccent,
                        size: 20.sp,
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        'Logout',
                        style: TextStyle(
                          color: Colors.redAccent,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),

      //  appBar
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            if (index != 1)
              SliverAppBar(
                floating: true,
                snap: true,
                pinned: false,
                backgroundColor: bgColor,
                elevation: 0,
                iconTheme: IconThemeData(color: iconColor),
                titleSpacing: 0,
                title: Text(
                  'OLLIO',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontSize: 28.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                actions: _buildAppBarActions(iconColor),
              ),
          ];
        },
        body: PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          onPageChanged: (pageIndex) {
            setState(() {
              index = pageIndex;
            });
          },
          children: pages,
        ),
      ),

      bottomNavigationBar: NavigationBar(
        backgroundColor: bgColor,
        selectedIndex: index,
        indicatorColor: Colors.transparent,
        onDestinationSelected: _onNavigationTap,
        labelTextStyle: WidgetStateProperty.resolveWith<TextStyle>((states) {
          if (states.contains(WidgetState.selected)) {
            return TextStyle(
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
            );
          }
          return TextStyle(color: textColor.withValues(alpha: 0.6));
        }),
        destinations: [
          NavigationDestination(
            icon: Image.asset(
              'assets/images/home-outline.png',
              width: 24.w,
              height: 24.h,
              color: iconColor,
            ),
            selectedIcon: Image.asset(
              'assets/images/home-bold.png',
              width: 24.w,
              height: 24.h,
              color: AppColors.primary,
            ),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Image.asset(
              'assets/images/quick-outline.png',
              width: 24.w,
              height: 24.h,
              color: iconColor,
            ),
            selectedIcon: Image.asset(
              'assets/images/quick-bold.png',
              width: 24.w,
              height: 24.h,
              color: AppColors.primary,
            ),
            label: 'Quick',
          ),
          NavigationDestination(
            icon: Image.asset(
              'assets/images/service-outline.png',
              width: 24.w,
              height: 24.h,
              color: iconColor,
            ),
            selectedIcon: Image.asset(
              'assets/images/service-bold.png',
              width: 24.w,
              height: 24.h,
              color: AppColors.primary,
            ),
            label: 'Service',
          ),
          NavigationDestination(
            icon: Image.asset(
              'assets/images/chat-outline.png',
              width: 24.w,
              height: 24.h,
              color: iconColor,
            ),
            selectedIcon: Image.asset(
              'assets/images/chat-bold.png',
              width: 24.w,
              height: 24.h,
              color: AppColors.primary,
            ),
            label: 'Chat',
          ),
          NavigationDestination(
            icon: Image.asset(
              'assets/images/me-outline.png',
              width: 24.w,
              height: 24.h,
              color: iconColor,
            ),
            selectedIcon: Image.asset(
              'assets/images/me-bold.png',
              width: 24.w,
              height: 24.h,
              color: AppColors.primary,
            ),
            label: 'Me',
          ),
        ],
      ),
    );
  }
}
