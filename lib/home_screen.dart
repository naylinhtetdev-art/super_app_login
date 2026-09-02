import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:super_app/providers/theme_provider.dart';
import 'package:super_app/view/chat_tap_screen.dart';
import 'package:super_app/view/home_tap_screen.dart';
import 'package:super_app/view/me_tap_screen.dart';
import 'package:super_app/view/quick_tap_screen.dart';
import 'package:super_app/view/service_tap_screen.dart';

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

  void _push(Widget page) {
    Navigator.pop(context);
    Navigator.push(context, MaterialPageRoute(builder: (_) => page));
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

  List<Widget> _buildAppBarActions() {
    switch (index) {
      case 0:
        return [
          IconButton(
            icon: Image(
              image: AssetImage('assets/images/plus-filled.png'),
              width: 24.w,
              height: 24.h,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: Image(
              image: AssetImage('assets/images/search.png'),
              width: 24.w,
              height: 24.h,
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
              ),
            ),
          ),
        ];
      case 2:
        return [
          IconButton(
            icon: Image(
              image: AssetImage('assets/images/search.png'),
              width: 24.w,
              height: 24.h,
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
              ),
            ),
          ),
        ];
      case 4:
        return [
          IconButton(
            icon: Image(
              image: AssetImage('assets/images/plus-filled.png'),
              width: 24.w,
              height: 24.h,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: Image(
              image: AssetImage('assets/icons/edit-outline.png'),
              width: 24.w,
              height: 24.h,
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
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: index == 1
          ? null
          : AppBar(
              iconTheme: const IconThemeData(color: Colors.white),
              backgroundColor: Colors.black,
              title: Text(
                'OLLIO',
                style: TextStyle(
                  color: Colors.purple,
                  fontSize: 28.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              titleSpacing: 0,
              elevation: 3,
              actions: _buildAppBarActions(),
            ),
      drawer: Drawer(
        backgroundColor: Colors.grey.shade800,
        width: MediaQuery.of(context).size.width * 0.9,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(16, 50, 16, 10),
              color: Colors.grey.shade700,
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
                            color: Colors.white,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        SizedBox(height: 3.h),

                        Text(
                          'Yangon, Myanmar',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12.sp,
                          ),
                        ),

                        SizedBox(height: 0.h),

                        Text(
                          'Veirfity Local',
                          style: TextStyle(
                            color: Colors.yellow,
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
              leading: const Icon(Icons.person_outline, color: Colors.purple),
              title: const Text(
                'For You',
                style: TextStyle(color: Colors.purple),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.menu, color: Colors.white),
              title: const Text(
                'Following',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.group, color: Colors.white),
              title: const Text('Group', style: TextStyle(color: Colors.white)),
              onTap: () {},
            ),

            ListTile(
              leading: Icon(
                isDark ? Icons.dark_mode : Icons.dark_mode_outlined,
                color: isDark
                    ? Colors.white
                    : Colors.black, // Active/Inactive Icon Color
              ),
              title: Text(
                'Display Setting',
                style: TextStyle(color: isDark ? Colors.white : Colors.black),
              ),
              trailing: Switch(
                value: isDark,
                onChanged: (bool value) {
                  themeProvider.setThemeMode(
                    value ? ThemeMode.dark : ThemeMode.light,
                  );
                },
              ),
              onTap: () {
                themeProvider.setThemeMode(
                  isDark ? ThemeMode.light : ThemeMode.dark,
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.language_outlined, color: Colors.white),
              title: const Text(
                'Language',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.settings, color: Colors.white),
              title: const Text(
                'Account Setting',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.privacy_tip_sharp, color: Colors.white),
              title: const Text(
                'Terms & Privacy',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {},
            ),
          ],
        ),
      ),
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

      bottomNavigationBar: NavigationBar(
        backgroundColor: Colors.black,
        selectedIndex: index,
        indicatorColor: Colors.transparent,
        onDestinationSelected: _onNavigationTap,
        labelTextStyle: WidgetStateProperty.resolveWith<TextStyle>((states) {
          if (states.contains(WidgetState.selected)) {
            return const TextStyle(
              color: Colors.purple,
              fontWeight: FontWeight.bold,
            );
          }

          return const TextStyle(color: Colors.purple);
        }),

        destinations: [
          NavigationDestination(
            icon: Image(
              image: AssetImage('assets/images/home-outline.png'),
              width: 24.w,
              height: 24.h,
            ),
            selectedIcon: Image(
              image: AssetImage('assets/images/home-bold.png'),
              width: 24.w,
              height: 24.h,
            ),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Image(
              image: AssetImage('assets/images/quick-outline.png'),
              width: 24.w,
              height: 24.h,
            ),
            selectedIcon: Image(
              image: AssetImage('assets/images/quick-bold.png'),
              width: 24.w,
              height: 24.h,
            ),
            label: 'Quick',
          ),
          NavigationDestination(
            icon: Image(
              image: AssetImage('assets/images/service-outline.png'),
              width: 24.w,
              height: 24.h,
            ),
            selectedIcon: Image(
              image: AssetImage('assets/images/service-bold.png'),
              width: 24.w,
              height: 24.h,
            ),
            label: 'Service',
          ),
          NavigationDestination(
            icon: Image(
              image: AssetImage('assets/images/chat-outline.png'),
              width: 24.w,
              height: 24.h,
            ),
            selectedIcon: Image(
              image: AssetImage('assets/images/chat-bold.png'),
              width: 24.w,
              height: 24.h,
            ),
            label: 'Chat',
          ),
          NavigationDestination(
            icon: Image(
              image: AssetImage('assets/images/me-outline.png'),
              width: 24.w,
              height: 24.h,
            ),
            selectedIcon: Image(
              image: AssetImage('assets/images/me-bold.png'),
              width: 24.w,
              height: 24.h,
            ),
            label: 'Me',
          ),
        ],
      ),
    );
  }
}
