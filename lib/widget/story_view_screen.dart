import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:super_app/model/story_model.dart';

class StoryViewScreen extends StatefulWidget {
  final List<StoryModel> allStories;
  final int initialUserIndex;

  const StoryViewScreen({
    super.key,
    required this.allStories,
    required this.initialUserIndex,
  });

  @override
  State<StoryViewScreen> createState() => _StoryViewScreenState();
}

class _StoryViewScreenState extends State<StoryViewScreen>
    with SingleTickerProviderStateMixin {
  late PageController _pageController;
  late AnimationController _animController;

  // List<String> _userNames = [];
  int _currentUserIndex = 0;
  int _currentStoryIndex = 0;
  //List<StoryModel> _currentUserStories = [];

  //int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    //_userNames = widget.allStories.map((e) => e.name).toSet().toList();
    _currentUserIndex = widget.initialUserIndex;
    // _loadCurrentUserStories();

    //_currentIndex = widget.initialIndex;
    //_pageController = PageController(initialPage: _currentStoryIndex);
    _pageController = PageController();
    // ၅ စက္ကန့်စာ Timer Animation
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );

    _animController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _nextStory();
      }
    });

    _animController.forward();
  }

  // void _loadCurrentUserStories() {
  //   final currentUserName = _userNames[_currentUserIndex];
  //   _currentUserStories = widget.allStories
  //       .where((s) => s.name == currentUserName)
  //       .toList();
  //   _currentStoryIndex = 0;
  // }

  void _nextStory() {
    final currentUser = widget.allStories[_currentUserIndex];
    if (_currentStoryIndex < currentUser.stories.length - 1) {
      setState(() {
        _currentStoryIndex++;
      });
      _pageController.animateToPage(
        _currentStoryIndex,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      _animController.reset();
      _animController.forward();
    } else if (_currentUserIndex < widget.allStories.length - 1) {
      setState(() {
        _currentUserIndex++;
        _currentStoryIndex = 0;
        // _loadCurrentUserStories();
      });
      _pageController.jumpToPage(0);
      _animController.reset();
      _animController.forward();
    } else {
      Navigator.pop(context);
    }
  }

  void _previousStory() {
    if (_currentStoryIndex > 0) {
      setState(() {
        _currentStoryIndex--;
      });
      _pageController.animateToPage(
        _currentStoryIndex,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      _animController.reset();
      _animController.forward();
    } else if (_currentUserIndex > 0) {
      setState(() {
        _currentUserIndex--;
        // _loadCurrentUserStories();
        _currentStoryIndex =
            widget.allStories[_currentUserIndex].stories.length - 1;
      });
      _pageController.jumpToPage(_currentStoryIndex);
      _animController.reset();
      _animController.forward();
    } else {
      _animController.reset();
      _animController.forward();
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.allStories.isEmpty) return const SizedBox.shrink();

    // final currentStory = _currentUserStories[_currentStoryIndex];
    final currentUser = widget.allStories[_currentUserIndex];
    //final currentStoryItem = currentUser.stories[_currentStoryIndex];

    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onLongPressDown: (_) => _animController.stop(),

        onLongPressUp: () => _animController.forward(),

        onTapDown: (details) {
          final double screenWidth = MediaQuery.of(context).size.width;
          if (details.globalPosition.dx < screenWidth / 3) {
            _previousStory();
          } else if (details.globalPosition.dx > (screenWidth * 2) / 3) {
            _nextStory();
          }
        },
        child: Stack(
          children: [
            PageView.builder(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(), // Touch Gesture
              itemCount: currentUser.stories.length,
              itemBuilder: (context, index) {
                final storyItem = currentUser.stories[index];
                return Image.asset(
                  storyItem.imageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                );
              },
            ),

            // Gradient Overlay
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.6),
                    Colors.transparent,
                    Colors.black.withOpacity(0.7),
                  ],
                ),
              ),
            ),

            //Top Bar (LinearProgressIndicator များ & User Info)
            SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Dynamic Progress Indicator Bars
                    AnimatedBuilder(
                      animation: _animController,
                      builder: (context, child) {
                        return Row(
                          children: List.generate(currentUser.stories.length, (
                            index,
                          ) {
                            return Expanded(
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 2.w),
                                child: LinearProgressIndicator(
                                  value: index < _currentStoryIndex
                                      ? 1.0 //
                                      : (index == _currentStoryIndex
                                            ? _animController.value
                                            : 0.0),
                                  backgroundColor: Colors.white24,
                                  valueColor:
                                      const AlwaysStoppedAnimation<Color>(
                                        Colors.white,
                                      ),
                                  minHeight: 2.5.h,
                                ),
                              ),
                            );
                          }), //.toList(),
                        );
                      },
                    ),
                    SizedBox(height: 12.h),

                    // User Info
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 18.r,
                          backgroundImage: AssetImage(currentUser.profileUrl),
                        ),
                        SizedBox(width: 10.w),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              currentUser.name,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 14.sp,
                              ),
                            ),
                            Text(
                              '2m ago',
                              style: TextStyle(
                                color: Colors.grey.shade300,
                                fontSize: 10.sp,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        IconButton(
                          icon: const Icon(
                            Icons.close_rounded,
                            color: Colors.white,
                          ),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // ၃။ Bottom Reply Section
            Positioned(
              bottom: 20.h,
              left: 16.w,
              right: 16.w,
              child: SafeArea(
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 12.h,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(24.r),
                        ),
                        child: Text(
                          'Say something...',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 13.sp,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10.w),
                    IconButton(
                      icon: const Icon(
                        Icons.favorite_border_rounded,
                        color: Colors.white,
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
