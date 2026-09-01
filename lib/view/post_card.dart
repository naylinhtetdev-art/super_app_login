import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:super_app/model/post_model.dart';
import 'post_image_grid.dart';

class PostCard extends StatelessWidget {
  final PostModel post;
  final VoidCallback? onLike;
  final VoidCallback? onEdit;

  const PostCard({super.key, required this.post, this.onLike, this.onEdit});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 8.h),

      padding: EdgeInsets.only(top: 12.h),

      decoration: BoxDecoration(
        color: const Color(0xFF101116),

        border: Border(
          bottom: BorderSide(color: Colors.white.withOpacity(0.08)),
        ),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          // ======================
          // User Header
          // ======================
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 14.h),

            child: Row(
              children: [
                CircleAvatar(
                  radius: 20.sp,
                  backgroundImage: AssetImage(post.avatar),
                ),

                SizedBox(width: 10.w),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      Text(
                        post.userName,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      SizedBox(height: 2.h),

                      Text(
                        post.timeAgo,
                        style: TextStyle(
                          color: Colors.grey.shade500,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ),

                PopupMenuButton<String>(
                  icon: Icon(Icons.more_vert, color: Colors.grey.shade400),

                  onSelected: (value) {
                    if (value == 'edit') {
                      onEdit?.call();
                    }
                  },

                  itemBuilder: (context) {
                    return const [
                      PopupMenuItem(value: 'edit', child: Text('Edit')),
                    ];
                  },
                ),
              ],
            ),
          ),

          SizedBox(height: 10.h),

          // ======================
          // Post Text
          // ======================
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 14.w),

            child: Text(
              post.text,
              style: TextStyle(
                color: Colors.white,
                fontSize: 14.sp,
                height: 1.5.h,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 14.w),

            child: Text(
              post.hashtags,
              style: TextStyle(
                color: Colors.purple.shade300,
                fontSize: 14.sp,
                height: 1.5.h,
              ),
            ),
          ),

          // ======================
          // Images
          // ======================
          if (post.images.isNotEmpty) PostImageGrid(images: post.images),

          // ======================
          // Actions
          // ======================
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),

            child: Row(
              children: [
                // Like
                InkWell(
                  onTap: onLike,

                  child: Row(
                    children: [
                      Icon(
                        post.isLiked ? Icons.favorite : Icons.favorite_border,

                        color: post.isLiked ? Colors.red : Colors.grey.shade500,

                        size: 19,
                      ),

                      SizedBox(width: 5.w),

                      Text(
                        '${post.likes}',
                        style: TextStyle(
                          color: Colors.grey.shade500,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(width: 18.w),

                // Comment
                Row(
                  children: [
                    Image.asset(
                      'assets/icons/icons-comment.png',
                      width: 19.w,
                      height: 19.h,
                      color: Colors.grey.shade500,
                    ),

                    SizedBox(width: 5.w),

                    Text(
                      '${post.comments}',
                      style: TextStyle(
                        color: Colors.grey.shade500,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),

                SizedBox(width: 18.w),

                // Share
                Row(
                  children: [
                    Image.asset(
                      'assets/icons/icons-share.png',
                      width: 19.w,
                      height: 19.h,
                      color: Colors.grey.shade500,
                    ),

                    SizedBox(width: 5.w),
                    Text(
                      '${post.share}',
                      style: TextStyle(
                        color: Colors.grey.shade500,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),

                Spacer(),

                Row(
                  children: [
                    Icon(
                      Icons.visibility,
                      color: Colors.grey.shade500,
                      size: 20.sp,
                    ),

                    SizedBox(width: 5.w),
                    Text(
                      '${post.views}',
                      style: TextStyle(
                        color: Colors.grey.shade500,
                        fontSize: 12,
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
