import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:super_app/create_screen.dart';
import 'package:super_app/extensions/context_extension.dart';
import 'package:super_app/login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreen();
}

class _RegisterScreen extends State<RegisterScreen> {
  bool showImage = true;

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 1), () {
      if (!mounted) return;

      setState(() {
        showImage = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final isTablet = context.isTablet;
    if (showImage) {
      return Scaffold(
        backgroundColor: Colors.purple,
        body: Container(
          padding: EdgeInsets.all(20.w),
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            image: DecorationImage(
              image: AssetImage('assets/images/splash_image.jpg'),
              fit: BoxFit.cover,
            ),
          ),

          child: Stack(
            children: [
              // OLLIO + Subtitle
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'OLLIO',
                      style: GoogleFonts.inter(
                        fontSize: isTablet ? 48.sp : 96.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 3.w,
                        height: 0.9.h,
                      ),
                    ),

                    SizedBox(height: 1.h),

                    Text(
                      'Connect with your rare soul!',
                      style: GoogleFonts.inter(
                        fontSize: isTablet ? 10.sp : 20.sp,
                        color: Colors.white,
                        height: 0.5.h,
                      ),
                    ),
                  ],
                ),
              ),

              //Bottom
              Positioned(
                bottom: 0.h,
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/profile-image.png',
                      width: 50.sp,
                      height: 50.sp,
                    ),

                    SizedBox(width: 8.w),

                    Text(
                      'Power by\nMingalar Mon',
                      style: TextStyle(
                        fontSize: isTablet ? 7.sp : 14.sp,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }
    return Scaffold(
      backgroundColor: Colors.purple,
      body: Container(
        padding: EdgeInsets.all(20.w),
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          image: DecorationImage(
            image: AssetImage('assets/images/profile-image2.png'),
            fit: BoxFit.cover,
          ),
        ),

        child: Stack(
          children: [
            // OLLIO + Subtitle
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'OLLIO',
                    style: GoogleFonts.inter(
                      fontSize: isTablet ? 48.sp : 96.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 3.w,
                      height: 0.9.h,
                    ),
                  ),

                  SizedBox(height: 1.h),

                  Text(
                    'Connect with your rare soul!',
                    style: GoogleFonts.inter(
                      fontSize: isTablet ? 10.sp : 20.sp,
                      color: Colors.white,
                      height: 0.5.h,
                    ),
                  ),
                ],
              ),
            ),

            Positioned(
              bottom: 30.h,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 45.h,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          ),
                        );
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
                          fontSize: isTablet ? 9.sp : 18.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10.h),
                  SizedBox(
                    width: double.infinity,
                    height: 45.h,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CreateScreen(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                      ),
                      child: Text(
                        'Create a account',
                        style: GoogleFonts.roboto(
                          fontSize: isTablet ? 9.sp : 18.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Bottom
            // Positioned(
            //   bottom: 0.h,
            //   left: 0,
            //   right: 0,
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: [
            //       Image.asset(
            //         'assets/images/profile-image.png',
            //         width: 50.sp,
            //         height: 50.sp,
            //       ),

            //       SizedBox(width: 8.w),

            //       Text(
            //         'Power by\nMingalar Mon',
            //         style: TextStyle(
            //           fontSize: isTablet ? 7.sp : 14.sp,
            //           color: Colors.white,
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
