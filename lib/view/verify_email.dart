import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:super_app/extensions/context_extension.dart';
import 'package:super_app/view/create_new_password.dart';

class VerifyEmail extends StatefulWidget {
  const VerifyEmail({super.key});

  @override
  State<VerifyEmail> createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  late TapGestureRecognizer _tapRecognizer;
  TextEditingController textEditingController = TextEditingController();

  Timer? _timer;
  int _start = 60;
  bool _canResend = false;

  @override
  void initState() {
    super.initState();
    startTimer();
    _tapRecognizer = TapGestureRecognizer()
      ..onTap = () {
        startTimer();
      };
  }

  void startTimer() {
    setState(() {
      _start = 60;
      _canResend = false;
    });
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_start == 0) {
        setState(() {
          _canResend = true;
          timer.cancel();
        });
      } else {
        setState(() {
          _start--;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: context.isTablet ? 0.w : 16.w,
          ),
          child: Container(
            width: context.isTablet ? 412.w : double.infinity,
            margin: EdgeInsets.symmetric(
              horizontal: context.isTablet ? 70.w : 0,
            ),
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
                  'Verify Your Email Address',
                  style: TextStyle(
                    fontSize: context.isTablet ? 10.sp : 20.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                SizedBox(height: 5.h),
                SizedBox(
                  child: RichText(
                    text: TextSpan(
                      style: GoogleFonts.roboto(
                        fontSize: context.isTablet ? 6.sp : 11.sp,
                        color: Colors.black,
                      ),
                      children: [
                        TextSpan(text: "Your OTP will be sent to "),
                        TextSpan(
                          text: 'example@gmail.com',
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w900,
                          ),

                          // recognizer: _tapRecognizer,
                        ),
                        TextSpan(
                          text:
                              "\n Please chack and enter the OTP Below to verify your account",
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 32.h),

                MaterialPinField(
                  length: 6,
                  onCompleted: (pin) => print('PIN: $pin'),
                  onChanged: (value) => print('Changed: $value'),
                  keyboardType: TextInputType.number,
                  theme: MaterialPinTheme(
                    shape: MaterialPinShape.filled,
                    cellSize: context.isTablet
                        ? Size(35.w, 54.h)
                        : Size(50.w, 54.h),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                SizedBox(height: 5.h),
                // Timer Count Down Text
                Align(
                  alignment: Alignment.centerRight,
                  child: _canResend
                      ? RichText(
                          text: TextSpan(
                            style: TextStyle(
                              fontSize: context.isTablet ? 7.sp : 14.sp,
                              color: Colors.grey,
                            ),
                            children: [TextSpan(text: 'OTP Expired ')],
                          ),
                        )
                      : RichText(
                          text: TextSpan(
                            style: TextStyle(
                              fontSize: context.isTablet ? 7.sp : 14.sp,
                              color: Colors.grey,
                            ),
                            children: [
                              TextSpan(text: 'OTP Expired '),
                              TextSpan(
                                text: '${_start}s',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                            ],
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
                        MaterialPageRoute(
                          builder: (context) => CreateNewPassword(),
                        ),
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
                      'Verify',
                      style: TextStyle(
                        fontSize: context.isTablet ? 8.sp : 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                Center(
                  child: RichText(
                    text: TextSpan(
                      style: GoogleFonts.roboto(
                        fontSize: context.isTablet ? 6.sp : 12.sp,
                        color: Colors.black,
                      ),
                      children: [
                        TextSpan(text: "Don't receive OTP?  "),
                        TextSpan(
                          text: 'Resend OTP',
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
