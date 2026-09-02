import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:super_app/extensions/context_extension.dart';
import 'package:super_app/providers/video_feed_provider.dart';

class QuickTapScreen extends StatelessWidget {
  const QuickTapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isTablet = context.isTablet;
    final videoProvider = Provider.of<VideoFeedProvider>(context);

    return Scaffold(
      backgroundColor: Colors.black,
      body: PageView.builder(
        scrollDirection: Axis.vertical,
        itemCount: videoProvider.videos.length,
        itemBuilder: (context, index) {
          final video = videoProvider.videos[index];
          return Stack(
            children: [
              // Background Image/Video Container
              Positioned.fill(
                child: Image.asset(
                  video.videoUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      Container(color: Colors.grey[900]),
                ),
              ),

              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.black.withOpacity(0.3),
                        Colors.transparent,
                        Colors.black.withOpacity(0.7),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: const [0.0, 0.5, 1.0],
                    ),
                  ),
                ),
              ),

              // Top Navigation Bar (Discover | Following | For you)
              Positioned(
                top: 50.h,
                left: 0.w,
                right: 0.w,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(width: 30.w), // Alignment Balance
                      Row(
                        children: [
                          _buildTabItem(context, 'Discover', 0),
                          SizedBox(width: 12.w),
                          _buildTabItem(context, 'Following', 1),
                          SizedBox(width: 12.w),
                          _buildTabItem(context, 'For you', 2),
                        ],
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.search,
                          color: Colors.white,
                          size: 28.r,
                        ),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ),

              // Right Action Buttons (Like, Comment, Share)
              Positioned(
                right: 16.w,
                bottom: 40.h,
                child: Column(
                  children: [
                    _buildActionButton(
                      icon: video.isLiked
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: video.isLiked ? Colors.red : Colors.white,
                      label: '${(video.likes / 1000).toStringAsFixed(0)}k',
                      onTap: () => videoProvider.toggleLike(index),
                    ),
                    SizedBox(height: 20.h),
                    _buildActionButton(
                      icon: Icons.chat_bubble_outline_rounded,
                      label: '${video.comments}',
                      onTap: () {},
                    ),
                    SizedBox(height: 20.h),
                    _buildActionButton(
                      icon: Icons.near_me_outlined,
                      label: '${video.shares}',
                      onTap: () {},
                    ),
                  ],
                ),
              ),

              // Bottom Info Section (User Info, Caption & Audio)
              Positioned(
                left: 16.w,
                bottom: 30.h,
                right: 80.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // User Profile Row
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 18.r,
                          backgroundColor: Colors.brown[600],
                          child: Text(
                            video.profileInitials,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Text(
                          video.username,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.sp,
                          ),
                        ),
                        SizedBox(width: 10.w),
                        OutlinedButton(
                          onPressed: () => videoProvider.toggleFollow(index),
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(
                              color: Colors.white,
                              width: 1,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: 14.h,
                              vertical: 0.w,
                            ),
                            minimumSize: Size(0.w, 30.h),
                          ),
                          child: Text(
                            video.isFollowing ? 'Following' : 'Follow',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12.sp,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12.h),

                    // Caption Text
                    Text(
                      video.caption,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.sp,
                        height: 1.3.h,
                      ),
                    ),
                    SizedBox(height: 12.h),

                    // Audio Info
                    Row(
                      children: [
                        Icon(Icons.music_note, color: Colors.white, size: 16.r),
                        SizedBox(width: 6.w),
                        Expanded(
                          child: Text(
                            video.audioTitle,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 13.sp,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  // Top Nav Tab Helper Widget
  Widget _buildTabItem(BuildContext context, String title, int index) {
    final provider = Provider.of<VideoFeedProvider>(context);
    final isSelected = provider.selectedTabIndex == index;

    return GestureDetector(
      onTap: () => provider.setTab(index),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
        decoration: isSelected
            ? BoxDecoration(
                color: Colors.white.withOpacity(0.25),
                borderRadius: BorderRadius.circular(20),
              )
            : null,
        child: Text(
          title,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.white60,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            fontSize: 14.sp,
          ),
        ),
      ),
    );
  }

  // Right Side Action Button Helper Widget
  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    Color color = Colors.white,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 32.r),
          SizedBox(height: 4.h),
          Text(
            label,
            style: TextStyle(
              color: Colors.white,
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
