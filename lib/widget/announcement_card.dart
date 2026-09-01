import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AnnouncementCard extends StatelessWidget {
  const AnnouncementCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 0.w, vertical: 8.h),
      padding: EdgeInsets.fromLTRB(0.w, 0.h, 0.w, 0.h),
      decoration: BoxDecoration(
        color: Color(0xFF12131A),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.white.withOpacity(0.08)),
      ),
      child: Stack(
        children: [
          Positioned(
            left: 0.w,
            top: 0.h,
            bottom: 0.h,
            child: Container(
              width: 5.w,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 255, 191, 0),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(14.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.campaign,
                      color: Color(0xFFFFB800),
                      size: 17,
                    ),

                    const SizedBox(width: 7),

                    Text(
                      'Community Alert',
                      style: TextStyle(
                        color: Color(0xFFFFB800),
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    Spacer(),

                    Icon(
                      Icons.more_horiz,
                      color: Colors.grey.shade600,
                      size: 18.sp,
                    ),
                  ],
                ),

                SizedBox(height: 9.h),

                Text(
                  'Scheduled power maintenance in Hledan '
                  'area tomorrow from 9 AM to 1 PM. Please '
                  'plan accordingly. Stay cool! ☀️',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.sp,
                    height: 1.4.h,
                  ),
                ),

                SizedBox(height: 12.h),

                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 9.h,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFF59D),
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.bolt, color: Color(0xFFFF00C8), size: 21.w),

                      SizedBox(width: 9.w),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'Yangon Electricity Supply Board',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Color(0xFF343434),
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),

                            SizedBox(height: 2),

                            Text(
                              'Verified Utility',
                              style: TextStyle(
                                color: Color(0xFF777777),
                                fontSize: 9,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
