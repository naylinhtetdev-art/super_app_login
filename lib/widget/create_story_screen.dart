import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

class CreateStoryScreen extends StatefulWidget {
  const CreateStoryScreen({super.key});

  @override
  State<CreateStoryScreen> createState() => _CreateStoryScreenState();
}

class _CreateStoryScreenState extends State<CreateStoryScreen> {
  final ImagePicker _picker = ImagePicker();
  File? _selectedImage;
  String _selectedMode = 'Photo';

  Future<void> _takePhoto() async {
    try {
      final XFile? photo = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 90,
      );

      if (photo != null) {
        setState(() {
          _selectedImage = File(photo.path);
        });
      }
    } catch (e) {
      debugPrint('Error taking photo: $e');
    }
  }

  Future<void> _pickFromGallery() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 90,
      );

      if (image != null) {
        setState(() {
          _selectedImage = File(image.path);
        });
      }
    } catch (e) {
      debugPrint('Error picking image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            _selectedImage != null
                ? Positioned.fill(
                    child: Image.file(_selectedImage!, fit: BoxFit.cover),
                  )
                : Center(
                    child: Text(
                      'Tap camera button to capture',
                      style: TextStyle(color: Colors.white54, fontSize: 16.sp),
                    ),
                  ),

            // ၂။ Top Bar (Close Button)
            Positioned(
              top: 16.h,
              left: 16.w,
              right: 16.w,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.close_rounded, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                  if (_selectedImage != null)
                    TextButton(
                      onPressed: () {
                        // TODO: Post Story API Call / Provider Integration
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Share',
                        style: TextStyle(
                          color: const Color(0xFFD629E8),
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                ],
              ),
            ),

            Positioned(
              bottom: 20.h,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Gallery Icon Button
                        GestureDetector(
                          onTap: _pickFromGallery,
                          child: Container(
                            width: 44.w,
                            height: 44.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.r),
                              border: Border.all(color: Colors.white, width: 2),
                              color: Colors.white10,
                            ),
                            child: Icon(
                              Icons.photo_library_rounded,
                              color: Colors.white,
                              size: 20.sp,
                            ),
                          ),
                        ),

                        // Shutter Camera Button
                        GestureDetector(
                          onTap: _takePhoto,
                          child: Container(
                            width: 72.w,
                            height: 72.h,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 4),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(4.r),
                              child: const CircleAvatar(
                                backgroundColor: Colors.white,
                              ),
                            ),
                          ),
                        ),

                        // Retake Image (Clear Selection)
                        _selectedImage != null
                            ? IconButton(
                                icon: Icon(
                                  Icons.refresh_rounded,
                                  color: Colors.white,
                                  size: 28.sp,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _selectedImage = null;
                                  });
                                },
                              )
                            : SizedBox(width: 44.w),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.h),

                  // Mode Selector (Text, Photo, Video)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: ['Text', 'Photo', 'Video'].map((mode) {
                      final isSelected = _selectedMode == mode;
                      return GestureDetector(
                        onTap: () => setState(() => _selectedMode = mode),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12.w),
                          child: Text(
                            mode,
                            style: TextStyle(
                              color: isSelected
                                  ? const Color(0xFFD629E8)
                                  : Colors.grey,
                              fontWeight: isSelected
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                              fontSize: 14.sp,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
