import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReactionLikeButton extends StatefulWidget {
  final bool isLiked;
  final int likesCount;
  final VoidCallback? onTap;
  final Function(String emoji)? onReactionSelected;

  const ReactionLikeButton({
    super.key,
    required this.isLiked,
    required this.likesCount,
    this.onTap,
    this.onReactionSelected,
  });

  @override
  State<ReactionLikeButton> createState() => _ReactionLikeButtonState();
}

class _ReactionLikeButtonState extends State<ReactionLikeButton> {
  OverlayEntry? _overlayEntry;
  String? selectedReaction;

  final List<String> reactions = ['❤️', '😍', '😂', '❤️‍🔥', '🥺'];

  void _showReactionPopup(BuildContext context) {
    final renderBox = context.findRenderObject() as RenderBox;
    final offset = renderBox.localToGlobal(Offset.zero);

    _overlayEntry = OverlayEntry(
      builder: (context) => Stack(
        children: [
          GestureDetector(
            onTap: _removeOverlay,
            behavior: HitTestBehavior.translucent,
            child: const SizedBox.expand(),
          ),
          Positioned(
            left: offset.dx,
            top: offset.dy - 50.h,
            child: Material(
              color: Colors.transparent,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: const Color(0xFF18191B),
                  borderRadius: BorderRadius.circular(30.r),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 8,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: reactions.map((emoji) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedReaction =
                              emoji; // ရွေးချယ်လိုက်သော Reaction သိမ်းမည်
                        });
                        widget.onReactionSelected?.call(emoji);
                        _removeOverlay();
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 6.w),
                        child: Text(emoji, style: TextStyle(fontSize: 22.sp)),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
        ],
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  void dispose() {
    _removeOverlay();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final subTextColor = Theme.of(context).brightness == Brightness.dark
        ? Colors.grey.shade400
        : Colors.grey.shade600;

    return InkWell(
      onTap: () {
        if (selectedReaction != null || widget.isLiked) {
          // Unlike လုပ်လိုက်ပါက ပြန်ဖျက်မည်
          setState(() {
            selectedReaction = null;
          });
        }
        widget.onTap?.call();
      },
      onLongPress: () => _showReactionPopup(context),
      child: Row(
        children: [
          // Reaction ရွေးထားလျှင် Emoji ပြမည်၊ မဟုတ်ပါက မူလ Heart Icon ပြမည်
          if (selectedReaction != null)
            Text(selectedReaction!, style: TextStyle(fontSize: 18.sp))
          else
            Icon(
              widget.isLiked ? Icons.favorite : Icons.favorite_border,
              color: widget.isLiked ? Colors.red : subTextColor,
              size: 19.sp,
            ),

          SizedBox(width: 5.w),

          Text(
            '${widget.likesCount}',
            style: TextStyle(color: Colors.grey.shade500, fontSize: 12.sp),
          ),
        ],
      ),
    );
  }
}
