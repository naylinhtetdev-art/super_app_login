import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:super_app/utils/constants.dart';

class EditBottomSheet extends StatelessWidget {
  const EditBottomSheet({super.key});

  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => const EditBottomSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textColor = Theme.of(context).colorScheme.onSurface;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28.r)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _ActionRowItem(
            unselectedIcon: Icons.bookmark_border_rounded,
            selectedIcon: Icons.bookmark_rounded,
            title: 'Saved Post',
            activeTitle: 'Saved',
            textColor: textColor,
            onTap: (isSelected) {
              // Saved / Unsaved state
            },
          ),

          _ActionRowItem(
            unselectedIcon: Icons.add_circle_outline_rounded,
            selectedIcon: Icons.check_circle_rounded,
            title: 'Follow',
            activeTitle: 'Following',
            textColor: textColor,
            onTap: (isSelected) {},
          ),

          _ActionRowItem(
            unselectedIcon: Icons.visibility_outlined,
            selectedIcon: Icons.visibility_off_outlined,
            title: 'Hide post',
            activeTitle: 'Unhide post',
            textColor: textColor,
            //isToggleable: false,
            onTap: (isSelected) {},
          ),
          _ActionRowItem(
            unselectedIcon: Icons.copy_rounded,
            title: 'Copy content link',
            textColor: textColor,
            isToggleable: false,
            onTap: (_) {},
          ),
          _ActionRowItem(
            unselectedIcon: Icons.block_outlined,
            title: 'Block',
            textColor: textColor,
            isToggleable: false,
            onTap: (_) {},
          ),
          _ActionRowItem(
            unselectedIcon: Icons.report_outlined,
            title: 'Report',
            textColor: textColor,
            isToggleable: false,
            onTap: (_) {},
          ),
          SizedBox(height: 10.h),
        ],
      ),
    );
  }
}

class _ActionRowItem extends StatefulWidget {
  final IconData unselectedIcon;
  final IconData? selectedIcon;
  final String title;
  final String? activeTitle;
  final Color textColor;
  final bool isToggleable;
  final Function(bool isSelected)? onTap;

  const _ActionRowItem({
    required this.unselectedIcon,
    this.selectedIcon,
    required this.title,
    this.activeTitle,
    required this.textColor,
    this.isToggleable = true,
    this.onTap,
  });

  @override
  State<_ActionRowItem> createState() => _ActionRowItemState();
}

class _ActionRowItemState extends State<_ActionRowItem> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    // နှိပ်လိုက်ချိန်တွင် ပြောင်းချင်သည့် Primary Color (ခရမ်းရောင်/Accent Color)
    final activeColor = AppColors.primary;

    final currentColor = isSelected ? activeColor : widget.textColor;
    final currentIcon = (isSelected && widget.selectedIcon != null)
        ? widget.selectedIcon!
        : widget.unselectedIcon;
    final currentTitle = (isSelected && widget.activeTitle != null)
        ? widget.activeTitle!
        : widget.title;

    return InkWell(
      onTap: () {
        if (widget.isToggleable) {
          setState(() {
            isSelected = !isSelected;
          });
        }
        widget.onTap?.call(isSelected);
      },
      borderRadius: BorderRadius.circular(10.r),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 4.w),
        child: Row(
          children: [
            Icon(currentIcon, color: currentColor, size: 18.sp),
            SizedBox(width: 14.w),
            Text(
              currentTitle,
              style: TextStyle(
                color: currentColor,
                fontSize: 12.sp,
                fontWeight: isSelected ? FontWeight.w900 : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
