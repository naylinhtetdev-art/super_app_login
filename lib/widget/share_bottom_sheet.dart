import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:super_app/utils/constants.dart';

class ShareBottomSheet extends StatelessWidget {
  const ShareBottomSheet({super.key});

  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => const ShareBottomSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = Theme.of(context).colorScheme.onSurface;
    final borderColor = isDark
        ? Colors.white.withOpacity(0.08)
        : Colors.black.withOpacity(0.08);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28.r)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 22.r,
                backgroundImage: AssetImage('assets/images/user-ellipse-2.png'),
              ),
              SizedBox(width: 12.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Kyaw Zin',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  // Public Dropdown Chip
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.w,
                      vertical: 2.h,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF23232A),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Row(
                      children: [
                        Text(
                          'Public',
                          style: TextStyle(
                            color: Colors.grey.shade400,
                            fontSize: 11.sp,
                          ),
                        ),
                        Icon(
                          Icons.arrow_drop_down,
                          color: Colors.grey.shade400,
                          size: 16.sp,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Spacer(),
              // Repost Button
              Container(
                padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Text(
                  'Repost',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 20.h),

          // 2. Horizontal Social Apps Share Options
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildSocialItem(
                  iconPath: 'assets/icons/my_chat.png',
                  label: 'My Chat',
                  fallbackIcon: Icons.chat_bubble_outline_rounded,
                  iconColor: AppColors.primary,
                  textColor: textColor,
                ),
                _buildSocialItem(
                  iconPath: 'assets/icons/facebook.png',
                  label: 'Facebook',
                  fallbackIcon: Icons.facebook,
                  iconColor: const Color(0xFF1877F2),
                  textColor: textColor,
                ),
                _buildSocialItem(
                  iconPath: 'assets/icons/telegram.png',
                  label: 'Telegram',
                  fallbackIcon: Icons.telegram,
                  iconColor: const Color(0xFF229ED9),
                  textColor: textColor,
                ),
                _buildSocialItem(
                  iconPath: 'assets/icons/tiktok.png',
                  label: 'Tiktok',
                  fallbackIcon: Icons.tiktok,
                  iconColor: Colors.white,
                  textColor: textColor,
                ),
                _buildSocialItem(
                  iconPath: 'assets/icons/messenger.png',
                  label: 'Messenger',
                  fallbackIcon: Icons.near_me_rounded,
                  iconColor: const Color(0xFFA855F7),
                  textColor: textColor,
                ),
                _buildSocialItem(
                  iconPath: 'assets/icons/bluetooth.png',
                  label: 'Bluetooth',
                  fallbackIcon: Icons.bluetooth,
                  iconColor: Colors.white,
                  textColor: textColor,
                ),
              ],
            ),
          ),

          SizedBox(height: 10.h),
          Divider(color: borderColor, thickness: 1),
          SizedBox(height: 4.h),

          _buildActionRow(
            icon: Icons.add_circle_outline_rounded,
            title: 'Your Story',
            onTap: () {},
            textColor: textColor,
          ),
          _buildActionRow(
            icon: Icons.groups_outlined,
            title: 'Share Groups',
            onTap: () {},
            textColor: textColor,
          ),
          _buildActionRow(
            icon: Icons.copy_rounded,
            title: 'Copy link',
            onTap: () {},
            textColor: textColor,
          ),
          SizedBox(height: 10.h),
        ],
      ),
    );
  }

  // Social Icon Custom Builder
  Widget _buildSocialItem({
    required String iconPath,
    required String label,
    required IconData fallbackIcon,
    required Color iconColor,
    required Color textColor,
  }) {
    return Padding(
      padding: EdgeInsets.only(right: 16.w),
      child: Column(
        children: [
          Container(
            width: 48.w,
            height: 48.h,
            decoration: const BoxDecoration(
              color: AppColors.darkSurface,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Icon(fallbackIcon, color: iconColor, size: 24.sp),
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            label,
            style: TextStyle(color: textColor, fontSize: 11.sp),
          ),
        ],
      ),
    );
  }

  // Bottom Action List Item Builder
  Widget _buildActionRow({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    required Color textColor,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10.r),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 4.w),
        child: Row(
          children: [
            Icon(icon, color: textColor, size: 22.sp),
            SizedBox(width: 14.w),
            Text(
              title,
              style: TextStyle(
                color: textColor,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
