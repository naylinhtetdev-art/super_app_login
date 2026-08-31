import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:super_app/extensions/context_extension.dart';

class QuickTapScreen extends StatelessWidget {
  const QuickTapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isTablet = context.isTablet;
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Quick',
            style: GoogleFonts.inter(
              fontSize: isTablet ? 15.sp : 30.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: 3.w,
              height: 0.9.h,
            ),
          ),
        ],
      ),
    );
  }
}
