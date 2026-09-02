import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:super_app/model/chat_model.dart';
import 'package:super_app/providers/chat_provider.dart';

class ChatTapScreen extends StatelessWidget {
  const ChatTapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ChatProvider>();

    return Scaffold(
      backgroundColor: const Color(0xFF121212),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              child: TextField(
                onChanged: (val) =>
                    context.read<ChatProvider>().setSearchQuery(val),
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Search chats...',
                  hintStyle: const TextStyle(color: Colors.white38),
                  prefixIcon: const Icon(Icons.search, color: Colors.white38),
                  filled: true,
                  fillColor: const Color(0xFF1E1E1E),
                  contentPadding: EdgeInsets.symmetric(vertical: 0.h),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),

            SizedBox(height: 12.h),

            // Online Title & Stories List
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Text(
                'Online',
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 12.h),
            _buildStoryList(provider),

            SizedBox(height: 16.h),

            // Chat Items List
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: provider.chats.length,
              itemBuilder: (context, index) {
                final chat = provider.chats[index];
                return _buildChatTile(chat);
              },
            ),

            SizedBox(height: 10.h),

            // // Marketplace Inquiries Title
            // Padding(
            //   padding: EdgeInsets.symmetric(horizontal: 16.w),
            //   child: Text(
            //     'Marketplace Inquiries',
            //     style: TextStyle(
            //       color: Colors.white,
            //       fontSize: 16.sp,
            //       fontWeight: FontWeight.bold,
            //     ),
            //   ),
            // ),
            // SizedBox(height: 20.h),
            _buildMarketplaceInquiries(provider),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }

  // Story List Builder
  Widget _buildStoryList(ChatProvider provider) {
    return SizedBox(
      height: 80.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        itemCount: provider.stories.length + 1, // +1 for "Your Story"
        itemBuilder: (context, index) {
          if (index == 0) {
            return Padding(
              padding: EdgeInsets.only(right: 16.w),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(2.r),
                    decoration: const BoxDecoration(
                      color: Colors.white, // Border အရောင်
                      shape: BoxShape.circle,
                    ),
                    child: CircleAvatar(
                      radius: 24.r,
                      backgroundColor: const Color(0xFFFFC107),
                      child: Icon(Icons.add, color: Colors.black, size: 28.sp),
                    ),
                  ),
                  SizedBox(height: 6.h),
                  Text(
                    'Your Story',
                    style: TextStyle(color: Colors.white70, fontSize: 11.sp),
                  ),
                ],
              ),
            );
          }

          final story = provider.stories[index - 1];
          return Padding(
            padding: EdgeInsets.only(right: 16.w),
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      padding: EdgeInsets.all(2.r),
                      decoration: const BoxDecoration(
                        color: Colors.white, // Border အရောင်
                        shape: BoxShape.circle,
                      ),
                      child: CircleAvatar(
                        radius: 24.r,
                        backgroundImage: AssetImage(story.imageUrl),
                      ),
                    ),
                    if (story.isOnline)
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: CircleAvatar(
                          radius: 6.r,
                          backgroundColor: Colors.green,
                        ),
                      ),
                  ],
                ),
                SizedBox(height: 6.h),
                Text(
                  story.name,
                  style: TextStyle(color: Colors.white70, fontSize: 11.sp),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // Chat Tile Builder
  Widget _buildChatTile(ChatTileModel chat) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 2.h),
      leading: Stack(
        children: [
          CircleAvatar(
            radius: 22.r,
            backgroundColor: const Color(0xFF2C2C2E),
            backgroundImage: chat.avatarUrl != null
                ? AssetImage(chat.avatarUrl!)
                : null,
            child: chat.avatarUrl == null
                ? Text(
                    chat.initials,
                    style: const TextStyle(color: Colors.white),
                  )
                : null,
          ),
          if (chat.isOnline)
            Positioned(
              right: 0,
              bottom: 0,
              child: Container(
                width: 12.w,
                height: 12.h,
                decoration: BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xFF121212), width: 2),
                ),
              ),
            ),
        ],
      ),
      title: Row(
        children: [
          Text(
            chat.name,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 15.sp,
            ),
          ),
          if (chat.isVerified) ...[
            SizedBox(width: 4.w),
            Icon(Icons.check_circle, color: Colors.redAccent, size: 14.sp),
          ],
          if (chat.isShop) ...[
            SizedBox(width: 6.w),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
              decoration: BoxDecoration(
                color: const Color(0xFF0F5A56),
                borderRadius: BorderRadius.circular(4.r),
              ),
              child: Row(
                children: [
                  Icon(Icons.store, color: Colors.greenAccent, size: 10.sp),
                  SizedBox(width: 2.w),
                  Text(
                    'SHOP',
                    style: TextStyle(color: Colors.greenAccent, fontSize: 9.sp),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
      subtitle: Text(
        chat.lastMessage,
        style: TextStyle(color: Colors.white54, fontSize: 13.sp),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            chat.time,
            style: TextStyle(color: Colors.white38, fontSize: 11.sp),
          ),
          SizedBox(height: 4.h),
          if (chat.unreadCount > 0)
            CircleAvatar(
              radius: 9.r,
              backgroundColor: Colors.red,
              child: Text(
                '${chat.unreadCount}',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          else
            SizedBox(height: 18.h),
        ],
      ),
      onTap: () {},
    );
  }

  Widget _buildMarketplaceInquiries(ChatProvider provider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Text(
            'Marketplace Inquiries',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(height: 2.h),

        // Horizontal Inquiry Cards List
        SizedBox(
          height: 165.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            itemCount: provider.inquiries.length,
            itemBuilder: (context, index) {
              final inquiry = provider.inquiries[index];
              return _buildInquiryCard(inquiry);
            },
          ),
        ),
      ],
    );
  }

  // Single Card Item
  Widget _buildInquiryCard(InquiryModel inquiry) {
    return Container(
      width: 260.w,
      margin: EdgeInsets.only(right: 12.w),
      child: Stack(
        children: [
          // Main Dark Background Box
          Container(
            margin: EdgeInsets.only(top: 2.h),
            padding: EdgeInsets.all(12.r),
            decoration: BoxDecoration(
              color: const Color(0xFF1E1E24),
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(color: Colors.white12),
            ),
            child: Column(
              children: [
                // Top Row (Image + Item Info)
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10.r),
                      child: Image.asset(
                        inquiry.itemImageUrl,
                        width: 55.w,
                        height: 55.h,
                        fit: BoxFit.cover,
                        // errorBuilder: (context, error, stackTrace) => Container(
                        //   width: 55.w,
                        //   height: 55.h,
                        //   color: Colors.grey[800],
                        // ),
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            inquiry.itemTitle,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            'Buyer: ${inquiry.buyerName}',
                            style: TextStyle(
                              color: Colors.white54,
                              fontSize: 12.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.h),

                // Inner Quote Text Box
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(10.r),
                  decoration: BoxDecoration(
                    color: const Color(0xFF16161A),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Text(
                    inquiry.inquiryText,
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 11.sp,
                      fontStyle: FontStyle.italic,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),

          // Yellow "New Inquiry" Badge (Top-Right)
          if (inquiry.isNew)
            Positioned(
              right: 0,
              top: 0,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFC107),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(12.r),
                    bottomLeft: Radius.circular(10.r),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.verified_outlined,
                      size: 12.sp,
                      color: Colors.black,
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      'New Inquiry',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 10.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
