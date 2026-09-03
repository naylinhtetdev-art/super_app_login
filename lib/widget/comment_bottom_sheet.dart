import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:super_app/model/comment_item.dart';

class CommentBottomSheet extends StatefulWidget {
  const CommentBottomSheet({super.key});

  // Bottom Sheet ခေါ်ယူရန် Static Method
  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const CommentBottomSheet(),
    );
  }

  @override
  State<CommentBottomSheet> createState() => _CommentBottomSheetState();
}

class _CommentBottomSheetState extends State<CommentBottomSheet> {
  final TextEditingController _commentController = TextEditingController();

  // Mock Comment Data များ (ပုံပါ UI အတိုင်း)
  final List<CommentItem> _comments = [
    CommentItem(
      userName: 'Thiri Mon',
      avatar:
          'assets/images/user-ellipse-1.png', // သင့် Asset ပုံလမ်းကြောင်း ပြောင်းပေးပါ
      text: 'Sule ဘုရားအနားက ဒီလက်ဖက်ရည်ဆိုင်လေးက တကယ်ကို classic ပဲ။ ☕️✨',
      timeAgo: '2h',
      likes: 12,
      isLiked: true,
      replyCount: 2,
    ),
    CommentItem(
      userName: 'Kyaw Zin',
      avatar: 'assets/images/user-ellipse-2.png',
      text: 'ဟုတ်တယ်ဗျ။ အဲဒီဆိုင်က မနက်စောစောဆို ပိုမိုက်တယ်။',
      timeAgo: '1h',
      badge: 'Local Guide',
      likes: 12,
      isLiked: false,
    ),
    CommentItem(
      userName: 'Thiri Mon',
      avatar: 'assets/images/user-ellipse-1.png',
      text: 'Next time မနက်ပိုင်းသွားကြည့်ရမယ်!\nThanks for the tip.',
      timeAgo: '45m',
      likes: 2,
      isLiked: true,
    ),
    CommentItem(
      userName: 'U Aung',
      avatar: 'assets/images/user-ellipse-2.png',
      text: "What's the exact location? I haven't been there in years.",
      timeAgo: '30m',
      likes: 0,
      isLiked: false,
    ),
  ];

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? const Color(0xFF16161E) : Colors.white;
    final cardBgColor = isDark ? const Color(0xFF1F202B) : Colors.grey.shade100;
    final textColor = Theme.of(context).colorScheme.onSurface;
    final subTextColor = isDark ? Colors.grey.shade400 : Colors.grey.shade600;

