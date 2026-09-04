import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:super_app/providers/story_provider.dart';
import 'package:super_app/widget/create_story_screen.dart';
import 'package:super_app/widget/story_view_screen.dart';

class StorySection extends StatelessWidget {
  const StorySection({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = Theme.of(context).colorScheme.onSurface;
    final placeholderColor = isDark ? Colors.grey[800] : Colors.grey[300];

    return SizedBox(
      height: 90.h,
      child: Consumer<StoryProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (provider.stories.isEmpty) {
            return const SizedBox.shrink();
          }

          return ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            itemCount: provider.stories.length,
            itemBuilder: (context, index) {
              final story = provider.stories[index];

              return GestureDetector(
                onTap: () {
                  if (story.isAddStory) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CreateStoryScreen(),
                      ),
                    );
                  } else {
                    final allUsers = provider.stories
                        .where((s) => !s.isAddStory)
                        .map((s) => s.name)
                        .toSet()
                        .toList();

                    // 2. လက်ရှိ နှိပ်လိုက်သော User ၏ Index ကို ရှာခြင်း
                    final currentUserIndex = allUsers.indexOf(story.name);

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => StoryViewScreen(
                          allStories: provider.stories
                              .where((s) => !s.isAddStory)
                              .toList(),
                          initialUserIndex: currentUserIndex,
                        ),
                      ),
                    );
                  }
                },
                child: Container(
                  width: 65.w,
                  margin: EdgeInsets.only(right: 12.r),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(2.r),
                        decoration: story.isAddStory
                            ? BoxDecoration(
                                shape: BoxShape.circle,
                                color: placeholderColor,
                              )
                            : const BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.pink,
                                    Colors.orange,
                                    Colors.purple,
                                  ],
                                ),
                              ),
                        child: CircleAvatar(
                          radius: 27.r,
                          backgroundColor: placeholderColor,
                          // Network / Asset Image ခွဲခြားအသုံးပြုရန်
                          backgroundImage: story.profileUrl.startsWith('http')
                              ? NetworkImage(story.profileUrl) as ImageProvider
                              : AssetImage(story.profileUrl),
                        ),
                      ),
                      SizedBox(height: 5.h),
                      Text(
                        story.name,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: textColor, fontSize: 11.sp),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
