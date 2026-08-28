import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:super_app/extensions/context_extension.dart';
import 'package:super_app/login_screen.dart';

class CreateNewPassword extends StatefulWidget {
  const CreateNewPassword({super.key});

  @override
  State<CreateNewPassword> createState() => _CreateNewPasswordState();
}

class _CreateNewPasswordState extends State<CreateNewPassword> {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  bool obscurePassword = true;
  bool confirmObscurePassword = true;
  @override
  void dispose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isTablet = context.isTablet;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: isTablet ? 0.w : 16.w),
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
                  'Create new password',
                  style: TextStyle(
                    fontSize: isTablet ? 10.sp : 20.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                SizedBox(height: 5.h),
                Text(
                  "Enter your new password you always may remember.\nYou password must have 8 characters at least.",
                  style: GoogleFonts.inter(
                    fontSize: isTablet ? 6.sp : 12.sp,
                    color: Colors.grey.shade600,
                    height: 1.2.h,
                  ),
                ),

                SizedBox(height: 24.h),
                Text(
                  'New Password',
                  style: GoogleFonts.roboto(
                    fontSize: isTablet ? 7.sp : 14.sp,
                    color: Colors.grey.shade700,
                  ),
                ),

                SizedBox(height: 5.h),

                TextField(
                  controller: passwordController,
                  obscureText: obscurePassword,
                  style: TextStyle(fontSize: isTablet ? 7.sp : 14.sp),
                  decoration: InputDecoration(
                    hintText: 'New Password',
                    hintStyle: TextStyle(
                      fontSize: isTablet ? 7.sp : 14.sp,
                      color: Colors.grey.shade500,
                    ),
                    suffixIcon: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.cancel),
                          onPressed: () {
                            passwordController.clear();
                          },
                        ),
                        IconButton(
                          icon: Image.asset(
                            obscurePassword
                                ? 'assets/images/humbleicons_eye-close.png'
                                : 'assets/images/carbon_close-filled.png',
                            width: 22.w,
                            height: 22.h,
                            fit: BoxFit.contain,
                          ),
                          onPressed: () {
                            setState(() {
                              obscurePassword = !obscurePassword;
                            });
                          },
                        ),
                      ],
                    ),

                    filled: true,
                    fillColor: const Color(0xFFF0F0F5),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 11.h,
                      horizontal: 8.w,
                    ),
                  ),
                ),
                SizedBox(height: 24.h),
                Text(
                  'Confirm Password',
                  style: GoogleFonts.roboto(
                    fontSize: isTablet ? 7.sp : 14.sp,
                    color: Colors.grey.shade700,
                  ),
                ),

                SizedBox(height: 5.h),

                TextField(
                  controller: confirmPasswordController,
                  obscureText: confirmObscurePassword,
                  style: TextStyle(fontSize: isTablet ? 7.sp : 14.sp),
                  decoration: InputDecoration(
                    hintText: 'Confirm Password',
                    hintStyle: TextStyle(
                      fontSize: isTablet ? 7.sp : 14.sp,
                      color: Colors.grey.shade500,
                    ),
                    suffixIcon: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.cancel),
                          onPressed: () {
                            confirmPasswordController.clear();
                          },
                        ),
                        IconButton(
                          icon: Image.asset(
                            confirmObscurePassword
                                ? 'assets/images/humbleicons_eye-close.png'
                                : 'assets/images/carbon_close-filled.png',
                            width: 22.w,
                            height: 22.h,
                            fit: BoxFit.contain,
                          ),
                          onPressed: () {
                            setState(() {
                              confirmObscurePassword = !confirmObscurePassword;
                            });
                          },
                        ),
                      ],
                    ),

                    filled: true,
                    fillColor: const Color(0xFFF0F0F5),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 11.h,
                      horizontal: 8.w,
                    ),
                  ),
                ),
                SizedBox(height: 5.h),

                // Timer Count Down Text
                SizedBox(height: 30.h),
                SizedBox(
                  width: double.infinity,
                  height: 48.h,
                  child: ElevatedButton(
                    onPressed: () {
                      // if (selectedDate == null) {
                      //   return;
                      // }
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                        (route) => false,
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
                      'Change Password',
                      style: TextStyle(
                        fontSize: isTablet ? 8.sp : 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