    return Container(
      height:
          MediaQuery.of(context).size.height *
          0.8, // Screen ရဲ့ 80% အမြင့်ယူမည်
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      child: Column(
        children: [
          // Drag Handle bar
          SizedBox(height: 10.h),
          Container(
            width: 40.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: Colors.grey.shade600,
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),

          // Header Title
          Padding(
            padding: EdgeInsets.symmetric(vertical: 12.h),
            child: Text(
              'Comments',
              style: TextStyle(
                color: textColor,
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Divider(height: 1, thickness: 0.2),

          // Comment List Section
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(14.w),
              itemCount: _comments.length,
              itemBuilder: (context, index) {
                final comment = _comments[index];
                return _buildCommentCard(
                  comment,
                  cardBgColor,
                  textColor,
                  subTextColor,
                );
              },
            ),
          ),

          // Comment Input Section (Bottom Bar)
          Container(
            padding: EdgeInsets.only(
              left: 12.w,
              right: 12.w,
              top: 8.h,
              bottom: MediaQuery.of(context).viewInsets.bottom + 12.h,
            ),
            decoration: BoxDecoration(
              color: bgColor,
              border: Border(
                top: BorderSide(color: Colors.white.withValues(alpha: 0.05)),
              ),
            ),
            child: Row(
              children: [
                // 1. Image Picker Button (Square with Rounded Corner)
                Container(
                  width: 38.w,
                  height: 38.h,
                  decoration: BoxDecoration(
                    color: const Color(0xFF23232A),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    icon: Icon(
                      Icons.image_outlined,
                      color: Colors.grey.shade400,
                      size: 20.sp,
                    ),
                    onPressed: () {
                      // Image selection logic
                    },
                  ),
                ),
                SizedBox(width: 8.w),

                // 2. Rounded Text Input Field with Emoji Button
                Expanded(
                  child: Container(
                    height: 42.h,
                    padding: EdgeInsets.symmetric(horizontal: 14.w),
                    decoration: BoxDecoration(
                      color: const Color(0xFF23232A),
                      borderRadius: BorderRadius.circular(22.r),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _commentController,
                            style: TextStyle(color: textColor, fontSize: 13.sp),
                            decoration: InputDecoration(
                              hintText: 'Add a comment...',
                              hintStyle: TextStyle(
                                color: Colors.grey.shade500,
                                fontSize: 13.sp,
                              ),
                              border: InputBorder.none,
                              isDense: true,
                              contentPadding: EdgeInsets.zero,
                            ),
                          ),
                        ),
                        // Emoji Button
                        GestureDetector(
                          onTap: () {
                            // Emoji picker logic
                          },
                          child: Icon(
                            Icons.sentiment_satisfied_alt_rounded,
                            color: const Color(
                              0xFFD629E8,
                            ), // Purple Accent Emoji
                            size: 20.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 8.w),

                // 3. Purple Circle Send Button
                Container(
                  width: 42.w,
                  height: 42.h,
                  decoration: const BoxDecoration(
                    color: Color(0xFFC026D3), // Pinkish Purple Color
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    icon: Icon(
                      Icons.send_rounded,
                      color: Colors.white,
                      size: 18.sp,
                    ),
                    onPressed: () {
                      if (_commentController.text.trim().isNotEmpty) {
                        setState(() {
                          _comments.add(
                            CommentItem(
                              userName: 'You',
                              avatar: 'assets/images/user-ellipse-1.png',
                              text: _commentController.text.trim(),
                              timeAgo: 'Just now',
                              likes: 0,
                            ),
                          );
                          _commentController.clear();
                        });
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Comment Item တစ်ခုချင်းစီ၏ UI
  Widget _buildCommentCard(
    CommentItem comment,
    Color cardBgColor,
    Color textColor,
    Color subTextColor,
  ) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // User Avatar
          CircleAvatar(
            radius: 18.r,
            backgroundImage: AssetImage(comment.avatar),
          ),
          SizedBox(width: 10.w),

          // Comment Container + Actions
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Text Bubble (White Bordered Box)
                Container(
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    color: cardBgColor,
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.15),
                      width: 1,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // User Name + Badge + Time
                      Row(
                        children: [
                          Text(
                            comment.userName,
                            style: TextStyle(
                              color: textColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 14.sp,
                            ),
                          ),
                          if (comment.badge != null) ...[
                            SizedBox(width: 6.w),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 6.w,
                                vertical: 2.h,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.amber.shade700,
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.verified_outlined,
                                    size: 10.sp,
                                    color: Colors.black,
                                  ),
                                  SizedBox(width: 2.w),
                                  Text(
                                    comment.badge!,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 9.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                          const Spacer(),
                          Text(
                            comment.timeAgo,
                            style: TextStyle(
                              color: subTextColor,
                              fontSize: 11.sp,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 6.h),

                      // Comment Text
                      Text(
                        comment.text,
                        style: TextStyle(
                          color: textColor.withOpacity(0.9),
                          fontSize: 13.sp,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 6.h),

                // Actions (Reply & Like)
                Row(
                  children: [
                    SizedBox(width: 4.w),
                    GestureDetector(
                      onTap: () {},
                      child: Text(
                        'Reply',
                        style: TextStyle(
                          color: subTextColor,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(width: 14.w),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          comment.isLiked = !comment.isLiked;
                          comment.isLiked ? comment.likes++ : comment.likes--;
                        });
                      },
                      child: Row(
                        children: [
                          Icon(
                            comment.isLiked
                                ? Icons.favorite
                                : Icons.favorite_border,
                            size: 14.sp,
                            color: comment.isLiked ? Colors.red : subTextColor,
                          ),
                          if (comment.likes > 0) ...[
                            SizedBox(width: 4.w),
                            Text(
                              '${comment.likes}',
                              style: TextStyle(
                                color: subTextColor,
                                fontSize: 12.sp,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),

                // View Replies Button
                if (comment.replyCount > 0) ...[
                  SizedBox(height: 6.h),
                  GestureDetector(
                    onTap: () {},
                    child: Row(
                      children: [
                        Icon(
                          Icons.keyboard_arrow_down,
                          size: 16.sp,
                          color: subTextColor,
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          'View ${comment.replyCount} replies',
                          style: TextStyle(
                            color: subTextColor,
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
