import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:super_app/create_screen.dart';
import 'package:super_app/extensions/context_extension.dart';
import 'package:super_app/view/forgot_password.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TapGestureRecognizer _tapRecognizer;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool obscurePassword = true;
  @override
  void initState() {
    super.initState();

    _tapRecognizer = TapGestureRecognizer()
      ..onTap = () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const CreateScreen()),
        );
      };
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    _tapRecognizer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            width: context.isTablet ? 412.w : double.infinity,
            margin: EdgeInsets.symmetric(
              horizontal: context.isTablet ? 70.w : 0,
            ),
            padding: EdgeInsets.fromLTRB(15.w, 75.h, 15.w, 15.h),
            decoration: BoxDecoration(
              //color: Colors.white,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Column(
                    children: [
                      Text(
                        'OLLIO',
                        style: GoogleFonts.inter(
                          fontSize: context.isTablet ? 30.sp : 60.sp,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFFD02BDD),
                          letterSpacing: 3.w,
                          height: 0.9.h,
                        ),
                      ),

                      SizedBox(height: 1.h),
                      Text(
                        "Connect with your rare soul!",
                        style: GoogleFonts.inter(
                          fontSize: context.isTablet ? 7.sp : 14.sp,
                          color: Colors.grey.shade600,
                          height: 0.5.h,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: context.isTablet ? 25.h : 50.h),

                Center(
                  child: Text(
                    'Sign in!',
                    style: GoogleFonts.inter(
                      fontSize: context.isTablet ? 16.sp : 32.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                ),

                SizedBox(height: 1.h),

                Center(
                  child: Text(
                    'Join to reconnect with your rare soul.',
                    style: GoogleFonts.inter(
                      fontSize: context.isTablet ? 6.sp : 12.sp,
                      color: Colors.grey.shade500,
                    ),
                  ),
                ),

                SizedBox(height: 18.h),

                Text(
                  'Email or Phone Number',
                  style: GoogleFonts.roboto(
                    fontSize: context.isTablet ? 7.sp : 14.sp,
                    color: Colors.grey.shade700,
                  ),
                ),

                SizedBox(height: 5.h),

                TextField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  style: TextStyle(fontSize: context.isTablet ? 7.sp : 14.sp),
                  decoration: InputDecoration(
                    hintText: 'Email or Phone number',
                    hintStyle: TextStyle(
                      fontSize: context.isTablet ? 7.sp : 14.sp,
                      color: Colors.grey.shade500,
                    ),
                    prefixIcon: Icon(
                      Icons.mail_outline,
                      size: 24.r,
                      color: Colors.grey.shade600,
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

                SizedBox(height: 10.h),

                Text(
                  'Password',
                  style: GoogleFonts.roboto(
                    fontSize: context.isTablet ? 7.sp : 14.sp,
                    color: Colors.grey.shade700,
                  ),
                ),

                SizedBox(height: 5.h),

                TextField(
                  controller: passwordController,
                  obscureText: obscurePassword,
                  style: TextStyle(fontSize: context.isTablet ? 7.sp : 14.sp),
                  decoration: InputDecoration(
                    hintText: 'Password',
                    hintStyle: TextStyle(
                      fontSize: context.isTablet ? 7.sp : 14.sp,
                      color: Colors.grey.shade500,
                    ),
                    prefixIcon: Icon(
                      Icons.lock_outline,
                      size: 24.r,
                      color: Colors.grey.shade600,
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          obscurePassword = !obscurePassword;
                        });
                      },
                      icon: Image.asset(
                        obscurePassword
                            ? 'assets/images/humbleicons_eye-close.png'
                            : 'assets/images/carbon_close-filled.png',
                        width: 22.w,
                        height: 22.h,
                        fit: BoxFit.contain,
                      ),
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

                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      // Forgot password
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ForgotPassword(),
                        ),
                      );
                    },
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: Size(0.sp, 30.sp),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(
                        fontSize: context.isTablet ? 7.sp : 16.sp,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: context.isTablet ? 7.h : 15.h),

                SizedBox(
                  width: double.infinity,
                  height: 48.h,
                  child: ElevatedButton(
                    onPressed: () {
                      // Login
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFD02BDD),
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                    child: Text(
                      'Sign In',
                      style: GoogleFonts.roboto(
                        fontSize: context.isTablet ? 9.sp : 18.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 16.h),

                Row(
                  children: [
                    Expanded(
                      child: Divider(color: Colors.grey.shade200, thickness: 3),
                    ),

                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.w),
                      child: Text(
                        'Or',
                        style: TextStyle(
                          fontSize: context.isTablet ? 8.sp : 16.sp,
                          color: Colors.grey.shade500,
                        ),
                      ),
                    ),

                    Expanded(
                      child: Divider(color: Colors.grey.shade200, thickness: 3),
                    ),
                  ],
                ),

                SizedBox(height: 16.h),

                SizedBox(
                  width: double.infinity,
                  height: 48.h,
                  child: OutlinedButton(
                    onPressed: () {
                      // Google login
                    },
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: Colors.grey.shade400),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/google.png',
                          width: 24.w,
                          height: 24.h,
                          fit: BoxFit.contain,
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          'Sign in with Google',
                          style: GoogleFonts.roboto(
                            fontSize: context.isTablet ? 8.sp : 16.sp,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 10.h),

                SizedBox(
                  width: double.infinity,
                  height: 48.h,
                  child: OutlinedButton(
                    onPressed: () {
                      // Facebook login
                    },
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: Colors.grey.shade400),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.facebook,
                          size: 26.r,
                          color: Color(0xFF1877F2),
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          'Sign in with Facebook',
                          style: GoogleFonts.roboto(
                            fontSize: context.isTablet ? 8.sp : 16.sp,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 17.h),

                Center(
                  child: RichText(
                    text: TextSpan(
                      style: GoogleFonts.roboto(
                        fontSize: context.isTablet ? 6.sp : 12.sp,
                        color: Colors.grey.shade500,
                      ),
                      children: [
                        const TextSpan(text: "Don't have a account?  "),
                        TextSpan(
                          text: 'Sign up',
                          style: const TextStyle(
                            color: Color(0xFFD02BDD),
                            fontWeight: FontWeight.w600,
                          ),
                          recognizer: _tapRecognizer,
                        ),
                      ],
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
