import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StorySection extends StatelessWidget {
  const StorySection({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = Theme.of(context).colorScheme.onSurface;
    final placeholderColor = isDark ? Colors.grey[800] : Colors.grey[300];
    final users = [
      ['Add Story', 'assets/images/story-plus-filled.png'],
      ['My Story', 'assets/images/user-ellipse-2.png'],
      ['Mya', 'assets/images/user-ellipse-1.png'],
      ['Su Su', 'assets/images/user-ellipse-2.png'],
      ['Htet', 'assets/images/user-ellipse-1.png'],
      ['Aung', 'assets/images/user-ellipse-2.png'],
      ['Naing', 'assets/images/user-ellipse-1.png'],
      ['Zin', 'assets/images/user-ellipse-2.png'],
    ];

    return SizedBox(
      height: 90.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 12.h),
        itemCount: users.length,
        itemBuilder: (context, index) {
          return Container(
            width: 65.w,
            margin: EdgeInsets.only(right: 12.r),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(2.r),
                  decoration: users[index][0] == 'Add Story'
                      ? BoxDecoration(
                          shape: BoxShape.circle,
                          color: placeholderColor,
                        )
                      : const BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            colors: [Colors.pink, Colors.orange, Colors.purple],
                          ),
                        ),
                  child: CircleAvatar(
                    radius: 27.r,
                    backgroundImage: AssetImage(users[index][1]),
                    backgroundColor: placeholderColor,
                  ),
                ),

                SizedBox(height: 5.h),

                Text(
                  users[index][0],
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: textColor, fontSize: 11.sp),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
