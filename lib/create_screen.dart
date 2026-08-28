import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:super_app/extensions/context_extension.dart';
import 'package:super_app/home_screen.dart';
import 'package:super_app/login_screen.dart';
import 'package:super_app/model/interestModel.dart';

class CreateScreen extends StatefulWidget {
  const CreateScreen({super.key});

  @override
  State<CreateScreen> createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  late TapGestureRecognizer _tapRecognizer;
  final PageController _createPageController = PageController();
  int _currentPage = 0;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  final ValueNotifier<bool> obscurePassword = ValueNotifier(true);

  final ValueNotifier<bool> confirnObscurePassword = ValueNotifier(true);
  final ValueNotifier<bool> remember = ValueNotifier(false);

  late final ValueNotifier<DateTime?> selectedDate = ValueNotifier(null);

  String _formatDate(DateTime? date) {
    final List<String> months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    if (date == null) {
      return '01/08/2026';
    }

    final day = date.day.toString().padLeft(2, '0');
    //final month = date.month.toString().padLeft(2, '0');
    final month = months[date.month - 1];
    final year = date.year.toString();

    return '$day/$month/$year';
  }

  void _showCupertinoDatePicker() {
    final isTablet = context.isTablet;
    showModalBottomSheet(
      context: context,
      //showDragHandle: true,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      builder: (BuildContext builder) {
        return Container(
          height: 280.h,
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Bottom Sheet Title
              Text(
                'Choose your birthday',
                style: GoogleFonts.inter(
                  fontSize: isTablet ? 8.sp : 16.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 10.h),

              // Cupertino Wheel Scroll Date Picker
              Expanded(
                child: CupertinoTheme(
                  data: CupertinoThemeData(
                    textTheme: CupertinoTextThemeData(
                      dateTimePickerTextStyle: TextStyle(
                        fontSize: isTablet ? 7.sp : 14.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),

                  child: CupertinoDatePicker(
                    mode: CupertinoDatePickerMode.date,
                    dateOrder: DatePickerDateOrder.dmy,
                    initialDateTime: selectedDate.value ?? DateTime(2000),
                    minimumYear: 1950,
                    maximumYear: DateTime.now().year,
                    onDateTimeChanged: (DateTime newDate) {
                      selectedDate.value = newDate;
                      //Navigator.pop(context);
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  final ValueNotifier<String> selectedGender = ValueNotifier('Male');

  final List<InterestModel> interests = [
    InterestModel(
      title: 'Education',
      imagePath: 'assets/images/education-filled.png',
    ),
    InterestModel(
      title: 'Sports',
      imagePath: 'assets/images/american-football.png',
    ),
    InterestModel(
      title: 'Travel',
      imagePath: 'assets/images/desert-island.png',
    ),
    InterestModel(
      title: 'Entertainment',
      imagePath: 'assets/images/movie-camera.png',
    ),
    InterestModel(title: 'Art', imagePath: 'assets/images/paintbrush.png'),
    InterestModel(
      title: 'Teaching',
      imagePath: 'assets/images/teacher-medium.png',
    ),
    InterestModel(title: 'Animals', imagePath: 'assets/images/baby-chick.png'),
    InterestModel(title: 'Gaming', imagePath: 'assets/images/video-game.png'),
    InterestModel(
      title: 'Life style',
      imagePath: 'assets/images/light-bulb.png',
    ),
  ];
  final ValueNotifier<int> interestsVersion = ValueNotifier(0);
  final ValueNotifier<File?> selectedImage = ValueNotifier(null);
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(ImageSource source) async {
    final XFile? image = await _picker.pickImage(source: source);
    if (image != null && mounted) {
      selectedImage.value = File(image.path);
    }
  }

  late final List<Widget> _pages = [
    createAccountPage(),
    createBirthdayPage(),
    createGenderPage(),
    createInterestsPage(),
    createProfilePicturePage(),
  ];
  @override
  void initState() {
    super.initState();

    _tapRecognizer = TapGestureRecognizer()
      ..onTap = () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      };
  }

  @override
  void dispose() {
    _createPageController.dispose();
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    obscurePassword.dispose();
    confirnObscurePassword.dispose();
    remember.dispose();
    selectedDate.dispose();
    selectedGender.dispose();
    interestsVersion.dispose();
    selectedImage.dispose();
    _tapRecognizer.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentPage < 4) {
      _createPageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    }
  }

  void _goToPreviousPage() {
    if (_currentPage > 0) {
      _createPageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        if (_currentPage > 0) {
          _createPageController.previousPage(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        } else {
          Navigator.of(context).pop();
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: _createPageController,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _pages.length,
                  onPageChanged: (index) {
                    setState(() => _currentPage = index);
                  },
                  itemBuilder: (context, index) => _pages[index],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget createAccountPage() {
    final isTablet = context.isTablet;
    return Center(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: isTablet ? 0.w : 16.w),
        child: Container(
          width: isTablet ? 412.w : double.infinity,
          margin: EdgeInsets.symmetric(horizontal: isTablet ? 70.w : 0.w),
          decoration: BoxDecoration(
            //color: Colors.white,
            borderRadius: BorderRadius.circular(12.r),
          ),
          //child: Container(
          //width: double.infinity,
          //padding: EdgeInsets.fromLTRB(15.w, 55.h, 15.w, 15.h),
          //decoration: BoxDecoration(borderRadius: BorderRadius.circular(12.r)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  'Create Account!',
                  style: GoogleFonts.inter(
                    fontSize: isTablet ? 11.sp : 22.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
              ),

              Center(
                child: Text(
                  'Create new an account to get started and enjoy\n seamless access to our features.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: isTablet ? 6.sp : 12.sp,
                    color: Colors.grey.shade500,
                  ),
                ),
              ),

              SizedBox(height: 18.sp),

              Text(
                'Full Name',
                style: GoogleFonts.roboto(
                  fontSize: isTablet ? 7.sp : 14.sp,
                  color: Colors.grey.shade700,
                ),
              ),

              SizedBox(height: 5.h),

              TextField(
                controller: nameController,
                keyboardType: TextInputType.name,
                style: TextStyle(fontSize: isTablet ? 7.sp : 14.sp),
                decoration: InputDecoration(
                  hintText: 'Full Name',
                  hintStyle: TextStyle(
                    fontSize: isTablet ? 7.sp : 14.sp,
                    color: Colors.grey.shade500,
                  ),
                  prefixIcon: Icon(
                    Icons.person_outlined,
                    size: 24.r,
                    color: Colors.grey.shade500,
                  ),
                  filled: true,
                  fillColor: const Color(0xFFF0F0F5),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 4.h,
                    horizontal: 8.w,
                  ),
                ),
              ),
              SizedBox(height: 18.h),

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

              SizedBox(height: 10.h),

              Text(
                'Password',
                style: GoogleFonts.roboto(
                  fontSize: isTablet ? 7.sp : 14.sp,
                  color: Colors.grey.shade700,
                ),
              ),

              SizedBox(height: 5.h),

              ValueListenableBuilder<bool>(
                valueListenable: obscurePassword,
                builder: (context, isObscured, child) {
                  return TextField(
                    controller: passwordController,
                    obscureText: isObscured,
                    style: TextStyle(fontSize: isTablet ? 7.sp : 14.sp),
                    decoration: InputDecoration(
                      hintText: 'Password',
                      hintStyle: TextStyle(
                        fontSize: isTablet ? 7.sp : 14.sp,
                        color: Colors.grey.shade500,
                      ),
                      prefixIcon: Icon(
                        Icons.lock_outline,
                        size: 24.r,
                        color: Colors.grey.shade500,
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          obscurePassword.value = !isObscured;
                        },
                        icon: Image.asset(
                          isObscured
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
                        borderRadius: BorderRadius.circular(5.r),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 4.h,
                        horizontal: 8.w,
                      ),
                    ),
                  );
                },
              ),
              Text(
                'Confirm Password',
                style: GoogleFonts.roboto(
                  fontSize: isTablet ? 7.sp : 14.sp,
                  color: Colors.grey.shade700,
                ),
              ),

              SizedBox(height: 5.h),

              ValueListenableBuilder<bool>(
                valueListenable: confirnObscurePassword,
                builder: (context, comfirmPass, child) {
                  return TextField(
                    controller: confirmPasswordController,
                    obscureText: comfirmPass,
                    style: TextStyle(fontSize: isTablet ? 7.sp : 14.sp),
                    decoration: InputDecoration(
                      hintText: ' Confirm Password',
                      hintStyle: TextStyle(
                        fontSize: isTablet ? 7.sp : 14.sp,
                        color: Colors.grey.shade500,
                      ),
                      prefixIcon: Icon(
                        Icons.lock_outline,
                        size: 24.r,
                        color: Colors.grey.shade500,
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          confirnObscurePassword.value = !comfirmPass;
                        },
                        icon: Image.asset(
                          comfirmPass
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
                        borderRadius: BorderRadius.circular(5.r),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 4.h,
                        horizontal: 8.w,
                      ),
                    ),
                  );
                },
              ),

              // Align(
              //   alignment: Alignment.centerLeft,
              //   child: TextButton(
              //     onPressed: () {
              //       // Forgot password
              //     },
              //     style: TextButton.styleFrom(
              //       padding: EdgeInsets.zero,
              //       minimumSize: const Size(0, 30),
              //       tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              //     ),
              //     child: Text(
              //       'Your password must have 8 characters at least.',
              //       style: TextStyle(
              //         fontSize: 12,
              //         color: Colors.grey.shade600,
              //       ),
              //     ),
              //   ),
              // ),
              SizedBox(height: 26.h),

              SizedBox(
                width: double.infinity,
                height: 48.h,
                child: ElevatedButton(
                  onPressed: () {
                    _nextPage();
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
                    'Sign Up',
                    style: GoogleFonts.roboto(
                      fontSize: isTablet ? 9.sp : 18.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 12.h),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ValueListenableBuilder<bool>(
                    valueListenable: remember,
                    builder: (context, isRemembered, child) {
                      return SizedBox(
                        width: 24.w,
                        height: 24.h,
                        child: Checkbox(
                          value: isRemembered,
                          activeColor: const Color.fromARGB(255, 53, 2, 42),
                          side: BorderSide(color: Colors.black, width: 1.5.w),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                          onChanged: (value) {
                            remember.value = value ?? false;
                          },
                        ),
                      );
                    },
                  ),

                  SizedBox(width: 8.h),
                  Expanded(
                    child: Text.rich(
                      TextSpan(
                        style: GoogleFonts.roboto(
                          fontSize: isTablet ? 6.sp : 12.sp,
                          color: Colors.black,
                          height: 1.3.h,
                        ),
                        children: [
                          TextSpan(text: 'By continuing, you agree to our '),

                          TextSpan(
                            text: 'Terms & Conditions',
                            style: GoogleFonts.roboto(
                              color: Color(0xFFD02BDD),
                              fontWeight: FontWeight.bold,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                // Terms & Conditions နှိပ်လိုက်ရင် လုပ်ဆောင်လိုသည့် Function ထည့်ပါ
                              },
                          ),

                          TextSpan(text: '\nand '),

                          TextSpan(
                            text: 'Privacy Policy',
                            style: GoogleFonts.roboto(
                              color: Color(0xFFD02BDD),
                              fontWeight: FontWeight.bold,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                // Privacy Policy နှိပ်လိုက်ရင် လုပ်ဆောင်လိုသည့် Function ထည့်ပါ
                              },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15.h),
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
                        fontSize: isTablet ? 8.sp : 16.sp,
                        color: Colors.grey.shade500,
                      ),
                    ),
                  ),

                  Expanded(
                    child: Divider(color: Colors.grey.shade200, thickness: 3),
                  ),
                ],
              ),

              SizedBox(height: 15.h),

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
                      SizedBox(width: 8.h),
                      Text(
                        'Sign in with Google',
                        style: GoogleFonts.roboto(
                          fontSize: isTablet ? 8.sp : 16.sp,
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
                      SizedBox(width: 8.h),
                      Text(
                        'Sign in with Facebook',
                        style: GoogleFonts.roboto(
                          fontSize: isTablet ? 8.sp : 16.sp,
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
                      fontSize: isTablet ? 6.sp : 12.sp,
                      color: Colors.grey.shade500,
                    ),
                    children: [
                      TextSpan(text: "Already have a account?  "),
                      TextSpan(
                        text: 'Sign in',
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
    );
  }

  Widget createBirthdayPage() {
    final isTablet = context.isTablet;
    return Align(
      alignment: Alignment.topCenter,
      child: SingleChildScrollView(
        child: Container(
          width: isTablet ? 412.w : double.infinity,
          margin: EdgeInsets.symmetric(horizontal: isTablet ? 70.w : 16.w),
          decoration: BoxDecoration(
            //color: Colors.white,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      _goToPreviousPage();
                    },
                    icon: Icon(Icons.arrow_back_ios_new, size: 20.r),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),

                  Expanded(
                    child: Center(
                      child: Text(
                        'Sign up',
                        style: TextStyle(
                          fontSize: isTablet ? 12.sp : 24.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(width: 20.w),
                ],
              ),

              SizedBox(height: 20.h),

              // Title
              Text(
                'When’s Your Birthdays',
                style: TextStyle(
                  fontSize: isTablet ? 10.sp : 20.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),

              SizedBox(height: 5.h),

              // Description
              Text(
                'You can choose who can see this form your profile.',
                style: TextStyle(
                  fontSize: isTablet ? 7.sp : 14.sp,
                  color: Colors.grey,
                ),
              ),

              SizedBox(height: 32.h),

              // Date label
              Text(
                'Birth of Date',
                style: TextStyle(
                  fontSize: isTablet ? 8.sp : 16.sp,
                  color: Colors.grey,
                ),
              ),

              SizedBox(height: 8.h),

              // Date field
              GestureDetector(
                //onTap: _selectDate,
                onTap: _showCupertinoDatePicker,
                child: Container(
                  height: 48.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF1F1F6),
                    borderRadius: BorderRadius.circular(7.r),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  child: Row(
                    children: [
                      ValueListenableBuilder<DateTime?>(
                        valueListenable: selectedDate,
                        builder: (context, date, child) {
                          return Text(
                            _formatDate(date),
                            style: TextStyle(
                              fontSize: isTablet ? 7.sp : 14.sp,
                              color: Colors.black,
                            ),
                          );
                        },
                      ),

                      const Spacer(),

                      Icon(
                        Icons.keyboard_arrow_down,
                        size: isTablet ? 12.sp : 24.sp,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 24.h),

              // Continue button
              SizedBox(
                width: double.infinity,
                height: 48.h,
                child: ElevatedButton(
                  onPressed: () {
                    // if (selectedDate == null) {
                    //   return;
                    // }
                    _nextPage();
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
    );
  }

  Widget createGenderPage() {
    final isTablet = context.isTablet;
    return Align(
      alignment: Alignment.topCenter,
      child: SingleChildScrollView(
        child: Container(
          width: isTablet ? 412.w : double.infinity,
          margin: EdgeInsets.symmetric(horizontal: isTablet ? 70.w : 16.w),
          decoration: BoxDecoration(
            //color: Colors.white,
            borderRadius: BorderRadius.circular(12.r),
          ),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      _goToPreviousPage();
                      // Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back_ios_new, size: 20.r),
                    padding: EdgeInsets.zero,
                    constraints: BoxConstraints(),
                  ),

                  Expanded(
                    child: Center(
                      child: Text(
                        'Sign up',
                        style: TextStyle(
                          fontSize: isTablet ? 12.sp : 24.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(width: 20.w),
                ],
              ),

              SizedBox(height: 20.h),

              // Title
              Text(
                'What gender are your?',
                style: TextStyle(
                  fontSize: isTablet ? 10.sp : 20.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),

              SizedBox(height: 5.h),

              // Description
              Text(
                'You can change who can sees your gender on your \n profile later.',
                style: TextStyle(
                  fontSize: isTablet ? 7.sp : 14.sp,
                  color: Colors.grey,
                ),
              ),

              SizedBox(height: 32.h),
              _buildRadioOption('Male'),
              Divider(color: Colors.grey.shade300, height: 1),

              // Radio List Item (Female)
              _buildRadioOption('Female'),
              Divider(color: Colors.grey.shade300, height: 1),

              // Radio List Item (Other)
              _buildRadioOption('Other'),
              Divider(color: Colors.grey.shade300, height: 1),

              SizedBox(height: 8.h),

              // Footer Note
              Text(
                'Select other to choose another gender or if\n you’d rather not say.',
                style: TextStyle(
                  fontSize: isTablet ? 8.sp : 16.sp,
                  color: Colors.grey.shade500,
                ),
              ),

              SizedBox(height: 30.h),
              // Continue button
              SizedBox(
                width: double.infinity,
                height: 48.h,
                child: ElevatedButton(
                  onPressed: () {
                    _nextPage();
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => InterestsScreen(
                    //       birthday: widget.birthday,
                    //       gender: selectedGender,
                    //     ),
                    //   ),
                    // );
                    // Next page
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFD12CDB),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7.r),
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
    );
  }

  Widget _buildRadioOption(String value) {
    final isTablet = context.isTablet;
    return ValueListenableBuilder<String>(
      valueListenable: selectedGender,
      builder: (context, gender, child) {
        return RadioListTile<String>(
          title: Text(
            value,
            style: TextStyle(
              fontSize: isTablet ? 8.sp : 16.sp,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          value: value,
          groupValue: gender,
          activeColor: const Color(0xFFD02BDD),
          controlAffinity: ListTileControlAffinity.trailing,
          contentPadding: EdgeInsets.zero,
          onChanged: (newValue) {
            if (newValue != null) {
              selectedGender.value = newValue;
            }
          },
        );
      },
    );
  }

  Widget createInterestsPage() {
    final isTablet = context.isTablet;
    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
                maxWidth: isTablet ? 412.w : double.infinity,
              ),
              child: IntrinsicHeight(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: isTablet ? 70.w : 16.w,
                  ),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              _goToPreviousPage();
                              // Navigator.pop(context);
                            },
                            icon: Icon(Icons.arrow_back_ios_new, size: 20.r),
                            padding: EdgeInsets.zero,
                            constraints: BoxConstraints(),
                          ),

                          Expanded(
                            child: Center(
                              child: Text(
                                'Sign up',
                                style: TextStyle(
                                  fontSize: isTablet ? 12.sp : 24.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),

                          SizedBox(width: 20.w),
                        ],
                      ),

                      SizedBox(height: 20.h),

                      // Title
                      Text(
                        'Choose your\nInterests',
                        style: GoogleFonts.roboto(
                          fontSize: isTablet ? 24.sp : 48.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          height: 1.15.h,
                        ),
                      ),
                      SizedBox(height: 12.h),

                      // Subtitle
                      Text(
                        'Get better circles recommendations',
                        style: TextStyle(
                          fontSize: isTablet ? 8.sp : 16.sp,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 32.h),

                      // Chips / Badges
                      ValueListenableBuilder<int>(
                        valueListenable: interestsVersion,
                        builder: (context, version, child) {
                          return Wrap(
                            spacing: isTablet ? 5.w : 10.w,
                            runSpacing: isTablet ? 5.w : 10.h,
                            children: interests.map((interest) {
                              return GestureDetector(
                                onTap: () {
                                  interest.isSelected = !interest.isSelected;
                                  interestsVersion.value++;
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: isTablet ? 10.w : 20.w,
                                    vertical: isTablet ? 2.h : 4.h,
                                  ),
                                  decoration: BoxDecoration(
                                    color: interest.isSelected
                                        ? const Color.fromARGB(
                                            255,
                                            223,
                                            220,
                                            220,
                                          )
                                        : Colors.white,
                                    borderRadius: BorderRadius.circular(20.r),
                                    border: Border.all(
                                      color: interest.isSelected
                                          ? const Color(0xFFD02BDD)
                                          : Colors.grey.shade300,
                                      width: 1.2.w,
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Image.asset(
                                        interest.imagePath,
                                        width: 32.w,
                                        height: 32.h,
                                        fit: BoxFit.contain,
                                      ),
                                      SizedBox(width: 8.w),
                                      Text(
                                        interest.title,
                                        style: TextStyle(
                                          fontSize: isTablet ? 8.sp : 16.sp,
                                          fontWeight: FontWeight.w600,
                                          color: interest.isSelected
                                              ? const Color(0xFFD02BDD)
                                              : Colors.black87,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }).toList(),
                          );
                        },
                      ),

                      const Spacer(),
                      SizedBox(height: 20.h),

                      // Bottom Buttons (Skip & Continue)
                      Row(
                        children: [
                          // Skip Button
                          Expanded(
                            child: SizedBox(
                              height: 48.h,
                              child: ElevatedButton(
                                onPressed: () {
                                  _nextPage();
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFFF5F5F5),
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.r),
                                  ),
                                ),
                                child: Text(
                                  'Skip',
                                  style: TextStyle(
                                    fontSize: isTablet ? 7.sp : 15.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 16.sp),

                          // Continue Button
                          Expanded(
                            child: SizedBox(
                              height: 48.h,
                              child: ElevatedButton(
                                onPressed: () {
                                  _nextPage();
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFFD02BDD),
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.r),
                                  ),
                                ),
                                child: Text(
                                  'Continue',
                                  style: TextStyle(
                                    fontSize: isTablet ? 7.sp : 15.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10.h),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget createProfilePicturePage() {
    final isTablet = context.isTablet;
    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
                maxWidth: isTablet ? 412.w : double.infinity,
              ),
              child: IntrinsicHeight(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: isTablet ? 70.w : 16.w,
                  ),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              _goToPreviousPage();
                              // Navigator.pop(context);
                            },
                            icon: Icon(Icons.arrow_back_ios_new, size: 20.r),
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                          ),

                          Expanded(
                            child: Center(
                              child: Text(
                                'Sign up',
                                style: TextStyle(
                                  fontSize: isTablet ? 12.sp : 24.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),

                          SizedBox(width: 20.w),
                        ],
                      ),

                      SizedBox(height: 20.w),

                      // Title
                      Text(
                        'Profile Picture',
                        style: GoogleFonts.roboto(
                          fontSize: isTablet ? 16.sp : 32.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          height: 1.15.h,
                        ),
                      ),

                      SizedBox(height: 12.h),

                      // Subtitle
                      Text(
                        'Add profile picture to get better\n circles connections',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: isTablet ? 8.sp : 16.sp,
                          color: Colors.black,
                        ),
                      ),

                      SizedBox(height: 32.h),
                      // Circle Profile Image Preview
                      ValueListenableBuilder<File?>(
                        valueListenable: selectedImage,
                        builder: (context, image, child) {
                          return Stack(
                            clipBehavior: Clip.none,
                            children: [
                              CircleAvatar(
                                radius: 75.r,
                                backgroundColor: const Color(0xFFE0E0E0),
                                backgroundImage: image != null
                                    ? FileImage(image)
                                    : null,
                                child: image == null
                                    ? Icon(
                                        Icons.person,
                                        size: 90.r,
                                        color: Color(0xFF9E9E9E),
                                      )
                                    : null,
                              ),

                              if (image != null)
                                Positioned(
                                  top: 0,
                                  right: 0,
                                  child: GestureDetector(
                                    onTap: () {
                                      selectedImage.value = null;
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(6.r),
                                      decoration: const BoxDecoration(
                                        color: Colors.black,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(
                                        Icons.close,
                                        size: 20.r,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          );
                        },
                      ),

                      // ValueListenableBuilder<File?>(
                      //   valueListenable: selectedImage,
                      //   builder: (context, image, child) {
                      //     return CircleAvatar(
                      //       radius: 75,
                      //       backgroundColor: const Color(0xFFE0E0E0),
                      //       backgroundImage: image != null
                      //           ? FileImage(image)
                      //           : null,
                      //       child: image == null
                      //           ? const Icon(
                      //               Icons.person,
                      //               size: 90,
                      //               color: Color(0xFF9E9E9E),
                      //             )
                      //           : null,
                      //     );
                      //   },
                      // ),
                      SizedBox(height: 36.h),

                      // 1. Take Photo Button (Purple Filled)
                      SizedBox(
                        width: isTablet ? 125.w : 250.w,
                        height: 48.h,
                        child: ElevatedButton.icon(
                          onPressed: () => _pickImage(ImageSource.camera),
                          icon: Icon(
                            Icons.camera_alt,
                            color: Colors.white,
                            size: 24.r,
                          ),
                          label: Text(
                            'Take Photo',
                            style: TextStyle(
                              fontSize: isTablet ? 8.sp : 16.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFD02BDD),
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.r),
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 14.h),

                      InkWell(
                        onTap: () {
                          _pickImage(ImageSource.gallery);
                        },
                        child: SizedBox(
                          width: isTablet ? 125.w : 250.w,
                          height: 48.h,
                          child: Row(
                            children: [
                              SizedBox(width: isTablet ? 10.w : 40.w),
                              //Icon(Icons.image),
                              Image.asset(
                                'assets/images/gallery.png',
                                width: 24.w,
                                height: 24.h,
                                fit: BoxFit.contain,
                              ),
                              SizedBox(width: isTablet ? 0.w : 5.w),
                              Text(
                                'Import From Gallery',
                                style: TextStyle(
                                  fontSize: isTablet ? 8.sp : 16.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          // child: OutlinedButton.icon(
                          //   onPressed: () => _pickImage(ImageSource.gallery),
                          //   icon: Icon(Icons.image, color: Colors.grey.shade700),
                          //   label: Text(
                          //     'Import From Gallery',
                          //     style: TextStyle(
                          //       fontSize: 16,
                          //       fontWeight: FontWeight.w600,
                          //       color: Colors.black87,
                          //     ),
                          //   ),
                          //   style: OutlinedButton.styleFrom(
                          //     side: BorderSide(
                          //       color: Colors.grey.shade300,
                          //       width: 1.2,
                          //     ),
                          //     shape: RoundedRectangleBorder(
                          //       borderRadius: BorderRadius.circular(30),
                          //     ),
                          //   ),
                          // ),
                        ),
                      ),
                      SizedBox(height: 32.h),
                      const Spacer(),
                      // 3. Bottom Continue Button
                      SizedBox(
                        width: double.infinity,
                        height: 48.h,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomeScreen(),
                              ),
                            );
                            // Continue Logic (e.g., upload photo or go to next page)
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFD02BDD),
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                          ),
                          child: Text(
                            'Continue',
                            style: TextStyle(
                              fontSize: isTablet ? 8.sp : 16.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 12.h),

                      // 4. Bottom Skip Button
                      SizedBox(
                        width: double.infinity,
                        height: 48.h,
                        child: ElevatedButton(
                          onPressed: () {
                            // Skip Logic
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomeScreen(),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFF5F5F5),
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                          ),
                          child: Text(
                            'Skip',
                            style: TextStyle(
                              fontSize: isTablet ? 8.sp : 16.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10.h),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
