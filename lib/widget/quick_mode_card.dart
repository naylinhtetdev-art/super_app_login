import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class QuickModeCard extends StatelessWidget {
  const QuickModeCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 0.w, vertical: 8.h),
      padding: EdgeInsets.fromLTRB(0.w, 0.h, 0.w, 0.h),
      decoration: BoxDecoration(
        color: Color(0xFF0E393C),
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
              width: 3.w,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 87, 226, 236),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(14.w, 4.h, 14.w, 4.h),

            child: Row(
              children: [
                const Icon(Icons.calendar_today, color: Colors.white, size: 24),

                const SizedBox(width: 7),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Uposatha',
                      style: TextStyle(
                        color: Color.fromARGB(255, 87, 226, 236),
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    SizedBox(height: 4.h),

                    Text(
                      'Today is Uposatha - Quiet mode is on',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.sp,
                        height: 1.4.h,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
