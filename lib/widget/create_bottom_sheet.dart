import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CreateBottomSheet extends StatelessWidget {
  const CreateBottomSheet({super.key});

  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const CreateBottomSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF16161E),
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Drag Handle
          Container(
            width: 40.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: Colors.white24,
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),
          SizedBox(height: 16.h),

          // Header Bar (Close Button & Title)
          Row(
            children: [
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.close, color: Colors.white70),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
              Expanded(
                child: Text(
                  'Create',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(width: 24.w), // Balance matching for close button
            ],
          ),
          SizedBox(height: 18.h),

          // Title & Subtitle
          Text(
            "What's on your mind?",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 0.h),
          Text(
            "Share your thoughts, moments, or start a\ndiscussion.",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey.shade400, fontSize: 14.sp),
          ),
          SizedBox(height: 4.h),

          // Action Options List
          _buildActionCard(
            icon: Icons.edit_note_rounded,
            iconBgColor: const Color(0xFF3F1922),
            iconColor: const Color(0xFFFF3B30),
            title: "Create Post",
            subtitle: "Share photos, text, and updates with your network.",
            onTap: () {
              Navigator.pop(context);
              // TODO: Navigate to Create Post
            },
          ),
          SizedBox(height: 12.h),

          _buildActionCard(
            icon: Icons.movie_creation_outlined,
            iconBgColor: const Color(0xFF183133),
            iconColor: const Color(0xFF30D158),
            title: "Share Quick",
            subtitle: "Upload or record a short-form video.",
            onTap: () {
              Navigator.pop(context);
              // TODO: Navigate to Share Quick
            },
          ),
          SizedBox(height: 12.h),

          _buildActionCard(
            icon: Icons.add_circle_outline_rounded,
            iconBgColor: const Color(0xFF152A4A),
            iconColor: const Color(0xFF0A84FF),
            title: "Add Story",
            subtitle: "Show your feeling to share with your friends.",
            onTap: () {
              Navigator.pop(context);
              // TODO: Navigate to Add Story
            },
          ),
          SizedBox(height: 12.h),

          _buildActionCard(
            icon: Icons.help_outline_rounded,
            iconBgColor: const Color(0xFF382F18),
            iconColor: const Color(0xFFFFD60A),
            title: "Ask a Question",
            subtitle: "Start a circle poll or Q&A session.",
            onTap: () {
              Navigator.pop(context);
              // TODO: Navigate to Ask a Question
            },
          ),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }

  // Reusable Option Card Widget
  Widget _buildActionCard({
    required IconData icon,
    required Color iconBgColor,
    required Color iconColor,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E2A),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16.r),
          child: Padding(
            padding: EdgeInsets.only(
              left: 16.r,
              right: 16.r,
              top: 8.r,
              bottom: 8.r,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: EdgeInsets.all(10.r),
                  decoration: BoxDecoration(
                    color: iconBgColor,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, color: iconColor, size: 22.sp),
                ),
                SizedBox(height: 14.h),
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: Colors.grey.shade400,
                    fontSize: 14.sp,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
