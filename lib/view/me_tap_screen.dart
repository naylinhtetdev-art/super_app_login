import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:super_app/model/user_model.dart';
import 'package:super_app/providers/profile_provider.dart';

class MeTapScreen extends StatelessWidget {
  const MeTapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ProfileProvider>();
    final user = provider.user;

    if (user == null) {
      return const Scaffold(
        backgroundColor: Color(0xFF121212),
        body: Center(
          child: CircularProgressIndicator(color: Color(0xFFD633E1)),
        ),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header Image, App Bar & Profile Avatar Overlay
            Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                // 1. Cover Image Background (API သို့မဟုတ် Asset ပုံ ထည့်ရန်)
                Container(
                  height: 180.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color(
                      0xFF2A2A2E,
                    ), // Image မတက်မီ ပြသမည့် Placeholder Color
                    image: DecorationImage(
                      image: user.coverUrl.startsWith('http')
                          ? NetworkImage(user.coverUrl)
                          : AssetImage(user.coverUrl) as ImageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                // Cover Overlay Dark Gradient (စာများ ပိုမို ထင်ရှားစေရန်)
                Container(
                  height: 180.h,
                  width: double.infinity,
                  color: Colors.black.withOpacity(0.35),
                ),

                // "Share memories!" Floating Tooltip Badge
                Positioned(
                  bottom: 58.h,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 5.h,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1E1E24),
                      borderRadius: BorderRadius.circular(16.r),
                      border: Border.all(color: Colors.white12),
                    ),
                    child: Text(
                      'Share memories!',
                      style: TextStyle(color: Colors.white70, fontSize: 11.sp),
                    ),
                  ),
                ),

                // 2. Profile Avatar with White Border & Add (+) Badge
                Positioned(
                  bottom: -40.h,
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      // White Border Container
                      Container(
                        padding: EdgeInsets.all(3.r),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: CircleAvatar(
                          radius: 48.r,
                          backgroundColor: Colors.grey[800],
                          backgroundImage: user.avatarUrl.startsWith('http')
                              ? NetworkImage(user.avatarUrl)
                              : AssetImage(user.avatarUrl) as ImageProvider,
                        ),
                      ),

                      // Purple Plus (+) Icon Badge
                      Positioned(
                        right: 2.w,
                        bottom: 2.h,
                        child: CircleAvatar(
                          radius: 15.r,
                          backgroundColor: const Color(0xFFD633E1),
                          child: Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 18.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Cover Photo Edit Button (Top Right corner of cover)
                Positioned(
                  right: 16.w,
                  bottom: 12.h,
                  child: CircleAvatar(
                    radius: 14.r,
                    backgroundColor: Colors.black54,
                    child: Icon(
                      Icons.edit_outlined,
                      color: Colors.white,
                      size: 14.sp,
                    ),
                  ),
                ),
              ],
            ),
            // User Name & Handle
            SizedBox(height: 45.h),
            Text(
              user.name,
              style: TextStyle(
                color: Colors.white,
                fontSize: 22.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 0.h),
            Text(
              user.username,
              style: TextStyle(color: Colors.white54, fontSize: 13.sp),
            ),
            SizedBox(height: 10.h),

            // Stats Row (Followers / Following / Posts)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildStatItem(
                  '${(user.followers / 1000).toStringAsFixed(1)}K',
                  'Followers',
                ),
                _buildStatItem('${user.following}', 'Following'),
                _buildStatItem('${user.postsCount}', 'Posts'),
              ],
            ),
            SizedBox(height: 16.h),

            // Bio
            Text(
              user.bio,
              style: TextStyle(color: Colors.white38, fontSize: 13.sp),
            ),
            SizedBox(height: 20.h),

            // Action Buttons (Edit Profile & Share)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 44.h,
                      decoration: BoxDecoration(
                        color: const Color(0xFF1E1E24),
                        borderRadius: BorderRadius.circular(22.r),
                      ),
                      child: Center(
                        child: Text(
                          'Edit Profile',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Container(
                    width: 44.w,
                    height: 44.h,
                    decoration: BoxDecoration(
                      color: const Color(0xFF1E1E24),
                      borderRadius: BorderRadius.circular(22.r),
                    ),
                    child: Icon(
                      Icons.share_outlined,
                      color: Colors.white,
                      size: 20.sp,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24.h),

            // Custom Tab Bar (Posts, Quick, Community, Saved)
            _buildTabBar(provider),
            SizedBox(height: 12.h),

            // Posts Feed List
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: provider.posts.length,
              itemBuilder: (context, index) {
                final post = provider.posts[index];
                return _buildPostCard(post);
              },
            ),
          ],
        ),
      ),
    );
  }

  // Helper: Stats Column
  Widget _buildStatItem(String count, String label) {
    return Column(
      children: [
        Text(
          count,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          label,
          style: TextStyle(color: Colors.white54, fontSize: 12.sp),
        ),
      ],
    );
  }

  // Helper: Tab Bar
  Widget _buildTabBar(ProfileProvider provider) {
    final tabs = [
      {'icon': Icons.video_collection_outlined, 'title': 'Posts'},
      {'icon': Icons.play_circle_outline, 'title': 'Quick'},
      {'icon': Icons.people_outline, 'title': 'Community'},
      {'icon': Icons.bookmark_border, 'title': 'Saved'},
    ];

    return Container(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.white12, width: 1)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(tabs.length, (index) {
          final isSelected = provider.selectedTabIndex == index;
          return GestureDetector(
            onTap: () => provider.setTab(index),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10.h),
              decoration: isSelected
                  ? const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: Color(0xFFD633E1), width: 2),
                      ),
                    )
                  : null,
              child: Row(
                children: [
                  Icon(
                    tabs[index]['icon'] as IconData,
                    color: isSelected
                        ? const Color(0xFFD633E1)
                        : Colors.white54,
                    size: 18.sp,
                  ),
                  SizedBox(width: 6.w),
                  Text(
                    tabs[index]['title'] as String,
                    style: TextStyle(
                      color: isSelected
                          ? const Color(0xFFD633E1)
                          : Colors.white54,
                      fontSize: 13.sp,
                      fontWeight: isSelected
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  // Helper: Post Feed Card
  Widget _buildPostCard(UserPostModel post) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      color: const Color(0xFF1A1A1E),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: CircleAvatar(
              radius: 18.r,
              backgroundImage: AssetImage(post.userAvatar),
            ),
            title: Text(
              post.userName,
              style: TextStyle(
                color: Colors.white,
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              post.timeAgo,
              style: TextStyle(color: Colors.white38, fontSize: 11.sp),
            ),
            trailing: const Icon(Icons.more_vert, color: Colors.white54),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Text(
              post.content,
              style: TextStyle(
                color: Colors.white70,
                fontSize: 13.sp,
                height: 1.4,
              ),
            ),
          ),
          SizedBox(height: 8.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Text(
              post.hashtags,
              style: TextStyle(color: const Color(0xFFD633E1), fontSize: 11.sp),
            ),
          ),
          SizedBox(height: 12.h),
          if (post.imageUrl != null)
            Image.asset(
              post.imageUrl!,
              width: double.infinity,
              height: 220.h,
              fit: BoxFit.cover,
            ),
        ],
      ),
    );
  }
}
