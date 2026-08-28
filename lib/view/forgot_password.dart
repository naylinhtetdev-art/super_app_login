import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:super_app/extensions/context_extension.dart';
import 'package:super_app/view/verify_email.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final TextEditingController emailController = TextEditingController();
  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isTablet = context.isTablet;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Container(
            width: isTablet ? 412.w : double.infinity,
            margin: EdgeInsets.symmetric(horizontal: isTablet ? 70.w : 0),
            decoration: BoxDecoration(
              //color: Colors.white,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.arrow_back_ios_new, size: 20.r),
                      padding: EdgeInsets.zero,
                      constraints: BoxConstraints(),
                    ),
                  ],
                ),
                SizedBox(height: 15.h),
                Text(
                  'Forgot Password?',
                  style: TextStyle(
                    fontSize: isTablet ? 10.sp : 20.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                SizedBox(height: 5.h),

                // Description
                Text(
                  'Enter your email to receive OTP code to rerset\n your password.',
                  style: TextStyle(
                    fontSize: isTablet ? 7.sp : 14.sp,
                    color: Colors.grey,
                  ),
                ),

                SizedBox(height: 32.h),
                Text(
                  'Email or Phone Number',
                  style: GoogleFonts.roboto(
                    fontSize: isTablet ? 7.sp : 14.sp,
                    color: Colors.grey.shade700,
                  ),
                ),

                SizedBox(height: 5.h),

                TextField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  style: TextStyle(fontSize: isTablet ? 7.sp : 14.sp),
                  decoration: InputDecoration(
                    hintText: 'Email or Phone number',
                    hintStyle: TextStyle(
                      fontSize: isTablet ? 7.sp : 14.sp,
                      color: Colors.grey.shade500,
                    ),
                    prefixIcon: Icon(
                      Icons.mail_outline,
                      size: 24.r,
                      color: Colors.grey.shade500,
                    ),
                    filled: true,
                    fillColor: const Color(0xFFF0F0F5),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.r),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 4.h,
                      horizontal: 8.w,
                    ),
                  ),
                ),

                SizedBox(height: 30.h),
                SizedBox(
                  width: double.infinity,
                  height: 48.h,
                  child: ElevatedButton(
                    onPressed: () {
                      // if (selectedDate == null) {
                      //   return;
                      // }
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => VerifyEmail()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFD12CDB),
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7),
                      ),
                    ),
                    child: Text(
                      'Continue',
                      style: TextStyle(
                        fontSize: isTablet ? 8.sp : 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
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
