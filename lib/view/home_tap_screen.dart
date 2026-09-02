import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:super_app/extensions/context_extension.dart';
import 'package:super_app/providers/feed_provider.dart';
import 'package:super_app/view/post_card.dart';
import 'package:super_app/widget/announcement_card.dart';
import 'package:super_app/widget/follow_section.dart';
import 'package:super_app/widget/quick_mode_card.dart';
import 'package:super_app/widget/story_section.dart';
import 'package:super_app/widget/video_post.dart';

class HomeTapScreen extends StatelessWidget {
  const HomeTapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isTablet = context.isTablet;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Consumer<FeedProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).colorScheme.primary,
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: provider.refreshFeed,
            color: Theme.of(context).colorScheme.primary,
            child: ListView(
              padding: EdgeInsets.symmetric(
                horizontal: isTablet ? 20.w : 5.w,
                vertical: 12.h,
              ),
              children: [
                StorySection(),
                QuickModeCard(),
                SizedBox(height: 10.h),
                ...provider.posts.map((post) {
                  return PostCard(
                    post: post,
                    onLike: () => provider.toggleLike(post.id),
                    onEdit: () => provider.editPost(post.id),
                  );
                }),
                const AnnouncementCard(),
                const FollowSection(),
                const VideoPost(),
              ],
            ),
          );
        },
      ),
    );
  }
}
